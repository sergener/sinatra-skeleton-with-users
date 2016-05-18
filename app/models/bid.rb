class Bid < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :bidder, class_name: "User"
  belongs_to :item
end
