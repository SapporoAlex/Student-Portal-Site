class User < ApplicationRecord
  before_create :set_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :assignments
  has_many :uploads

  # Check if the user is an admin
  def admin?
    role == "admin"
  end

  # Check if the user is a student
  def student?
    role == "student"
  end
  
  def set_default_role
    self.role ||= 'student'  # If role is nil, set it to 'student'
  end
end
