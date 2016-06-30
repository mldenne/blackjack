require_relative 'deck'

class Blackjack

  attr_accessor :dealer, :player, :deck, :serve

  def initialize
    @dealer = []
    @player = []
    @deck = Deck.new
  end

  def play
    intro
    player_action
    dealer_action
    outro
  end

  def intro
    puts "Let's play Blackjack"
  end

  def initial_deal
    @dealer << deck.deal
    @dealer << deck.deal
    @player << deck.deal
    @player << deck.deal
  end

  def player_action
    initial_deal
    puts "You are holding:"
    player.each do |card|
      puts "#{card.face} #{card.suit}"
    end
    total = 0
    player.each do |value|
      total += card.value
    end
      if total == 21
        puts "Blackjack"
      else
        puts "Hit or Stay (H/S)?"
        response = gets.chomp.downcase
        if response == "h"
          player_hit
        else
          stay
        end
      end
    puts "Hit or Stay (H/S)?"
    response = gets.chomp.downcase
    if response == "h"
      player_hit
    else
      stay
    end
  end

  def player_hit
    @player << deck.deal
    player.each do |card|
      puts "#{card.face} #{card.suit}"
    end
    player.each do |value|
      total += value
    end
      if total == 21
        puts "Blackjack"
      else
        puts "Hit or Stay (H/S)?"
        response = gets.chomp.downcase
        if response == "h"
          player_hit
        else
          stay
        end
      end
  end

  def stay
    dealer_action
  end

  def dealer_action
    puts "Dealers cards are:"
    dealer.each do |car|
      puts "#{card.face} #{card.face}"
    end
    if card_total.dealer == 21
      "Blackjack"
    elsif card_total.dealer < 21
      hit
    else
      "Bust"
    end
  end

  def outro
    if
      puts "#{winner} wins!"
    else
      puts "Bust!"
    end
  end

  def winner
    if card_total.player < card_total.dealer
      "Dealer"
    elsif card_total.dealer < card_total.player
      "Player"
    else
      bust
    end
  end

end

Blackjack.new.play
