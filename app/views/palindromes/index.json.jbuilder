# frozen_string_literal: true

json.array! @palindromes, partial: 'palindromes/palindrome', as: :palindrome
