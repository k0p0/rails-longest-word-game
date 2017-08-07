class GameController < ApplicationController

  require 'open-uri'
  require 'json'
  require 'date'

  @grid = []
  @answer = ""
  @score = 0.0
  @msg = ""
  @time = ""

  def generate
    @grid = Array.new(8) { ('A'..'Z').to_a.sample }
  end

  def score
    @answer = params[:answer]
    @start_time = DateTime.parse(params[:start_time])
    @grid = params[:grid]

    if check_letter?(@answer.upcase, @grid)
      url = "https://wagon-dictionary.herokuapp.com/#{@answer.downcase}"
      word_serialized = open(url).read
      word = JSON.parse(word_serialized)
      @time = (Time.now - @start_time).round(2)
      if word["found"]
        @score = calcul_score(@time, word["length"])
        @msg = "well done"
      else
        @msg = "not an english word"
        @score = 0.0
      end
    else
      @msg = "not in the grid"
      @score = 0.0
    end
  end

private
  def check_letter?(attempt, grid)
    attempt.split("").all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end

  def calcul_score(time, length)
    (length * (1 - (time / 60))).to_f.round(2)
  end

end
