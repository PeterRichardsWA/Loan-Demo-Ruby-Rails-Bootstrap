class FixBorrowersReference < ActiveRecord::Migration
  def change
  	remove_column :borrowers, :history_id
  end
end
