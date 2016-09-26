class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :user, foreign_key: true
      t.datetime :datetime
      t.boolean :private
      t.string :type_of
      t.text :description
      t.string :meeting_point
      t.string :address
      t.integer :time_goal
      t.integer :trail_goal
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
