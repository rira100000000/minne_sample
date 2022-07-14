class CommentsController < ApplicationController
  def create
    @suggestion = Suggestion.find(comment_suggestion_id)
    @comment = @suggestion.comments.build comment_params
    @comment.content = comment_body
    @comment.user_id = current_user.id
    
    if @comment.save
      flash[:success] = "コメントしました"
      redirect_to request.referer
    else
      flash[:danger] = "コメントに失敗しました"
      redirect_to request.referer
    end
  end
  
  def uploaded_images
    if !params[:order].nil? && params[:order][:images]
      params[:order][:images].map{|id| ActiveStorage::Blob.find(id)} 
    end
  end
  
  private
    def comment_body
       params.require(:comment)[:body]
    end
    def comment_suggestion_id
       params.require(:comment)[:suggestion_id]
    end
    
    def comment_params
      params.require(:comment).permit(:content, images: []).merge(images: uploaded_images)
    end
    
end
