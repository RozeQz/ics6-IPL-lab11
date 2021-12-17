# frozen_string_literal: true

# Palindrome model
class Palindrome < ApplicationRecord
  validates :input, presence: { message: 'Пустой ввод. Введите что-нибудь!' }, uniqueness: true,
                    format: { with: /\A(\d*)\z/, message: 'Введите только одно число!' }

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
