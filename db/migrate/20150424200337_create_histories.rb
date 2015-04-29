class CreateHistories < ActiveRecord::Migration
  def change
    create_table :histories do |t|
      t.float :loan
      t.float :amount_procured
      t.string :needed_for
      t.text :description

      t.timestamps null: false
    end
  end
end
