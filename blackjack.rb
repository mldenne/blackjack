require_relative 'deck'

class Blackjack

  attr_accessor :dealer, :player, :deck

  def initialize
    @dealer = []
    @player = []
    @deck = Deck.new
  end

  def play
    intro
    outro
  end

  def intro
    puts "\n*** Let's play Blackjack! ***"
    puts "\nWould you like to read the rules of the game?"
    puts "Select Y for yes or N for no and hit <Enter>."
    response = gets.chomp.downcase
      if response == "y"
        puts "In this version of Blackjack, the player attempts to beat the dealer by getting a count as close to 21 as possible, without going over 21. In round robin fashion, the dealer deals one round of cards face up and a second round of cards face up to the player and face down to the dealer. Based on the face up card of the dealer and the total of the player's cards, the players determines whether or not to have the dealer deal more cards to increase the total. Aces are worth 11 points, face cards are worth 10, and all other cards are pip value. If the total of the player's cards equals 21, this is a natural Blackjack and no more cards are dealt. If the total is less than 21, the player may 'hit', which means the dealer deal another card, or 'stay', which means the player keeps the cards. The object is to increase the total of the cards to 21 or as close to 21 as possible. If the total of the cards is over 21, the player 'Busts' and loses the game. Once cards are no longer added to the player's hand, the dealer reveals the face down card. Cards are added to the dealer's hand if the dealer's total is less than 16. The game is over when the dealer's cards total 21, there is a tie, the dealer's totals beats the player's total, or the dealer 'busts'. All ties go to the player."
        puts "\nNow to play Blackjack..."
        player_action
      elsif response != "y" && response != "n"
        puts "I do not understand your request."
        puts "Please select either Y or N and hit <Enter> or the game will be played without instruction."
        puts "\nSo...would you like to read the rules of the game?"
        response = gets.chomp.downcase
        if response == "y"
          puts "In this version of Blackjack, the player attempts to beat the dealer by getting a count as close to 21 as possible, without going over 21. In round robin fashion, the dealer deals one round of cards face up and a second round of cards face up to the player and face down to the dealer. Based on the face up card of the dealer and the total of the player's cards, the players determines whether or not to have the dealer deal more cards to increase the total. Aces are worth 11 points, face cards are worth 10, and all other cards are pip value. If the total of the player's cards equals 21, this is a natural Blackjack and no more cards are dealt. If the total is less than 21, the player may 'hit', which means the dealer deal another card, or 'stay', which means the player keeps the cards. The object is to increase the total of the cards to 21 or as close to 21 as possible. If the total of the cards is over 21, the player 'Busts' and loses the game. Once cards are no longer added to the player's hand, the dealer reveals the face down card. Cards are added to the dealer's hand if the dealer's total is less than 16. The game is over when the dealer's cards total 21, there is a tie, the dealer's totals beats the player's total, or the dealer 'busts'. All ties go to the player."
          puts "\nNow to play Blackjack..."
          player_action
        else
          player_action
        end
      else
        player_action
      end
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
    puts "\nDealer shows #{dealer.first.face} of #{dealer.first.suit}"
    puts "You are holding:"
    player.each {|card| puts "   #{card.face} of #{card.suit}"}
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
        puts "\n*** BUST! ***"
      else
        puts "Hit or Stay?"
        puts "Please select H for Hit or S for Stay and hit <Enter>."
        response = gets.chomp.downcase
        if response == "h"
          player_hit
        elsif response != "h" && response != "s"
          puts "I do not understand your selection."
          puts "Please select either H or S and hit <Enter> or the dealer will take over."
          puts "Hit or Stay?"
          response = gets.chomp.downcase
          if response == "h"
            player_hit
          else
            dealer_action
          end
        else
          dealer_action
        end
      end
  end

  def player_hit
    puts "\nDealer shows #{dealer.first.face} of #{dealer.first.suit}"
    puts "You are NOW holding:"
    @player << deck.deal
    player.each {|card| puts "   #{card.face} of #{card.suit}"}
    player_total
  end

  def dealer_action
    dealer_first_total = dealer.inject(0){|sum, card| sum += card.value}
    puts "\nDealer's cards are:"
    dealer.each {|card| puts "   #{card.face} of #{card.suit}"}
    dealer_total
  end

  def dealer_total
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    player_total = player.inject(0){|sum, card| sum += card.value}
    puts "Dealer's total is #{dealer_total}"
    if dealer_total == 21 && dealer.length == 2 && dealer_total > player_total
      puts "\nDealer has Blackjack, dealer wins"
    elsif dealer_total <= 21 && dealer_total > player_total
      puts "\nDealer wins"
    elsif dealer_total >= 16 && dealer_total <= 21 && dealer_total == player_total
      puts "\nTie - YOU win!"
    elsif dealer_total >= 16 && dealer_total < 21 && dealer_total > player_total
      puts "\nDealer wins"
    elsif dealer_total >= 16 && dealer_total < 21 && dealer_total < player_total
      puts "\nYou beat the dealer - YOU win!"
    elsif dealer_total < 16 && dealer_total > player_total
      puts "\nDealer wins"
    elsif dealer_total < 16 && dealer_total < player_total
      dealer_hit
    else
      puts "\nDealer busts - YOU win!"
    end
  end

  def dealer_hit
    puts "\nDealer takes another card..."
    @dealer << deck.deal
    dealer.each {|card| puts "   #{card.face} of #{card.suit}"}
    dealer_total
  end

  def blackjack
    puts "\nDealer's cards are:"
    dealer.each {|card| puts "   #{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    puts "Dealer's total is #{dealer_total}"
    if dealer_total == player_total
      puts "\nBlackjack Tie - YOU win!"
    else
      puts "\nBlackjack - YOU win!"
    end
  end

  def reached_max
    puts "You reached 21! Now let's see what the dealer has..."
    puts "\nDealer's cards are:"
    dealer.each {|card| puts "   #{card.face} of #{card.suit}"}
    player_total = player.inject(0){|sum, card| sum += card.value}
    dealer_total = dealer.inject(0){|sum, card| sum += card.value}
    puts "Dealer's total is #{dealer_total}"
    if dealer_total == player_total
      puts "\nTie - YOU win!"
    elsif dealer_total > player_total
      puts "\nDealer Busts - YOU win!"
    else
      dealer_hit
    end
  end

  def outro
    puts "\n>>> GAME OVER <<<"
    puts "\nWould you like to play again?"
    puts "Select Y for yes or N for no and hit <Enter>."
    response = gets.chomp.downcase
    if response == "y"
      Blackjack.new.play
    elsif response != "y" && response != "n"
      puts "I do not understand your request."
      puts "Please select either Y or N and hit <Enter> or, unfortunately, the game will end."
      puts "\nWould you like to play again?"
      response = gets.chomp.downcase
      if response == "y"
        Blackjack.new.play
      else
        puts "Thanks for playing!"
      end
    else
      puts "Thanks for playing!"
    end
  end
end


Blackjack.new.play
