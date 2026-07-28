use crate::mods::deck;
use crate::mods::card;

pub struct Hand {

    hand_val : usize,
    hand : Vec<card::Card>,
}

impl Hand {

    pub fn new()  -> Self {
        Self {hand: vec![], hand_val: 0}
    }

    pub fn get_val(&self) -> usize {
        self.hand_val
    }

    pub fn hit(&mut self, deck : &mut deck::Deck) {

        let pulled_card = deck.pull_card();

        println!("drew {}", pulled_card.to_string());

        self.hand.push(pulled_card);
        self.sum_hand();

   }

    fn sum_hand(&mut self) {
        let mut sum = 0;

        for i in self.hand.iter() {
            let card_val = i.get_card_val();
            if  card_val == 1 && sum + card_val < 21 {
                sum += 11;
            }
            sum += card_val;

        }

        self.hand_val = sum;
    }

    fn check_bust(&self) -> bool {

        if self.hand_val > 21 {
            return true
        }
        false
    }
}

