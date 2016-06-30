class Card

  attr_accessor :face, :suit, :value

  def self.faces
    %w(2 3 4 5 6 7 8 9 10 J Q K A)
  end

  SUITS = %w(Spades Diamonds Clubs Hearts)

  def initialize(face, suit)
    @face = face
    @suit = suit
    @value = determine_value
  end

  def determine_value
    if face == "A"
      11
    elsif ["J", "Q", "K"].include? face
      10
    else
      face.to_i
    end
  end

end
