class CreateParticipations < ActiveRecord::Migration[5.0]
  def change
    create_table :participations do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true
      t.string :status
      t.integer :running_time
      t.integer :kilometers

      t.timestamps
    end
  end
end
