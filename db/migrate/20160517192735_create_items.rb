class CreateItems < ActiveRecord::Migration
  def change
  	create_table :items do |t|
  		t.string :name, null: false
  		t.integer :price, null: false
  		t.references :seller, foreign_key: true

  		t.timestamps(null: false)
  	end
  end
end
