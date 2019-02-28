class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.references :source
      t.references :destiny
      t.string :external_source_id
      t.string :external_destiny_id
      t.integer :status

      t.timestamps
    end
  end
end
