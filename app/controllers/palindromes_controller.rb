# frozen_string_literal: true

require 'nokogiri'

class PalindromesController < ApplicationController
  before_action :set_palindrome, only: %i[show edit update destroy]
  XSLT_SERVER_TRANSFORM = "#{Rails.root}/public/server_transform.xslt".freeze

  def input; end

  # GET /palindromes or /palindromes.json
  def index
    @palindromes = Palindrome.all
  end

  # GET /palindromes/1 or /palindromes/1.json
  def show
    doc = Nokogiri::XML(@palindrome.output)
    xslt = Nokogiri::XSLT(File.read(XSLT_SERVER_TRANSFORM))
    @view = xslt.transform(doc)
  end

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
    
    palindromes_hash = numbers.each_with_index.map do |number, index| 
      { "palindrome#{index + 1}": { number: number, square: number**2 } }
    end

    output_hash = { result: result, palindromes: palindromes_hash }
    output_hash.to_xml.gsub('hash', 'output').gsub(/<palindrome(\d+)>/, '<palindrome i="\1">')
                       .gsub(/<palindrome>/, '')
                       .gsub(%r{</palindrome(\d+)>}, '')
                       .gsub(%r{</number(\d+)>}, '</number>')
                       .gsub(%r{</square(\d+)>}, '</square>')
  end

  def palindrome?(number)
    number.to_s == number.to_s.reverse
  end
end
