class Api::CommentsController < ApplicationController
    def show
        @comment = Comment.find(params[:id])
        reder :show
    end

    def index
        @comments = Comment.all
        render :index
    end

    def create
        @comment = Comment.new(comment_params)
        @comment.user_id = current_user.id
    
        if @comment.save
            render :show
        else
            render json: @comment.errors.full_messages, status: 422
        end
    
    end

  def destroy
    @comment = Comment.find(params[:id])

    if @comment.destroy
      render :index
    else
      render json: @comment.errors.full_messages, status: 404
    end

  end

  private
  def comment_params
    params.require(:comment).permit(:body, :author_id, :video_id)
  end
end
