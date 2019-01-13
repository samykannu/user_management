class Image < ActiveRecord::Base
  mount_uploader :image_upload, ImageUploader

  belongs_to :user
  validates :image_upload, presence: true

end