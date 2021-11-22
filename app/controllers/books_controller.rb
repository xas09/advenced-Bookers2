class BooksController < ApplicationController
  before_action :ensure_user, only: [:edit, :update, :destroy]
  impressionist :actions => [:show]

  def new
    @books = Book.new
  end

  def create
    @books = Book.new(book_params)
    @book = Book.all
    @books.user_id = current_user.id
    @user = current_user
    if @books.save
    flash[:notice] = "successfully created"
    redirect_to book_path(@books)
    else
      render :index
    end
  end

  def index
    @books = Book.new

    to = Time.current.at_end_of_day
    from = (to-6.day).at_beginning_of_day
    @book = Book.find(Favorite.group(:book_id).where(created_at: from...to).order('count(book_id) desc').pluck(:book_id))
    # @book = Book.includes(:favorited_users).sort {|a,b| 
    #   b.favorited_users.includes(:favorites).where(created_at: from...to).size <=> 
    #   a.favorited_users.includes(:favorites).where(created_at: from...to).size}
    @user = current_user
  end

  def show
    @books = Book.new
    @book = Book.find(params[:id])
    @users = @book.user
    @book_comment = BookComment.new
    impressionist(@book)
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def edit
   @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
    flash[:notice] = "successfully updated"
    redirect_to book_path(@book)
    else
      render :edit
    end
  end

  private

  def ensure_user
    @books = current_user.books
    @book = @books.find_by(id: params[:id])
    redirect_to books_path unless @book
  end
  
  def book_params
    params.require(:book).permit(:title, :body)
  end
  
end
