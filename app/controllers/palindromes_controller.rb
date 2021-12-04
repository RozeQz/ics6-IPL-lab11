# frozen_string_literal: true

class PalindromesController < ApplicationController
  before_action :set_palindrome, only: %i[show edit update destroy]

  def input; end

  # GET /palindromes or /palindromes.json
  def index
    @palindromes = Palindrome.all
  end

  # GET /palindromes/1 or /palindromes/1.json
  def show; end

  # GET /palindromes/new
  def new
    @palindrome = Palindrome.new
  end

  # GET /palindromes/1/edit
  def edit; end

  # POST /palindromes or /palindromes.json
  def create
    @palindrome = Palindrome.new(palindrome_params)
    @palindrome.output = make_output(palindrome_params[:input]) if @palindrome.valid?

    respond_to do |format|
      if @palindrome.save
        format.html { redirect_to @palindrome, notice: 'Palindrome was successfully created.' }
        format.json { render :show, status: :created, location: @palindrome }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @palindrome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /palindromes/1 or /palindromes/1.json
  def update
    respond_to do |format|
      if @palindrome.update(palindrome_params)
        format.html { redirect_to @palindrome, notice: 'Palindrome was successfully updated.' }
        format.json { render :show, status: :ok, location: @palindrome }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @palindrome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /palindromes/1 or /palindromes/1.json
  def destroy
    @palindrome.destroy
    respond_to do |format|
      format.html { redirect_to palindromes_url, notice: 'Palindrome was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_palindrome
    @palindrome = Palindrome.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def palindrome_params
    params.require(:palindrome).permit(:input)
  end

  def make_output(input)
    return if input.nil? || input.empty?

    numbers = (0..Integer(input)).select { |i| palindrome?(i * i) }
    result = numbers.size

    # number_hash = numbers.each_with_object({}).with_index(1) { |m, ind| m[1]["palindrome#{ind}"] = m[0] }
    # square_hash = numbers.each_with_object({}).with_index(1) { |m, ind| m[1]["palindrome#{ind}"] = m[0]*m[0] }

    # number_hash = numbers.each_with_object({}).with_index(1) do |m, index|
    #   m[1]["number#{index}"] = m[0] 
    #   m[1]["square#{index}"] = m[0]**2
    # end

    number_hash = numbers.each_with_object({}).with_index(1) do |number, index| 
      number[1]["number#{index}"] = number[0]
      number[1]["square#{index}"] = number[0]
    end

    output_hash = { result: result, palindromes: number_hash }
    output_hash.to_xml.gsub('hash', 'output').gsub(%r{</number(\d)>}, '</number>').gsub(%r{</square(\d)>}, '</square>')
  end

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end
end
