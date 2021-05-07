class CreatePokemons < ActiveRecord::Migration[6.1]
  def change
    create_table :pokemons do |t|
      t.string :name
      t.string :type1
      t.string :type2
      t.integer :total
      t.integer :hp
      t.integer :attack
      t.integer :defense
      t.integer :spatk
      t.integer :spdef
      t.integer :speed
      t.integer :generation
      t.boolean :legendary

      t.timestamps
    end
  end
end
