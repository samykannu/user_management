class User < ApplicationRecord
	mount_uploader :image, ImageUploader
	has_many :user_dynamic_columns
	has_many :roles
end
