# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    redirect_to users_path unless current_user.admin?

    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    return head :forbidden unless current_user.admin?

    @user = User.new(user_params)

    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    user = params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)

    if user[:password].blank? && user[:password_confirmation].blank?
      user = user.except(:password, :password_confirmation)
    end
    user.except(:admin) unless current_user.admin?

    user
  end
end
