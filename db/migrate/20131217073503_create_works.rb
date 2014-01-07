class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.datetime :claim_date
      t.datetime :receipt_date
      t.text     :memo
      t.integer  :orderer_id
      t.integer  :worktype_id
      t.decimal  :quote_amount
      t.decimal  :receipt_amount
      t.text     :other
      t.integer  :year_id

      t.timestamps
    end
    add_index :works, [:year_id, :start_date]
    add_index :works, [:year_id, :end_date]
    add_index :works, [:year_id, :claim_date]
    add_index :works, [:year_id, :receipt_date]
    add_index :works, [:year_id, :orderer_id]
    add_index :works, [:year_id, :worktype_id]
    add_index :works, [:year_id, :quote_amount]
    add_index :works, [:year_id, :receipt_amount]
  end
end
