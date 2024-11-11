require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    grid_check = @word.upcase.chars.all? { |character| @word.upcase.count(character) <= @letters.count(character) }
    dictionary_check = JSON.parse(URI.parse("https://dictionary.lewagon.com/#{@word}").read)

    if !grid_check && dictionary_check['found'] == false
      @message = "Sorry but <strong>#{@word}</strong> is not in the grid and not an english word"
      @score = 0
    elsif !grid_check
      @message = "Sorry but <strong>#{@word}</strong> cannot be built from #{@letters}"
      @score = 0
    elsif dictionary_check['found'] == false
      @message = "Sorry but <strong>#{@word}</strong> doesn't seem to be a valid English word"
      @score = 0
    else
      @message = 'Well done!!'
      @score = (@word.length * 10)
    end
  end
end
