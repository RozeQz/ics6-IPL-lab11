class Palindrome < ApplicationRecord
  validates :input, presence: true, 
            format: { with: /\A\d+\z/, message: 'Please enter only one number' }
end
