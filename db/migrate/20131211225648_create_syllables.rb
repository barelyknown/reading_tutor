class CreateSyllables < ActiveRecord::Migration
  def change
    create_table :syllables do |t|
      t.integer :sequence
      t.string :letters
      t.string :stress

      t.timestamps
    end
  end
end
