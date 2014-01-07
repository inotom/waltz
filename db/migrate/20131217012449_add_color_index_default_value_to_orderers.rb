class AddColorIndexDefaultValueToOrderers < ActiveRecord::Migration
  def change
    change_column(:orderers, :color_index, :integer, default: -1)
  end
end
