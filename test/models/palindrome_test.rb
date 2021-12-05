# frozen_string_literal: true

require 'test_helper'

class PalindromeTest < ActiveSupport::TestCase
  test 'check that empty input cannot be saved' do
    palindrome = Palindrome.new
    refute palindrome.save # assert_equal palindrome.save, false
  end

  test 'check that invalid input cannot be saved' do
    palindrome = Palindrome.new(input: 'zxcursed')
    refute palindrome.valid?    # assert_equal palindrome.valid?, false
    assert_not_nil palindrome.errors[:input]
    refute palindrome.save
  end

  test 'check that correct input is valid' do
    palindrome = Palindrome.new(input: 10)
    assert palindrome.valid?
  end

  test 'check that duplicated input cannot be saved' do
    palindrome1 = Palindrome.new(input: '10')
    palindrome2 = Palindrome.new(input: '10')
    assert palindrome1.save
    refute palindrome2.save
  end

  test 'check that record can be saved and read' do
    palindrome = Palindrome.new(input: 100)
    assert palindrome.save
    assert Palindrome.find_by(input: 100)
  end
end
