class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @book = Book.new
    @user = current_user
  end

  def show
    @book  = Book.new
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
    if current_user.id ==  @user.id
    else
       redirect_to user_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      redirect_to user_path(@user.id)
    else render :edit
  end
end

   private
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end
    private
    def book_params
      params.require(:book).permit(:title, :body)
    end
end