# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]
  before_action :check_admin, only: %i[create destroy]

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
    update_params = user_params
    if update_params[:password].blank? && update_params[:password_confirmation].blank? &&
       @user.update_without_password(update_params)
      redirect_to @user, notice: 'User was successfully updated.'
    elsif @user.update(update_params)
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

  def check_admin
    head :forbidden unless current_user.admin?
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    permitted_params = %i[name email password password_confirmation]
    permitted_params << :admin if current_user.admin?

    params.require(:user).permit(permitted_params)
  end
end
