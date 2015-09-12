class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.belongs_to :book, null: false
      t.belongs_to :library_member, null: false
      t.datetime :checkout, null: false
      t.datetime :return

      t.timestamps null: false
    end
  end
end
