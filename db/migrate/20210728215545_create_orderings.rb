class CreateOrderings < ActiveRecord::Migration[6.1]
  def change
    create_table :orderings do |t|
      t.integer :total_price, null: false, default: 

      t.timestamps
    end
  end
end
