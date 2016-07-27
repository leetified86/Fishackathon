class CreateFish < ActiveRecord::Migration
  def change
    create_table :fish do |t|
      t.string :fish_type

      t.timestamps null: false
    end
  end
end
