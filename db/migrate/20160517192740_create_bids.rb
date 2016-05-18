class CreateBids < ActiveRecord::Migration
  def change
  	create_table :bids do |t|
  		t.references :item, foreign_key: true
  		t.references :bidder, foreign_key: true

  		t.timestamps(null: false)
  	end
  end
end
