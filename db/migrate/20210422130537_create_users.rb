class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :first_name, null: false
      t.string :last_name
      t.boolean :is_public, null: false, default: true

      t.timestamps
    end
    add_index :users, :username, unique: true
  end
end
