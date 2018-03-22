class CreateHeros < ActiveRecord::Migration[5.1]
  def change
    create_table :heros do |t|
      t.string :name
      t.integer :atk
      t.integer :hp
      t.integer :def
      t.integer :speed
      t.string :type
      t.belongs_to :user, foreign_key: true

      t.timestamps
    end
  end
end
