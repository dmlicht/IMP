class AddUserIdToReimbursements < ActiveRecord::Migration
  def change
    add_column :reimbursements, :user_id, :integer
    add_index :reimbursements, :user_id
  end
end
