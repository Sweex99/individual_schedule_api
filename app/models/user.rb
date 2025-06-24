class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :saml_authenticatable

  has_many :requests
  has_many :notifications

  enum gender: {
    male: 0,
    female: 1,
    other: 2
  }

  def full_name
    "#{last_name} #{first_name}"
  end
end
