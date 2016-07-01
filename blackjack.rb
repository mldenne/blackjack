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
    outro
  end

  def intro
    puts "Let's play Blackjack"
    # enter in code for rules...
  end

  def initial_deal
    @dealer << deck.deal
    @dealer << deck.deal
    @player << deck.deal
    @player << deck.deal
  end

  # def card_totals
  #   dealer_total = dealer.inject(0){|sum, card| sum += card.value}
  #   player_total = player.inject(0){|sum, card| sum += card.value}
  # end


  def player_action
    initial_deal
    puts "Dealer shows #{dealer.first.face} of #{dealer.first.suit}"
    puts "You are holding:"
    player.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total
  end

  def player_total
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Your total is #{player_total}"
      if player_total == 21 && player.length == 2
        blackjack
      elsif player_total == 21 && player.length > 2
        reached_max
      elsif player_total > 21
        puts "You bust!"
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
    puts "Dealer shows #{dealer.first.face} of #{dealer.first.suit}"
    puts "You are NOW holding:"
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
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Dealers total is #{dealer_total}"
    if dealer_total == 21 && dealer_total > player_total
      puts "Blackjack, dealer wins"
    elsif dealer_total <=20 && dealer_total > player_total
      puts "Dealer Wins"
    elsif dealer_total <= 16 && dealer_total < player_total
      dealer_hit
    else
      "Dealer busts"
    end
  end

  def dealer_hit
    puts "Dealer takes another card..."
    @dealer << deck.deal
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Dealers total is #{dealer_total}"
    if dealer_total <= 21 && dealer_total > player_total
      puts "Dealer wins"
    elsif dealer_total <= 16 && dealer_total < player_total
      dealer_hit
    else
      "Dealer busts - YOU win!"
    end
  end

  def blackjack
    puts "Blackjack!"
    puts "Dealers cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    puts "Dealers total is #{dealer_total}"
    if dealer_total == player_total
      puts "Tie - player wins!"
    else
      puts "Blackjack - you win!"
    end
    outro
  end

  def reached_max
    puts "You reached 21!"
    puts "Dealers cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    if dealer_total == player_total
      puts "Tie - player wins!"
    elsif dealer_total < player_total
      dealer_hit
    else
      puts
    end
    outro
  end

  def bust
  end

  def outro
    puts "GAME OVER"
    puts "Would you like to play again? (y/n)"
    response = gets.chomp.downcase
    if response == "y"
      Blackjack.new.play
    else
      puts "Thanks for playing!"
  end

end
end


Blackjack.new.play
