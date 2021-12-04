# frozen_string_literal: true

class CreatePalindromes < ActiveRecord::Migration[6.1]
  def change
    create_table :palindromes do |t|
      t.string :input
      t.text :output

      t.timestamps
    end
    add_index :palindromes, :input, unique: true
  end
end
