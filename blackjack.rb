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
    # enter in code for rules...Players attempt to beat the dealer by getting a count as close to 21 as possible, without going over 21.
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
        puts "BUST!"
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
    puts "Dealer's cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    puts "Dealers total is #{dealer_total}"
    dealer_total
  end

  def dealer_total
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Dealer's total is #{dealer_total}"
    if dealer_total == 21 && dealer.length == 2 && dealer_total > player_total
      puts "Blackjack, dealer wins"
    elsif dealer_total >= 16 && dealer_total == player_total
      puts "Tie - YOU win!"
    elsif dealer_total < 21 && dealer_total > 16 && dealer_total > player_total
      puts "Dealer Wins"
    elsif dealer_total < 16 && dealer_total > player_total
      puts "Dealer Wins"
    elsif dealer_total < 16 && dealer_total < player_total
      dealer_hit
    else
      puts "Dealer busts - YOU win!"
    end
  end

  def dealer_hit
    puts "Dealer takes another card..."
    @dealer << deck.deal
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Dealers total is #{dealer_total}"
    if dealer_total < 21 && dealer.length > 2 && dealer_total > player_total
      puts "Dealer wins"
    elsif dealer_total == 21 && dealer_total == player_total || dealer_total >= 16 && dealer_total == player_total
      puts "Tie - YOU win!"
    elsif dealer_total < 16 && dealer_total < player_total
      dealer_hit
    elsif dealer_total >= 16 && dealer_total < 21 && dealer_total < player_total
      puts "Player beats Dealer - YOU win!"
    else
      puts "Dealer Busts - YOU win!"
    end
  end

  def blackjack
    puts "Dealer's cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    puts "Dealer's total is #{dealer_total}"
    if dealer_total == player_total
      puts "Blackjack Tie - YOU win!"
    else
      puts "Blackjack - YOU win!"
    end
  end

  def reached_max
    puts "You reached 21!"
    puts "Dealer's cards are:"
    dealer.each {|card| puts "#{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    if dealer_total == player_total
      puts "Tie - YOU win!"
    else dealer_total < 16 && dealer_total < player_total
      dealer_hit
    end
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
