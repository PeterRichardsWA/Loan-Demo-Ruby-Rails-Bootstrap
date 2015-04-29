class FixHistoryLenderBorrowerReferences < ActiveRecord::Migration
  def change
  	add_reference :histories, :lender, index: true, foreign_key: true
  	add_reference :histories, :borrower, index: true, foreign_key: true
  end
end
