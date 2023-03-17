class User < ApplicationRecord
  has_secure_password
  has_many :organiser_events, class_name: 'Event', foreign_key: 'user_id'
  has_and_belongs_to_many :events
  has_one :address, as: :addressable
  has_many :likes
end
