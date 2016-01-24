class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote ]
  before_action :post_owner?, only: [:edit, :update]
  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all.order(:created_at => "DESC")
    respond_to do |format|
      format.html
      format.json { render json: @posts, status: 200}
      format.xml { render xml: @posts, status: 200}
    end
  end
  def new
    @post = current_user.posts.build
  end

  def show
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: "Votre contenu a été bien publié"
    else
      render "new"
    end
  end

  def edit
    
  end

  def update
    if @post.update(post_params)
      redirect_to :post, notice: "Votre contenu a été bien mis à jour"
    else
      render "edit"
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  private

  def post_owner?
    if current_user.id != @post.user_id
      redirect_to :post, notice: "Action interdite! Vous n'êtes pas l'auteur de ce contenu"
    end
  end

  def find_post
    @post = Post.find(params[:id])  
  end

  def post_params
    params.require(:post).permit(:title, :description, :image)
  end
end
