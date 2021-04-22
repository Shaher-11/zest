class CreatePictures < ActiveRecord::Migration[6.1]
  def change
    create_table :pictures do |t|
      t.bigint :post_id, null: false
      t.string :caption

      t.timestamps
    end
    add_foreign_key :pictures, :posts
  end
end
