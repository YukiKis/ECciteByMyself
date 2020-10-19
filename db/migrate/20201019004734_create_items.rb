class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.integer :category_id
      t.string :name, null: false
      t.string :image_id, null: false
      t.text :description, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true

      t.timestamps
    end
  end
end
