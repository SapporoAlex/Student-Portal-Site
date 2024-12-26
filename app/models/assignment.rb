class Assignment < ApplicationRecord
  belongs_to :user
  has_one_attached :mpeg_file
  validates :title, :description, :due_date, presence: true
end
