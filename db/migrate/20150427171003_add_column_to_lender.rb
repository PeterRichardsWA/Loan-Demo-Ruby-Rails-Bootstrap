class AddColumnToLender < ActiveRecord::Migration
  def change
    add_column :lenders, :lendable, :float
  end
end
