class DeleteUsers < ActiveRecord::Migration
  def change
    remove_column :users, :dateOfBirth
  end
end
