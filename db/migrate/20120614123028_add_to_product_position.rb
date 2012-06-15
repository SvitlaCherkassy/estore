class AddToProductPosition < ActiveRecord::Migration
  def up
    add_column :products, :position, :string
  end

  def down
    remove_column :products, :position
  end
end
