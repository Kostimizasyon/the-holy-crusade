use rand::seq::SliceRandom;
use crate::mods::card;

pub struct Deck {

    deck: Vec<card::Card>,
    card_count: usize,

}

impl Deck {
    
    pub fn new() -> Self {

        let mut deck = vec![];
        let card_count = 52;

        deck.shuffle(&mut rand::rng());

        Self{ deck, card_count}
    }

    pub fn shuffle(&mut self) {
        self.deck.shuffle(&mut rand::rng());
    }

    pub fn pull_card(&mut self) -> card::Card{
        if self.card_count > 1 {
            return self.deck.pop().unwrap();
        }
        card::Card::new(67, card::Faces::Egg)
    }

    pub fn reset_deck(&mut self) {

        self.deck = self.gen_deck();
        self.card_count = self.deck.len();

        self.shuffle();

    }

    fn gen_deck(&self) -> Vec<card::Card> {

        let mut deck: Vec<card::Card> = Vec::with_capacity(52);
        for i in 0..4 {

            let suit = match i {
                0 => card::Faces::Hearts,
                1 => card::Faces::Spades,
                2 => card::Faces::Diamonds,
                3 => card::Faces::Clubs,
                _ => unreachable!("suit index out of range: {}", i),
            };

            for rank in 1..=13 {
                deck.push(card::Card::new(rank.min(10), suit)); // J,Q,K collapse to 10
            }
        }

        deck

    }

}
