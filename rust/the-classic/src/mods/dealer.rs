use crate::mods::{deck, hand};

pub struct Dealer {

   name: String,
   hand: hand::Hand,

}


impl Dealer {

    pub fn new() -> Self {

        let dealer_names : Vec<&str> = vec!["Paul", "Pope", "Pope Paul", "Jesus"];
        let random_index = rand::random_range(0..dealer_names.len());

        let name = String::from( dealer_names[random_index] );
        let hand = hand::Hand::new();
        
        Self{ name, hand }
    }

    pub fn hit(&mut self, deck : &mut deck::Deck) {
        print!("{}, drew: ",self.name );
        self.hand.hit(deck);
    }

    pub fn get_val(&self) -> usize {
        self.hand.get_val()
    }

    pub fn play(&mut self, deck : &mut deck::Deck) -> bool {

        let mut cur_val = self.hand.get_val();
        let mut is_bust = false;

        while cur_val < 19 {
            print!("{}, drew: ",self.name );
            self.hand.hit(deck);
            cur_val = self.hand.get_val();
            if cur_val > 21 {
                is_bust = true;
                break;
            }
        }

        is_bust

    }

}
