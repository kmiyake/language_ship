class AddNativeLanguageAndLearnLanguageAndMessageToUsers < ActiveRecord::Migration
  def change
    add_column :users, :native_language, :string, :null => false, :default => "ja"
    add_column :users, :learn_language, :string, :null => false, :default => "ja"
    add_column :users, :message, :text
  end
end
