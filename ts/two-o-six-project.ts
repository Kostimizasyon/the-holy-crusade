import * as fs from "fs"	
import * as rl from "readline-sync"

const dealerNames : Array<string>= ["Paul", "Peter", "Pope Francis", "Faruk", "Leon"];

const cardValues : Array<string> = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "K", "J", "Q"];
const cardFaces : Array<string> = ["Hearts", "Clubs", "Spades", "Diamonds"];

class Card {

	protected value: string = "";
	protected face: string = "";

	constructor(value: string, face: string) {
		this.value = value;
		this.face = face;
	}

	toString() : string {
		return this.value + " of " + this.face;
	}
	
	displayCard() : void {
		console.log( this.value + " of " + this.face );
	}
	
	getCardValue() : number {
		switch (this.value) {
			case ("Ace"):
				return 67; //Define later
			case ("K"):
			case ("Q"):
			case ("J"):
				return 10;
			default:
				return (parseInt(this.value));
		};
	}

};

class Deck {
	
	static deck: Array<Card> = [];

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
		[Deck.deck[i], Deck.deck[j]] = [Deck.deck[j], Deck.deck[i]]; //swap
	    }

	}

	protected static restoreDeck() : void {

		Deck.deck = [];
		for (let face of cardFaces) {
			for (let value of cardValues) {
				
				const newCard : Card = new Card(value, face);
				Deck.deck.push(newCard);

			}
		}
	}
	
	static hit() : Card {
		const randomIndex = Math.floor(Math.random() * Deck.deck.length);
		const randomCard : Card = Deck.deck[randomIndex];
		Deck.deck.splice(randomIndex, 1);
		return randomCard;
	}

};

abstract class Hand {

	protected currHand : Array<Card> = [];

	sumHand() : number {

		let sum : number = 0;

		this.currHand.map( (card) => {
			
			const cardValue = card.getCardValue();
			if (cardValue == 67) {
				
				if ( sum + 11 > 21)
					sum += 1;
				else 
					sum += 11;

			}
			else {
				sum += cardValue;
			}

		});

		return sum;

	}

	checkBust() : boolean {
		return ( this.sumHand() > 21 );
	}

	abstract getName() : string;

	hit() : void {
		const newCard = Deck.hit();
		console.log( this.getName(), " draws: ", newCard.toString());
		this.currHand.push(newCard);
	}

	startBlackJack() : void {
		this.currHand = [];
		this.currHand.push( Deck.hit() );
		this.currHand.push( Deck.hit() );
	}

}

class PlayerHand extends Hand {
	protected playerName : string = "";

	constructor() {
		super();
		this.readPlayerName();
	}

	getName() : string {
		return this.playerName;
	}

	readPlayerName() : void{
		let playerName = "";
		try {
			playerName = fs.readFileSync("playerName.txt", "utf-8").trim();
			if (playerName === undefined) {
				playerName = rl.question("What do you want your name to be? ");
			}
			this.savePlayerName(playerName);
		}
		catch (e) {
			playerName = rl.question("What do you want your name to be? ");
			this.savePlayerName(playerName);
		}
	}
	
	savePlayerName(playerName : string) : void {
		try {
			fs.writeFileSync("playerName.txt", playerName);
			this.playerName = playerName;
		}
		catch (e) {
			console.log("Failed to save player name, probably couldnt get permission to write");
			console.log("Error:", e);
		}
	}
}

class DealerHand extends Hand {
	
	protected dealerName : string = "";

	constructor() {
		super();
		this.dealerName = dealerNames[ Math.floor(Math.random() *  dealerNames.length)];
	}
	

	getName() : string {
		return this.dealerName;
	}

	dealerTurn() : void {
		while ( this.sumHand() < 19 ) {
			this.hit();
		}
	}



}

class Game {

	static dealerHand : DealerHand = new DealerHand();
	static playerHand : PlayerHand = new PlayerHand();

	static playerBalance : number = 5000;
	static playerBet : number = 1000;
	
	constructor() {
		Game.readPlayerBalance();
		Game.start();
	}

	get getPlayerBalance() : number {
		return Game.playerBalance;
	}

	set setPlayerBalance( playerBalance : number ) {
		Game.playerBalance = playerBalance;
	}

