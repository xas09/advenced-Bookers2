class Message < ApplicationRecord
  belongs_to :user
  belongs_to :chat_room
  
  validates :text, presence: true, length: { maximum: 140 }
end
