class RemoveRefColLenders < ActiveRecord::Migration
  def change
  	remove_column :lenders, :history_id
  end
end
