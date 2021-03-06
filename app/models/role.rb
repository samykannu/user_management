class Role < ApplicationRecord
	has_many :user_roles
	has_many :roles, through: :user_roles

	scope :active, -> { where(status: 'Active') }
end
