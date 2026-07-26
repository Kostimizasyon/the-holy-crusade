import Card from "./card.ts"

const cardValues : Array<string> = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "K", "J", "Q"];
const cardFaces : Array<string> = ["Hearts", "Clubs", "Spades", "Diamonds"];

export default class Deck {
	
	private static readonly deck: Array<Card> = []; 
	//for the sake of abstraction and encaplusation, we will make deck readonly so that exporting it is safe

	constructor() {
		Deck.reset();
	}		

	public static reset() : void {
		this.restoreDeck();
		this.shuffleDeck();
	}

	protected static shuffleDeck() : void {

	    for (let i = Deck.deck.length - 1; i > 0; i--) {
		const j = Math.floor(Math.random() * (i + 1));	//get random index
		[Deck.deck[i], Deck.deck[j]] = [Deck.deck[j]!, Deck.deck[i]!]; //shuffle randomly 
	    }

	}

	protected static restoreDeck() : void {

		this.deck.splice(0, this.deck.length);
		for (let face of cardFaces) {
			for (let value of cardValues) {
				
				const newCard : Card = new Card(value, face);
				Deck.deck.push(newCard);

			}
		}
	}
	
	static hit() : Card {
		const randomIndex = Math.floor(Math.random() * Deck.deck.length);
		const randomCard : Card = Deck.deck[randomIndex]!;
		Deck.deck.splice(randomIndex, 1);
		return randomCard;
	}

};


