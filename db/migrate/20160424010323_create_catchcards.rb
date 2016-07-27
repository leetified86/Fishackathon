class CreateCatchcards < ActiveRecord::Migration
  def change
    create_table :catchcards do |t|
      t.references :user, index: true, foreign_key: true
      t.references :location, index: true, foreign_key: true
      t.references :fish, index: true, foreign_key: true
      t.string :wild_or_hatchery

      t.timestamps null: false
    end
  end
end
