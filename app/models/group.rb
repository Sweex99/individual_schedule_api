class Group < ApplicationRecord
  has_many :users

  has_one_attached :subjects_file
end
