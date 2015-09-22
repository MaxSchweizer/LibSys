class MergeAdminsAndLibraryMembersIntoUsersWithSti < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :name
      t.string :password_digest, null: false
      t.string :type, null: false

      t.timestamps null: false
    end
    add_index :users, [:email, :type], unique: true

    drop_table :library_members
    drop_table :admins
  end
end
