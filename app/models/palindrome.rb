# frozen_string_literal: true

# Validator model
class MyValidator < ActiveModel::Validator
  def validate(record)
    if record.input.empty?
      record.errors.add :input, 'Пустой ввод'  
      return
    end
    record.errors.add :input, 'Используйте только цифры' if record.input == %r{/\A(\D+)\z/}
  end
end

# Palindrome model
class Palindrome < ApplicationRecord
  validates :input, presence: true, uniqueness: true,
                    format: { with: /\A(\d+)\z/, message: 'Введите только одно число!' }
  validates_with MyValidator, fields: [:input]

  def self.search(search)
    if search
      where(input: search)
    else
      all
    end
  end

  def self.search_id(search)
    select(:id).find_by(input: search) if search
  end
end
