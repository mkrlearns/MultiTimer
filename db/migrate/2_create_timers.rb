class CreateTimers < ActiveRecord::Migration[6.0]
  def change
    create_table :timers do |t|
      t.integer :seconds
      t.datetime :started
      t.integer :remaining
      t.boolean :running
      t.integer :user_id
    end
  end
end
