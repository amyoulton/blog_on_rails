class CommentsController < ApplicationController

    before_action :authenticate_user!
    before_action :authorize!, only: [:destroy]

    def create 
        id = params[:post_id]
        @post = Post.find(id)
        @comment = Comment.new comment_params
        @comment.post = @post
        @comment.user = current_user
        if @comment.save
            redirect_to post_path(@post)
        else
            @comment = @post.comments.order(created_at: :desc)
            redirect_to post_path(@post)
        end
    end

    def destroy 
        @comment = Comment.find params[:id]
        @comment.destroy 
        redirect_to post_path(@comment.post)
    end
    
    def comment_params 
        params.require(:comment).permit(:body)
    end

    private

    def authorize! 
        redirect_to root_path, alert: 'Not Authorized' unless can?(:crud, Comment)
    end

end
