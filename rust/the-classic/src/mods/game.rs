use crate::mods::deck;
use crate::mods::hand;
use crate::mods::dealer;
use std::io;

pub struct BlackJackGame {

    player_bal: i32,
    curr_bet: i32,
    player_hand: hand::Hand,
    dealer: dealer::Dealer,
    deck: deck::Deck,

}

impl BlackJackGame {

    pub fn new(init_player_bal : Option<i32>) -> Self {

        let init_player_bal = init_player_bal.unwrap_or(1000);
        let init_curr_bet = 150;
        let player_hand = hand::Hand::new();
        let deck = deck::Deck::new();
        let dealer = dealer::Dealer::new();

        Self { player_bal: init_player_bal, curr_bet:init_curr_bet, player_hand, dealer, deck }
    }

    pub fn start_game(&mut self, restart : Option<bool>) {

        self.clear_console(None);

        let restart = restart.unwrap_or(false);

        if !restart {
            println!("Welcome to blackjack!");
        }

        println!("What do you wanna do?");
        println!("[P]lay || Set [B]et || anything else to quit");

        let mut input = String::from("");

        io::stdin().read_line(&mut input).unwrap();
        let input = input.trim().to_uppercase();


        match &input[..] {
            "P" => self.play(),
            "B" => self.set_bet(),
            _   => panic!("SG")
        }

    }

    fn play(&mut self) {

        self.player_hand.hit(&mut self.deck);
        self.dealer.hit(&mut self.deck);
        self.player_hand.hit(&mut self.deck);
        self.dealer.hit(&mut self.deck);

        while self.player_hand.get_val() < 21 {

            println!("What do you wanna do?");
            println!("[H]it || [S]tand");

            let mut input = String::from("");

            io::stdin().read_line(&mut input).unwrap();
            let input = input.trim().to_uppercase();


            match &input[..] {
                "H" => self.player_hand.hit(&mut self.deck),
                "S" => break, 
                _   => {}
            }

        }

        self.dealer.play(&mut self.deck);

        self.check_game();

        self.start_game(Some(true));

   }

    fn check_game(&mut self) {

        self.clear_console(Some(false));

        if self.dealer.get_val() > self.player_hand.get_val() {
            println!("Dealer wins!, -{}", self.curr_bet);
            self.player_bal += self.curr_bet;
        }
        else if self.player_hand.get_val() > self.dealer.get_val() {
            println!("Player wins!, {}", self.curr_bet);
            self.player_bal -= self.curr_bet;
        }
        else {
            println!("Draw!");
        }

    }

    fn set_bet(&mut self) {

        self.clear_console(None);

        loop {
            println!("Enter a new amount as a bet: 5 - {}", self.player_bal);

            let mut input = String::from("");

            io::stdin().read_line(&mut input).unwrap();
            let input = input.trim().parse().unwrap_or(-1);

            if input > 5 && input < self.player_bal {
                self.curr_bet = input;
                println!("New bet: {}", self.curr_bet);
                break;
            }

        }
    }

    fn clear_console(&self, print_bal : Option<bool> ) {
        print!("\x1B[2J\x1B[1;1H");
        if print_bal.unwrap_or(true) {
            println!("Current bal: {}", self.player_bal); 
        }
    }
}
