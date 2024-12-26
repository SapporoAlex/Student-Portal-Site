class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments

  # Check if the user is an admin
  def admin?
    role == "admin"
  end

  # Check if the user is a student
  def student?
    role == "student"
  end
end
