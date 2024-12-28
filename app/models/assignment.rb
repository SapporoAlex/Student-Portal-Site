class Assignment < ApplicationRecord
  belongs_to :user
  has_many :uploads, dependent: :destroy
  validates :title, :description, :due_date, presence: true
end
