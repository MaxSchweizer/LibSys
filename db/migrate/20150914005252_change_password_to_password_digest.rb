class ChangePasswordToPasswordDigest < ActiveRecord::Migration
  def change
    rename_column :library_members, :password, :password_digest
    rename_column :admins, :password, :password_digest
  end
end
