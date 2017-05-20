# frozen_string_literal: true

# User model
class User < ActiveRecord::Base
  has_secure_password

  include KpJwt::Model

  has_many :flow_charts

  validates :email, presence: true,
            uniqueness: { case_sensitive: false },
            length: { maximum: 50 },
            format: { with: /[\w\-.+]@[a-z\d\-.]+\.[a-z]+/i },
            if: :email_changed?
  validates :password, length: { minimum: 6 }
end
