class CreateProfiles < ActiveRecord::Migration[5.1]
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :description
      t.boolean :active

      t.timestamps
    end
  end
end
