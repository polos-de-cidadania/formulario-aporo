# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :validatable, :confirmable, :lockable, :timeoutable, :trackable

  attribute :name

  validates :name, presence: true
end
