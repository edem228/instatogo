module PostsHelper
  def post_owner?
    @post.user == current_user
  end
end
