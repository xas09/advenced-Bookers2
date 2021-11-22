class ChatRoomsController < ApplicationController
  def create
    chat_rooms = current_user.chat_rooms
    chat_rooms.each do |chat_room|
      present = chat_room.entries.where(user_id: params[:user_id]).present?
      if present
      redirect_to chat_room_path(chat_room) and return
      end
    end
    new_chat_room = ChatRoom.new
    if new_chat_room.save
      current_entry = Entry.new(chat_room_id: new_chat_room.id)
      current_entry.user_id = current_user.id
      current_entry.save!
      another_entry = Entry.new(chat_room_id: new_chat_room.id)
      another_entry.user_id = params[:user_id]
      another_entry.save!
      redirect_to chat_room_path(new_chat_room)
    else
      redirect_to user_path(params[:user_id])
    end
  end

  def show
    @chat_room = ChatRoom.find(params[:id])
    @users = @chat_room.users
      @users.each do |user|
        if user != current_user
          @user = user
        end
        break if @user
      end
    @messages = @chat_room.messages
    @message = Message.new
  end
end
