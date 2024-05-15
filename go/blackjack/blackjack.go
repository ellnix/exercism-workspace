package blackjack

// ParseCard returns the integer value of a card following blackjack ruleset.
func ParseCard(card string) int {
  switch card {
  case "ace": return 11
  case "two": return 2
  case "three": return 3
  case "four": return 4
  case "five": return 5
  case "six": return 6
  case "seven": return 7
  case "eight": return 8
  case "nine": return 9
  case "joker": return 0
  default: return 10
  }
}

// FirstTurn returns the decision for the first turn, given two cards of the
// player and one card of the dealer.
func FirstTurn(card1, card2, dealerCard string) string {
  hand_value := ParseCard(card1) + ParseCard(card2)

  switch {
  case card1 == "ace" && card2 == "ace": return "P"
  case hand_value == 21 && ParseCard(dealerCard) < 10: return "W"
  case hand_value == 21: return "S"
  case hand_value >= 17 && hand_value <= 20: return "S"
  case hand_value >= 12 && hand_value <= 16 && ParseCard(dealerCard) >= 7: return "H"
  case hand_value >= 12 && hand_value <= 16: return "S"
  default: return "H"
  }
}
