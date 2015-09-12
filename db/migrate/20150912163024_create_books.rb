class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :isbn, null: false
      t.string :title
      t.string :description
      t.string :author

      t.timestamps null: false
    end
    add_index :books, :isbn, unique: true
  end
end