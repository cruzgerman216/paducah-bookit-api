class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.string :coverImagePath
      t.string :genre
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end