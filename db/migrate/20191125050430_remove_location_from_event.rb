class RemoveLocationFromEvent < ActiveRecord::Migration[6.0]
  def change

    remove_column :events, :location, :string
  end
end
