class Assignment < ApplicationRecord
  belongs_to :user
  has_many :uploads
  validates :title, :description, :due_date, presence: true
end
