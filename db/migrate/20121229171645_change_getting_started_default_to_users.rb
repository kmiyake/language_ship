class ChangeGettingStartedDefaultToUsers < ActiveRecord::Migration
  def up
    change_column_default :users, :getting_started, true
  end

  def down
    change_column_default :users, :getting_started, false
  end
end
