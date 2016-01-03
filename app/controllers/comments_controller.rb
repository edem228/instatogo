class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    @comment.user_id = current_user.id if current_user
    @comment.save
    if @comment.save
      redirect_to post_path(@post), notice: "Votre commentaire a été bien ajouté"
    else
      render "form"
    end
  end

  def edit
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
  end

  def update
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render "edit"
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post), notice: "Le commentaire à été supprimé avec succès"
  end

  private
  def comment_params
    params.require(:comment).permit(:body)
  end
    
end
