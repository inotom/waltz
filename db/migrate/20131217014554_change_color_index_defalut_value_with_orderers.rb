class ChangeColorIndexDefalutValueWithOrderers < ActiveRecord::Migration
  def change
    change_column(:orderers, :color_index, :integer, default: 0)
  end
end
