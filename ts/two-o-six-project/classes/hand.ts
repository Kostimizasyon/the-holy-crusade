import Card from "./card.ts"
import Deck from "./deck.ts"
import * as fs from "node:fs"   
import * as rl from "readline-sync"

const C = {
    reset:  "\x1b[0m",
    bold:   "\x1b[1m",
    red:    "\x1b[31m",
    green:  "\x1b[32m",
    yellow: "\x1b[33m",
    cyan:   "\x1b[36m",
    dim:    "\x1b[2m",
};

const dealerNames : Array<string> = ["Paul", "Peter", "Pope Francis", "Faruk", "Leon"];

abstract class Hand {
    protected currHand : Array<Card> = [];

    sumHand() : number {
        let sum : number = 0;
        this.currHand.forEach((card) => {
            const cardValue = card.getCardValue();
            if (cardValue == 67) {
                if (sum + 11 > 21)
                    sum += 1;
                else
                    sum += 11;
            } else {
                sum += cardValue;
            }
        });
        return sum;
    }

    checkBust() : boolean {
        return (this.sumHand() > 21);
    }

    abstract getName() : string;

    hit() : void {
        const newCard = Deck.hit();
        console.log(`${C.cyan}${this.getName()} draws: ${C.bold}${newCard.toString()}${C.reset}\n`);
        this.currHand.push(newCard);
    }

    startBlackJack() : void {
        this.currHand = [];
        this.currHand.push(Deck.hit(), Deck.hit());
    }

    displayHand() : void {
        const total = this.sumHand();
        const totalColor = total > 21 ? C.red : total >= 18 ? C.green : C.yellow;
        const cards = this.currHand.map(card => card.toString()).join(`${C.dim}, ${C.reset}`);
        console.log(
            `  ${C.bold}${this.getName()}${C.reset}` +
            `${C.dim} │ ${C.reset}` +
            `${cards}` +
            `${C.dim} │ ${C.reset}` +
            `Total: ${totalColor}${C.bold}${total}${C.reset}\n`
        );
    }
}

export class PlayerHand extends Hand {
    protected playerName : string = "";

    constructor() {
        super();
        this.readPlayerName();
    }

    getName() : string {
        return this.playerName;
    }

    readPlayerName() : void {
        let playerName = "";
        try {
            playerName = fs.readFileSync("playerName.txt", "utf-8").trim();
            if (playerName === "") {
                playerName = rl.question(`${C.yellow}What do you want your name to be? ${C.reset}`);
            }
        } catch (e) {
            playerName = rl.question(`${C.yellow}What do you want your name to be? ${C.reset}`);
        }
        this.savePlayerName(playerName);
    }

    savePlayerName(playerName : string) : void {
        try {
            fs.writeFileSync("playerName.txt", playerName);
            this.playerName = playerName;
        } catch (e) {
            console.log(`${C.red}Failed to save player name, defaulted to "Player".${C.reset}\n`);
            this.playerName = "Player";
        }
    }
}

export class DealerHand extends Hand {
    protected dealerName : string = "";

    constructor() {
        super();
        this.dealerName = dealerNames[Math.floor(Math.random() * dealerNames.length)] ?? "Pope Francis";
        this.introduce();
    }

    introduce() : void {
        console.log(`${C.cyan}${C.bold}── Your Dealer ───────────────────────${C.reset}`);
        console.log(`  ${C.bold}${this.dealerName}${C.reset} ${C.dim}will be your dealer tonight.${C.reset}`);
        console.log(`  ${C.dim}Good luck... you'll need it.${C.reset}\n`);
    }

    getName() : string {
        return this.dealerName;
    }

    dealerTurn() : void {
        while (this.sumHand() < 19) {
            this.hit();
        }
    }
}