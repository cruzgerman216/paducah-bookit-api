module Books 
    def self.new_book(params, current_user) 
        # STEP 1 - create book and define variable
        book = current_user.books.new(params)
        # STEP 2 - save 
        # book.save!
        # STEP 3 - return errors if book is not valid 
        return ServiceContract.error("Error saving book") unless book.save
        # STEP 4 - otherwise, return success
        ServiceContract.success(book)
    end

    def self.update_book(book_id, params)
        # STEP 1 - get the book we need to update with id
        book = Book.find(book_id)
        # STEP 2 - update
        # STEP 3 - return error if update was unsucessful
        return ServiceContract.error("Book saved unsuccessfully") unless book.update(params)
        # STEP 4 - return success if update was successful
        ServiceContract.success(book)
    end
end