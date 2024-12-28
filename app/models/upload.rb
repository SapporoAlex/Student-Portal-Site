class Upload < ApplicationRecord
  belongs_to :user
  belongs_to :assignment
  
  has_one_attached :file

  # Validations
  validates :user_id, uniqueness: { scope: :assignment_id, message: "You can only upload one file per assignment" }
  validate :file_presence

  def file_presence
    errors.add(:file, "can't be blank") if file.blank?
  end

end
