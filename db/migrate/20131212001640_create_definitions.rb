class CreateDefinitions < ActiveRecord::Migration
  def change
    create_table :definitions do |t|
      t.integer :word_id
      t.string :source
      t.string :text

      t.timestamps
    end
  end
end
