class MessagesController < ApplicationController
    def create
        @message = Message.new(message_params)
        @message.chat_room_id = params[:chat_room_id]
        @message.user_id = current_user.id
        if @message.save
            redirect_to chat_room_path(@message.chat_room_id)
        else
            @chat_room = ChatRoom.find(params[:chat_room_id])
            @users = @chat_room.users
              @users.each do |user|
                if user != current_user
                  @user = user
                end
                break if @user
              end
            @messages = @chat_room.messages
            render template: "chat_rooms/show"
        end
    end

private
    def message_params
        params.require(:message).permit(:text)
    end
end
