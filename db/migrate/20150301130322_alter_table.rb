class AlterTable < ActiveRecord::Migration
  def change
  	rename_column('products','type','product_type')
  	add_column('products','can_bid','boolean')
  end
end
