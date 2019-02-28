class CreateAgents < ActiveRecord::Migration[5.2]
  def change
    create_table :agents do |t|
      t.string :name
      t.datetime :last_sync

      t.timestamps
    end
  end
end
