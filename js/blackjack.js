const suites = ["Diamond","Aces","Hearts", "Spades"];
const cardValues = ['Ace', 2, 3, 4, 5, 6, 7, 8, 9, 10, 'King', 'Queen', 'Joker'];

class Card {
    
    constructor(value, suite) {
        this.value = value;
        this.suite = suite;
    }

    displayCard() {
        console.log(`${this.value} of ${this.suite}`);
    }

}

class Deck {

    #deck = [];

    consturctor() {
        this.newDeck();
    }

    pullCard() {
        const randomIndex = Math.floor(Math.random() * this.#deck.length);
        const pulledCard = this.#deck[randomIndex];
        this.#deck.splice(randomIndex, 1);
        return pulledCard;
    }

    newDeck() {

        console.log("Making a new deck!");
        this.#deck = [];
        for (const suite of suites) {
            for (const value of cardValues) {
                this.#deck.push(new Card(value, suite));
            }   
        }

    }
}

class Hand {

    #hand;
    

}

class BlackjackGame {

    #deck
    #playerHand
    #dealerHand
    #gameEnded = false; 

    consturctor(deck, playerHand, dealerHand) {
        this.deck = deck;
        this.playerHand = playerHand;
        this.dealerHand = dealerHand;
    }

    playerHit() {
        this.#playerHand.hit();
        if (this.#playerHand.bust()) {
            this.#gameEnded = true;
            console.log("Player busts! Dealer wins!");
        }
        this.endGame();
    }

    playerStand() {
        console.log("Player stands!");
        this.dealerTakeAction();
    }

    dealerTakeAction() {
        while (this.#dealerHand.sum < 19) {
            this.#dealerHand.hit();
        }
        if (this.#dealerHand.bust()) {
            this.#gameEnded = true;
            console.log("Dealer busts! Player wins!");
        }
        this.endGame();
    }

    endGame() {
        if (this.#gameEnded === false) {
            if (this.#playerHand.sum() > this.dealerHand.sum()) {
                console.log("Player wins!");
                return;
            }
            else if (this.#playerHand.sum() === this.dealerHand.sum()) {
                console.log("Draw!");
                return;
            }
            else {
                console.log("Dealer wins!");
                return;
            }
        }
        this.#deck.newDeck();
    }

}
