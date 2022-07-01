class CommentsController < ApplicationController
  def create
    @suggestion = Suggestion.find(comment_suggestion_id)
    @comment = @suggestion.comments.new
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
  
  def destroy
  end
  
  private
    def comment_body
       params.require(:comment)[:body]
    end
    def comment_suggestion_id
       params.require(:comment)[:suggestion_id]
    end
  
end
