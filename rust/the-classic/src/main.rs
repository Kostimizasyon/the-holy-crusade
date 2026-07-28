mod mods;
use mods::game;

fn main() {
  
    let mut game = game::BlackJackGame::new(None);
    
    game.start_game(None);
}