	public static start() : void {

		console.log("Welcome to two-o-six-project a blackjack game in TypeScript!\n\n");
		console.log("What do you wanna do now?");

		while (true) {
			let userInput = rl.questionInt("  (1) Play (2) Set Bet (3) Check Info (4) Set Player Name (5) Exit ");
			switch (userInput) {
				
				case(1):
					Game.startBlackJack();
					break;
				case(2):
					Game.adjustBet();
					break;
				case(3):
					Game.checkInfo();
					break;
				case(4):
					Game.setPlayerName();
					break;
				case(5):
					return;
				default:
					break;

			}

		}

	}

	protected static startBlackJack() {

		Deck.reset();
		
		Game.playerHand.startBlackJack();
		Game.dealerHand.startBlackJack();

		let standing = false;
		while ( !Game.playerHand.checkBust() && !standing ) {
		    console.log("What do you wanna do?");
		    console.log(" (H) Hit (S) Stand " );
		    let userInput = rl.question("").toUpperCase();
		    switch (userInput) {
			case("H"):
			    Game.playerHand.hit();
			    break;
			case("S"):
			    standing = true;
			    break;
			default:
			    console.log(" (H) Hit (S) Stand " );
		    }
		}

		if ( Game.playerHand.checkBust() ) {
			console.log(Game.playerHand.getName(), " busts!!!");
			Game.wrapUp();
			return;
		}
		Game.dealerHand.dealerTurn();
		if ( Game.dealerHand.checkBust() ) {
			console.log(Game.dealerHand.getName(), " busts!!!");
		}
		Game.wrapUp();
	}

	protected static adjustBet() {
		let userInput = -999;
		while (userInput < 0) {	
			userInput = rl.questionInt("Give a positive number to bet");
		}
		Game.playerBet = userInput;
	}
	
	protected static checkInfo() {
		console.log("Welcome ", Game.playerHand.getName(), "!");
		console.log("Current balanceÇ ", Game.playerBalance);
		console.log("Current bet: ", Game.playerBet);
	}

	protected static setPlayerName() {
		let playerName : string = rl.question("What do you want your name to be?");
		Game.playerHand.savePlayerName(playerName);
	}


	public static wrapUp() : void {
		Game.calcWinner();
		Deck.reset();
	}

	protected static calcWinner() : void {

		if ( Game.playerHand.sumHand() > 21 ) {
			console.log(Game.playerHand.getName(), " busts! ");
			this.updatePlayerBalance(false);
		}
		else if ( Game.dealerHand.sumHand() > 21 ) {
			console.log(Game.dealerHand.getName(), " busts! ");
			this.updatePlayerBalance(true);
		}
		else if ( Game.playerHand.sumHand() > Game.dealerHand.sumHand() ) {
			console.log(Game.playerHand.getName(), " wins! ");
			this.updatePlayerBalance(true);
		}
		else if ( Game.dealerHand.sumHand() > Game.playerHand.sumHand() ) {
			console.log(Game.dealerHand.getName(), " wins! ");
			this.updatePlayerBalance(false);
		}
		else {
			console.log("Game is a draw!");
		}
	
	}

	protected static readPlayerBalance() : void {

		let playerBalance = 5000;

		try {
			playerBalance = parseInt(fs.readFileSync("playerBalance.txt", "utf-8").trim());
			if (playerBalance === undefined) {
				playerBalance = 5000;
			}
			Game.playerBalance = playerBalance;
			this.savePlayerBalance();
		}
		catch (e) {
			this.savePlayerBalance();
		}
	}

	protected static savePlayerBalance() {

		try {
			fs.writeFileSync("playerBalance.txt", String(Game.playerBalance));
		}

		catch (e) {
			console.log("Failed to save player balance, probably couldnt get permission to write");
			console.log("Error:", e);
		}
	}	
	
	protected static updatePlayerBalance( isWin : boolean ) {
		let chipsWon = Game.playerBet;
		if (!isWin) {
			chipsWon = -(chipsWon);
		}
		Game.playerBalance += chipsWon;
		
		console.log(" Chip exchange: ", chipsWon);
		console.log(" New Balance: ", Game.playerBalance);

		this.savePlayerBalance();
	}

}


