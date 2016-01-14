class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id]) 
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])

  end
end
