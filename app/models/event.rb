class Event < ApplicationRecord
  belongs_to :organiser, class_name: 'User', foreign_key: 'user_id'
  has_and_belongs_to_many :users, join_table: "events_users"
  belongs_to :category
  has_one :comment, as: :commentable
end
