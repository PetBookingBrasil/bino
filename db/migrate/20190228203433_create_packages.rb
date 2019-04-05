class CreatePackages < ActiveRecord::Migration[5.2]
  def change
    create_table :packages do |t|
      t.string :source, null: false
      t.string :destiny, null: false
      t.string :external_source_id
      t.string :external_destiny_id
      t.integer :status
      t.integer :type

      t.timestamps
    end
  end
end
