class BookBlueprint < Blueprinter::Base 
    # id of book record
    identifier :id 
    # default values we want to pass 
    fields :title, :coverImagePath, :author, :genre

    view :create do 
        fields :created_at
    end
end