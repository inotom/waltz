class AddNameAndRemoveOtherToWork < ActiveRecord::Migration
  def change
    remove_column :works, :other
    add_column :works, :title, :string
  end
end
