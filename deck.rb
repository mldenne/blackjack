require_relative 'card'

class Deck

  attr_accessor :cards

  def initialize
    @cards = []
    Card::SUITS.each do |suit|
      Card.faces.each do |face|
        @cards << Card.new(face, suit)
      end
    end
    @cards.shuffle!
  end

  def deal # Dealer deals from the deck
    cards.shift
  end

end
