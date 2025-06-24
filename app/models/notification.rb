class Notification < ApplicationRecord
  belongs_to :user

  def read!
    update!(read: true)
  end
end
