class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.references :user
      t.references :product

      t.string "min_bid",:limit=>7
      t.string "max_bid",:limit=>7
      t.string "value",:limit=>7
      t.timestamps null: false
    end
    add_index("bids","user_id")
    add_index("bids","product_id")
  end

end
