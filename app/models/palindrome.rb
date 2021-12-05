# frozen_string_literal: true

# validator class model
class MyValidator < ActiveModel::Validator
  def validate(record)
    record.errors.add :input, 'Пустой ввод' if record.input.nil?
  end
end

# palindrome class model
class Palindrome < ApplicationRecord
  validates :input, presence: true, uniqueness: true,
                    format: { with: /\A\d+\z/, message: 'Please enter only one number' }
  validates_with MyValidator, fields: [:input]

  def self.search(search)
    if search
      where(input: search)
    else
      last(50)
    end
  end

  def self.search_id(search)
    select(:id).find_by(input: search) if search
  end
end
