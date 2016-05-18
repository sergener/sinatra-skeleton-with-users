class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :bids, foreign_key: "bidder_id"
  has_many :items, through: :bids
  has_many :items_for_sale, class_name: "Item", foreign_key: "seller_id"
end
