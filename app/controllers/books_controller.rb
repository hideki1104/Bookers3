class BooksController < ApplicationController
  before_action :authenticate_user!

  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have creatad book successfully."
        redirect_to book_path(@book.id)
      else
        @user = current_user
        @books = Book.all
        render :index
      end
  end

  def show
    @books = Book.find(params[:id])
    @book = Book.new
    @user = current_user
  end

  def edit
    @book = Book.find(params[:id])
    if current_user.id == @book.user.id
    else redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
    redirect_to book_path(@book.id)
    else
    render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
    def book_params
      params.require(:book).permit(:title, :body)
    end
private
    def user_params
        params.require(:user).permit(:name, :profile_image, :introduction)
    end

end
