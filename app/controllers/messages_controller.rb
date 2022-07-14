class MessagesController < ApplicationController
  def create
    @confirm = Confirm.find(message_confirm_id)
    @message = @confirm.messages.build message_params
    @message.body = message_body
    @message.user_id = current_user.id
    
    if @message.save
      flash[:success] = "メッセージを送信しました"
      redirect_to request.referer
    else
      flash[:danger] = "メッセージ送信に失敗しました"
      redirect_to request.referer
    end
  end
  
def uploaded_images
    if !params[:order].nil? && params[:order][:images]
      params[:order][:images].map{|id| ActiveStorage::Blob.find(id)} 
    end
  end
  
  private
    def message_body
       params.require(:message)[:body]
    end
    def message_confirm_id
       params.require(:message)[:confirm_id]
    end
    
    def message_params
      params.require(:message).permit(:body, images: []).merge(images: uploaded_images)
    end
end


