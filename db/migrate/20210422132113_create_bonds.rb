class CreateBonds < ActiveRecord::Migration[6.1]
  def change
    create_table :bonds do |t|
      t.bigint :user_id, null: false
      t.bigint :friend_id, null: false
      t.string :state, null: false

      t.timestamps
    end
    add_index :bonds, [:user_id, :friend_id], unique: true
    add_foreign_key :bonds, :users, column: :user_id
    add_foreign_key :bonds, :users, column: :friend_id
  end
end
