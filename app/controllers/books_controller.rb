class BooksController < ApplicationController
  before_action :authenticate_user!
  def index
  	@books = Book.all
  	@book = Book.new
  end

  def show
  	@book = Book.find(params[:id])
  	@user = @book.user
  	@books = Book.new
  end

  def edit
  	@book = Book.find(params[:id])
    if @book.user.id != current_user.id
     flash[:alert] = "error"
     redirect_to books_path
    end
  end

  def create
    @books = Book.all
  	@book = Book.new(book_params)
  	@book.user_id = current_user.id
  	if @book.save
     flash[:notice] = "Create was successfully"
  	 redirect_to book_path(@book)
    else
      flash[:alert] = "Create was error"
      render 'index'
    end
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
     flash[:notice] = "Update was successfully"
  	 redirect_to book_path(@book)
    else
     flash.now[:alert] = "Update was error"
     render 'edit'
    end
  end

  def destroy
  	book = Book.find(params[:id])
  	book.destroy
  	redirect_to books_path
  end

  private
   def book_params
  	 params.require(:book).permit(:title,:body)
   end

end
