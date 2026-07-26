const deckValues = ["A", 2, 3, 4, 5, 6, 7, 8, 9, "J", "K", "Q"];
const deckSuites = ["Spades", "Hearts", "Club", "Diamond"];

class Card {

	#value = 0;
	#suite = "";

	constructor(value, suite) {
		this.#value = value;
		this.#suite = suite;
	}

	getCardValue(currHand) {
		switch(this.#value) {
			case "Q":
			case "K":
			 return 10;
			case "A":
			case "J":
			 return ( currHand + 11 > 21 ? 1 : 11 );
			default:
			 return Number(this.#value);
	        }
	}
}

class Deck {

	static deck = [];

	constructor() {
		Deck.genNewDeck();
	}

	static drawCard() {
		const ind = Math.floor(Math.random() * Deck.deck.length);
		const drawnCard = Deck.deck[ind];
		Deck.deck.splice(ind, 1);
		return drawnCard;
	}

	static genNewDeck() {
		Deck.deck = [];
		for (let i = 0 ; i < deckSuites.length ; i++) {
			
			for (let j = 0 ; j < deckValues.length ; j++) {
				const card = new Card(deckValues[j], deckSuites[i]);
				Deck.deck.push(card);
			}

		}	
		Deck.shuffleDeck();
	}

	static shuffleDeck() {
		for (let i = Deck.deck.length - 1; i > 0; i--) {
        		const j = Math.floor(Math.random() * (i + 1));
        		[Deck.deck[i], Deck.deck[j]] = [Deck.deck[j], Deck.deck[i]]; // swap
    		}
	}

}


class Hand {

	#cards = [];

	get cards() {
		return this.#cards;
	}

	getCardSum() {
		let sum = 0;
		this.#cards.map( (item) => sum += item.getCardValue(sum) );
		return sum;
	}

	hit(card) {
		this.cards.push(card);
	}

	isBust() {
		return (this.getCardSum() > 21);
	}

}

class Game {

	#dealer = new Hand();
	#player = new Hand();
	#deck = new Deck();

	constructor() {
		
		this.#player.hit(Deck.drawCard());
		this.#dealer.hit(Deck.drawCard());	
		this.#player.hit(Deck.drawCard());
		this.#dealer.hit(Deck.drawCard());
	}

	playerHit() {
		let card = Deck.drawCard();
		this.#player.hit(card);
		if (this.#player.isBust()) {
			this.endGame();
		}
	}

	playerStand() {
		this.dealerAI();
	}

	dealerAI() {
		while (this.#dealer.getCardSum() < 19) {
			this.#dealer.hit();
			if (this.#dealer.isBust()) {
				this.endGame();
				return;
			}
		}
		this.endGame();
	}

	endGame() {
		//maybe swap this to switch somehow to be more efficient
		if (this.#player.isBust()) {
			console.log("Dealer wins!");
		} 
		else if (this.#dealer.isBust()) {
			console.log("Player wins!");
		}
		else if (this.#dealer.getCardSum() > this.#player.getCardSum()) {
			console.log("Dealer wins!");
		}
		else if (this.#player.getCardSum() > this.#dealer.getCardSum()) {
			console.log("Player wins!");
		}
		else if (this.#dealer.getCardSum() == this.#player.getCardSum()) {
			console.log("Draw!");
		}
	}

}

const game = new Game();

game.playerHit();
game.playerHit();
game.playerStand();
