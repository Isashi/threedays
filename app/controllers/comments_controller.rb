class CommentsController < ApplicationController

def create
  @comment = Comment.new(comment_params)
  @comment.place_id = params[:place_id]
  @comment.user_id = current_user.id

  @comment.save

  redirect_to place_path(@comment.place)
end

def comment_params
  params.require(:comment).permit(:body)
end


end
