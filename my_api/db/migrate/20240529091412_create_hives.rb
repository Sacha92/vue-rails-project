class CreateHives < ActiveRecord::Migration[7.1]
  def change
    create_table :hives do |t|
      t.string :name
      t.decimal :weight

      t.timestamps
    end
    add_index :hives, :name, unique: true
  end
end
