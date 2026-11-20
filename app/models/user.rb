class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy

  normalizes :email_address, with: ->(e) { e.strip.downcase } # turns inputted email address to lowercase

  validates :display_name,
   presence: true,
   length: { minimum: 2, maximum: 20 }

  validates :email_address,
    presence: true,
    uniqueness: true,
    format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :password,
   presence: true,
   length: { minimum: 8 },
    allow_nil: true
end
