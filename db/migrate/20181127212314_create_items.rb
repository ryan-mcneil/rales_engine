class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      enable_extension :citext
      
      t.references :merchant, foreign_key: true
      t.citext :name
      t.citext :description
      t.integer :unit_price

      t.timestamps
    end
  end
end
