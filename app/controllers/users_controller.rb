class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
  	@users = User.all
  	@book = Book.new
  end

  def show
  	@user = User.find(params[:id])
  	@books = @user.books
  	@book = Book.new
  end

  def edit
  	@user = User.find(params[:id])
  	if @user.id != current_user.id
     flash[:alert] = "error"
  	 redirect_to user_path(current_user)
  	end
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
     flash[:notice] = "Update was successfully"
  	 redirect_to user_path(@user)
  	else
     flash.now[:alert] = "Update was error"
  	 render "edit"
  	end
  end

  private
  def user_params
    params.require(:user).permit(:name,:profile_image,:introduction)
  end
end

