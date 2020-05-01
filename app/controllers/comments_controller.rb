class CommentsController < ApplicationController

    def create 
        id = params[:post_id]
        @post = Post.find(id)
        @comment = Comment.new comment_params
        @comment.post = @post
    
        if @comment.save
            redirect_to post_path(@post)
        else
            @comment = @post.comment.order(created_at: :desc)
            render 'post/show'
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
end
