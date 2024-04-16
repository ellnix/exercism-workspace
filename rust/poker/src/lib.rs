use std::{borrow::Borrow, collections::HashMap};

use itertools::Itertools;

#[derive(PartialEq, Eq, PartialOrd, Ord)]
enum Score {
    HighCard(u8, u8, u8, u8, u8),
    OnePair(u8, u8, u8, u8),
    TwoPair(u8, u8, u8),
    ThreeOfAKind(u8, u8, u8),
    Straight(u8),
    Flush(u8, u8, u8, u8, u8),
    FullHouse(u8, u8),
    FourOfAKind(u8, u8),
    StraightFlush(u8),
}

#[derive(PartialEq, Eq, PartialOrd, Ord, Debug)]
enum Suit {
    Hearts,
    Spades,
    Diamonds,
    Clubs,
}

#[derive(PartialEq, Eq, PartialOrd, Ord, Debug)]
struct Card {
    rank: u8,
    suit: Suit,
}

impl From<&str> for Card {
    fn from(value: &str) -> Self {
        let mut chars = value.chars();

        let suit = match chars.next_back() {
            Some('C') => Suit::Clubs,
            Some('D') => Suit::Diamonds,
            Some('S') => Suit::Spades,
            Some('H') => Suit::Hearts,
            _ => unreachable!()
        };

        let rank_string: String = chars.collect();

        let rank: u8 = match rank_string.as_str() {
            "A" => 14,
            "K" => 13,
            "Q" => 12,
            "J" => 11,
            other => other.parse().unwrap(),
        };


        Self { rank, suit }
    }
}

fn get_score(hand: &&str) -> Score {
    let cards: Vec<Card> = hand.split_whitespace().map(|substr| Card::from(substr)).collect();

    find_straight_flush(&cards).or_else(||
        find_four_of_a_kind(&cards)
    ).or_else(||
        find_full_house(&cards)
    ).or_else(||
        find_flush(&cards)
    ).or_else(||
        find_straight(&cards)
    ).or_else(||
        find_three_of_a_kind(&cards)
    ).or_else(||
        find_two_pair(&cards)
    ).or_else(||
        find_one_pair(&cards)
    ).unwrap_or_else(||
        find_high_card(&cards)
    )
}

fn find_straight_flush(cards: &[Card]) -> Option<Score> {
    if cards.iter().map(|c| &c.suit).all_equal() {
        let rank = straight_rank(cards)?;
        Some(Score::StraightFlush(rank))
    } else {
        None
    }
}

fn find_four_of_a_kind(cards: &[Card]) -> Option<Score> {
    let (quadruplet, kicker) = find_pair(cards, 4)?;

    Some(Score::FourOfAKind(quadruplet[0].rank, kicker[0].rank))
}

fn find_full_house(cards: &[Card]) -> Option<Score> {
    let (triplet, kicker) = find_pair(cards, 3)?;
    let (pair, _) = find_pair(&kicker, 2)?;

    Some(Score::FullHouse(triplet[0].rank, pair[0].rank))
}

fn find_flush(cards: &[Card]) -> Option<Score> {
    if cards.iter().map(|c| &c.suit).all_equal() {
        let mut ranks: Vec<_> = cards.iter().map(|c| c.rank).collect();
        ranks.sort();
        let [a, b, c, d, e] = ranks.as_slice() else { panic!() };

        Some(Score::Flush(*e, *d, *c, *b, *a))
    } else {
        None
    }
}

fn find_straight(cards: &[Card]) -> Option<Score> {
    let rank = straight_rank(cards)?;
    Some(Score::Straight(rank))
}

fn straight_rank(cards: &[Card]) -> Option<u8> {
    let mut ranks: Vec<_> = cards.iter().map(|c| c.rank).collect();
    ranks.sort();

    if ranks.iter().enumerate().map(|(i, r)| r - i as u8).all_equal() {
        ranks.last().copied()
    } else {
        let mut ace_one_ranks: Vec<_> = cards.iter().map(|c| c.rank).map(|r| if r == 14 { 1 } else { r }).collect();
        ace_one_ranks.sort();

        if ace_one_ranks.iter().enumerate().map(|(i, r)| r - i as u8).all_equal() {
            Some(5)
        } else {
            None
        }
    }
}

fn find_three_of_a_kind(cards: &[Card]) -> Option<Score> {
    let (triplet, kicker) = find_pair(cards, 3)?;
    let triplet_score = triplet[0].borrow().rank;
    let kicker_ranks: Vec<u8> = kicker.iter().map(|&c| c.borrow().rank).collect();
    let [a, b] = kicker_ranks.as_slice() else { panic!() };
    Some(Score::ThreeOfAKind(triplet_score, *b, *a))
}

fn find_two_pair(cards: &[Card]) -> Option<Score> {
    let (pair1, kicker) = find_pair(cards, 2)?;
    let (pair2, kicker) = find_pair(&kicker, 2)?;

    let mut scores = vec![pair1[0].rank, pair2[0].rank];
    scores.sort();

    Some(Score::TwoPair(scores[1], scores[0], kicker[0].rank))
}

fn find_one_pair(cards: &[Card]) -> Option<Score> {
    let (pair, kicker) = find_pair(cards, 2)?;
    let kicker_ranks: Vec<u8> = kicker.iter().map(|&c| c.borrow().rank).collect();
    let [a, b, c] = kicker_ranks.as_slice() else { panic!() };

    Some(Score::OnePair(max_rank(&pair), *c, *b, *a))
}

fn find_high_card(cards: &[Card]) -> Score {
    let mut ranks: Vec<_> = cards.iter().map(|c| c.rank).collect();
    ranks.sort();
    let [a, b, c, d, e] = ranks.as_slice() else { panic!() };
    Score::HighCard(*e, *d, *c, *b, *a)
}

fn find_pair<C: Borrow<Card> + Ord>(cards: &[C], pair_size: usize) -> Option<(Vec<&C>, Vec<&C>)> {
    let pair = cards.iter().permutations(pair_size).find(|pair| {
        pair.iter().map(|&c| c.borrow().rank).all_equal()
    })?;
    let mut kicker: Vec<_> = cards.iter().filter(|c| !pair.contains(&c)).collect();
    kicker.sort();

    Some((pair, kicker))
}

fn max_rank<C: Borrow<Card>>(cards: &[C]) -> u8 {
    cards.iter().map(|card| card.borrow().rank).max().unwrap()
}

pub fn winning_hands<'a>(hands: &[&'a str]) -> Vec<&'a str> {
    let hands_with_score: HashMap<_, _> = hands.iter().map(|hand| (hand, get_score(hand))).collect();
    let max_score = hands_with_score.iter().map(|(_hand, score)| score).max().unwrap();
    hands_with_score.iter().filter(|(_hand, score)| score == &max_score).map(|(&&hand, _score)| hand).collect()
}
