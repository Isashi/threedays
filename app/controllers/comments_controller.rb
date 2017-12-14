class CommentsController < ApplicationController

def create
  @comment = Comment.new(comment_params)
  @comment.place_id = params[:place_id]
  @comment.user_id = current_user.id

  @comment.save

  redirect_to place_path(@comment.place)
end


def destroy
  Comment.find(params[:id]).destroy
  flash[:success] = "Comment deleted"
  redirect_back(fallback_location: root_path)
end

def comment_params
  params.require(:comment).permit(:body)
end


end
