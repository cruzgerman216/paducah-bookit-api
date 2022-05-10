module Api
  module V1
    class BooksController < Api::V1::ApplicationController
      # create 
      def create 
        # STEP 1 - get a result, result will be either failure or success 
        # create a book
        result = Books.new_book(book_params, @current_user)
        # STEP 2 - return a failure response depending on what result is 
        render_error(errors: "Book was not saved successfully") and return unless result.success?

        # STEP 3 - define a payload 
        payload = {
          book: BookBlueprint.render_as_hash(result.payload)
        }
        # STEP 4 - return a successful response with the payload
        render_success(payload: payload)
      end

      # update 

      def update 
        # STEP 1 - get a result, result will be either failure or success 
        # create a book
        result = Books.update_book(params[:id], book_params)
        # STEP 2 - return a failure response depending on what result is 
        render_error(errors: "Book was not saved successfully") and return unless result.success?

        # STEP 3 - define a payload 
        payload = {
          book: BookBlueprint.render_as_hash(result.payload)
        }
        # STEP 4 - return a successful response with the payload
        render_success(payload: payload)
      end
      
      # delete 
      def destroy 
        book = Book.find(params[:id])
        return render_error(error: "Error in deleting book") unless book.destroy
        render_success(payload: "Destroyed book!") 
      end

      # my books - current user books 
      def my_books 
        render_success(payload: BookBlueprint.render_as_hash(@current_user.books))
      end

      private 
      def book_params 
        params.require(:book).permit(:title, :author, :genre, :coverImagePath)
      end
    end
  end
end
