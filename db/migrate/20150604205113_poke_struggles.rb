class PokeStruggles < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :message
      t.integer :badge, default: 0
      t.timestamps null: false
    end
  end
end

