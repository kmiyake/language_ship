class AddEmailAndGettingStartedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :email, :string
    add_column :users, :getting_started, :boolean, :null => false, :default => false
  end
end
