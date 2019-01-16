class Role < ApplicationRecord
	belongs_to :user
	
	scope :active, -> { where(status: 'Active') }
end
