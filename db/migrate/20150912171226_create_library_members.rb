class CreateLibraryMembers < ActiveRecord::Migration
  def change
    create_table :library_members do |t|
      t.string :email, null: false
      t.string :name
      t.string :password, null: false

      t.timestamps null: false
    end
    add_index :library_members, :email, unique: true
  end
end