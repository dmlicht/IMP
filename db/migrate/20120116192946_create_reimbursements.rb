class CreateReimbursements < ActiveRecord::Migration
  def change
    create_table :reimbursements do |t|
      t.string :title
      t.string :location
      t.string :quantity
      t.string :description
      t.string :status

      t.timestamps
    end
  end
end
