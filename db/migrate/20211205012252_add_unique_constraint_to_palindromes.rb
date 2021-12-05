# frozen_string_literal: true

class AddUniqueConstraintToPalindromes < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      DROP INDEX IF EXISTS index_palindromes_on_input;
      ALTER TABLE "palindromes"
      DROP COLUMN "input";
      ALTER TABLE "palindromes"
      ADD "input" varchar(255) NOT NULL UNIQUE;
    SQL
    add_index :palindromes, :input, unique: true
  end

  def down
    execute <<-SQL
      DROP INDEX IF EXISTS input_index;
      ALTER TABLE "palindromes"
      DROP COLUMN "input";
      ALTER TABLE "palindromes"
      ADD "input" varchar(255);
      CREATE INDEX index_palindromes_on_input ON "palindromes" ("input");
    SQL
  end
end
