# frozen_string_literal: true

require 'test_helper'

class PalindromesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @palindrome = palindromes(:one)
    @controller = PalindromesController.new
    @new_palindrome = Palindrome.new(input: 13)
  end

  test 'should get index' do
    get palindromes_url
    assert_response :success
  end

  test 'should get new' do
    get new_palindrome_url
    assert_response :success
  end

  test 'should show palindrome' do
    get palindrome_url(@palindrome)
    assert_response :success
  end

  test 'should destroy palindrome' do
    assert_difference('Palindrome.count', -1) do
      delete palindrome_url(@palindrome)
    end

    assert_redirected_to palindromes_url
  end

  test 'should get different outputs for different inputs' do
    output1 = @controller.send :make_output, '10'
    output2 = @controller.send :make_output, '11'
    assert_not_equal output1, output2
  end
end
