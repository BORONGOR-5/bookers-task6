class FavoritesController < ApplicationController
    
    def create
        # book = Book.find(params[:book_id])
        @favorite = current_user.favorites.new(book_id: params[:book_id])
        @favorite.save
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        @book = Book.find(params[:book_id])
        @favorite = current_user.favorites.find_by(book_id: @book.id)
        @favorite.destroy
        redirect_back(fallback_location: root_path)
    end
    
    
    # def create
    #     Favorite.create(user_id: current_user.id, book_id: params[:id])
    #     redirect_to user_path
    # end

    # def destroy
    #     Favorite.find_by(user_id: current_user.id, book_id: params[:id]).destroy
    #     redirect_to user_path
    # end
    
    
end
