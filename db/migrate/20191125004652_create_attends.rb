class CreateAttends < ActiveRecord::Migration[6.0]
  def change
    create_table :attends do |t|
      t.integer :userID
      t.integer :eventID

      t.timestamps
    end
  end
end
