class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.float :cover
      t.string :date
      t.string :location
      t.text :description

      t.timestamps
    end
  end
end
