class Item < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :seller, class_name: "User"
  has_many :bids
  has_many :bidders, through: :bids, source: :user

end
