class ChangeDatetimeToDateToWork < ActiveRecord::Migration
  def change
    change_column :works, :start_date, :date
    change_column :works, :end_date, :date
    change_column :works, :claim_date, :date
    change_column :works, :receipt_date, :date
  end
end
