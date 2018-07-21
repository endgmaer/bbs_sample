class Message < ActiveRecord::Base
  validates :title, presence: true, length: {maximum: 20}
  validates :deletepwd, presence: true, length: {minimum: 6}
  validates :body, presence: true, length: {maximum: 250}
end
