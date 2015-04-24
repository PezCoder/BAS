class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
    	t.references :product
    	t.references :user

    	t.text "message"
      t.timestamps null: false
    end
    add_index("messages","product_id")
    add_index("messages","user_id")
  end
end
