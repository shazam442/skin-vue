class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.integer :wear, null: false
      t.integer :category, null: false
      t.boolean :stattrak, null: false
      t.boolean :souvenir, null: false

      t.timestamps
    end

    add_index :items, [ :name, :wear, :stattrak, :souvenir ], unique: true
  end
end
