class SearchController < ApplicationController
  def search
    @search = params[:name]
    if params[:name].present?
      if params[:model] == "1"
        if params[:searched] == "1"
         @users = User.where('name LIKE ?', "#{params[:name]}")
        elsif params[:searched] == "2"
          @users = User.where('name LIKE ?', "#{params[:name]}%")
        elsif params[:searched] == "3"
          @users = User.where('name LIKE ?', "%#{params[:name]}")
        elsif params[:searched] == "4"
          @users = User.where('name LIKE ?', "%#{params[:name]}%")
        end
        render 'users/index_search'
      elsif params[:model] == "2"
        if params[:searched] == "1"
         @books = Book.where('title LIKE ?', "#{params[:name]}")
        elsif params[:searched] == "2"
          @books = Book.where('title LIKE ?', "#{params[:name]}%")
        elsif params[:searched] == "3"
          @books = Book.where('title LIKE ?', "%#{params[:name]}")
        elsif params[:searched] == "4"
          @books = Book.where('title LIKE ?', "%#{params[:name]}%")
        end
        @book = Book.new 
        render 'books/index_search'
      end
    else
      if params[:model] == "1"
        @users = []
        render 'users/index_search'
      elsif params[:model] == "2"
        @books = []
        render 'books/index_search'
      end
    end
  end
end
