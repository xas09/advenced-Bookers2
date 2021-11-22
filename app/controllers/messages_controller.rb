class MessagesController < ApplicationController
    def create
        message = Message.new(message_params)
        message.chat_room_id = params[:chat_room_id]
        message.user_id = current_user.id
        message.save!
        redirect_to chat_room_path(message.chat_room_id)
    end

private
    def message_params
        params.require(:message).permit(:text)
    end
end
