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
    player.each {|card| puts "#{card.face} of #{card.suit}"}
    puts "Dealer shows " #dealer.first #{card.face} of #{card.suit}
    player_total
  end

  def player_total
    player_total = player.inject(0){|sum, x| sum += x.value}
    puts "Your total is #{player_total}"
      if player_total == 21 # and only 2 cards
        puts "Blackjack"
        # end game - show dealer cards, ask for new game
      elsif player_total == 21 # with 3 cards
        puts "You reached 21"
      elsif player_total > 21
        puts "Bust" #need method for Bust
      else
        puts "Hit or Stay (h/s)?"
        response = gets.chomp.downcase
        if response == "h"
          player_hit
        else
          dealer_action
        end
      end
  end

  def player_hit
    @player << deck.deal
    player.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total
  end

  def dealer_action
    puts "Dealers cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    dealer_total
  end

  def dealer_total
    dealer_total = dealer.inject(0){|sum, x| sum += x.value}
    puts "Dealers total is #{dealer_total}"
    if dealer_total == 21 && dealer_total > player_total
      puts "Blackjack, dealer wins"
    elsif dealer_total > player_total
      puts "Dealer wins"
    elsif dealer_total < 16 && dealer_total < player_total
      dealer_hit
    else
      "Bust"
    end
  end

  def dealer_hit
    @dealer << deck.deal
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    dealer_total = dealer.inject(0){|sum, x| sum += x.value}
    if dealer_total <= 21 && dealer_total > player_total
      puts "Dealer wins"
    elsif dealer_total > player_total
      puts "Dealer wins"
    elsif dealer_total < 16 && dealer_total < player_total
      dealer_hit
    else
      "Bust"
    end
  end

  def outro
  end

end


Blackjack.new.play
