import { DealerHand, PlayerHand } from "./hand.ts"
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
    white:  "\x1b[37m",
    dim:    "\x1b[2m",
};

export default class Game {

    static readonly dealerHand : DealerHand = new DealerHand();
    static readonly playerHand : PlayerHand = new PlayerHand();

    protected static playerBalance : number = 5000;
    protected static playerBet : number = 1000;
    
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
        console.log(`\n${C.cyan}${C.bold}╔════════════════════════════════════╗`);
        console.log(`║   Welcome to two-o-six Blackjack!  ║`);
        console.log(`╚════════════════════════════════════╝${C.reset}\n`);

        while (true) {
            console.log(`${C.dim}─────────────────────────────────────${C.reset}`);
            let userInput = rl.questionInt(`${C.yellow}(1) Play  (2) Set Bet  (3) Info  (4) Set Name  (5) Exit${C.reset}\n> `);
            console.log();
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
                    console.log(`${C.cyan}Thanks for playing. Goodbye!\n${C.reset}`);
                    return;
                default:
                    console.log(`${C.red}Invalid option. Try again.${C.reset}\n`);
                    break;
            }
        }
    }

    protected static startBlackJack() {
        Deck.reset();
        
        Game.playerHand.startBlackJack();
        Game.dealerHand.startBlackJack();

        console.log(`${C.cyan}${C.bold}── Initial Deal ──────────────────────${C.reset}`);
        Game.playerHand.displayHand();
        Game.dealerHand.displayHand();
        console.log();

        let standing = false;
        while ( !Game.playerHand.checkBust() && !standing ) {
            console.log(`${C.dim}─────────────────────────────────────${C.reset}`);
            console.log(`${C.yellow}(H) Hit   (S) Stand${C.reset}`);
            let userInput = rl.question("> ").toUpperCase();
            console.log();
            switch (userInput) {
                case("H"):
                    Game.playerHand.hit();
                    Game.playerHand.displayHand();
                    Game.dealerHand.displayHand();
                    console.log();
                    break;
                case("S"):
                    standing = true;
                    break;
                default:
                    console.log(`${C.red}Invalid input. Enter H or S.${C.reset}\n`);
            }
        }

        if ( Game.playerHand.checkBust() ) {
            console.log(`${C.red}${C.bold}💥 ${Game.playerHand.getName()} busts!!!${C.reset}\n`);
            Game.wrapUp();
            return;
        }

        console.log(`${C.cyan}── Dealer's Turn ─────────────────────${C.reset}\n`);
        Game.dealerHand.dealerTurn();
        Game.dealerHand.displayHand();
        console.log();

        if ( Game.dealerHand.checkBust() ) {
            console.log(`${C.red}${C.bold}💥 ${Game.dealerHand.getName()} busts!!!${C.reset}\n`);
        }

        Game.wrapUp();
    }

    protected static adjustBet() {
        let userInput = -999;
        while (userInput < 0) {   
            userInput = rl.questionInt(`${C.yellow}Enter your bet amount: ${C.reset}`);
        }
        Game.playerBet = userInput;
        console.log(`${C.green}✔ Bet set to ${Game.playerBet}\n${C.reset}`);
    }
    
    protected static checkInfo() {
        console.log(`${C.cyan}── Player Info ───────────────────────${C.reset}`);
        console.log(`  Name:    ${C.bold}${Game.playerHand.getName()}${C.reset}`);
        console.log(`  Balance: ${C.green}${C.bold}${Game.playerBalance}${C.reset}`);
        console.log(`  Bet:     ${C.yellow}${C.bold}${Game.playerBet}${C.reset}\n`);
    }

    protected static setPlayerName() {
        let playerName : string = rl.question(`${C.yellow}What do you want your name to be? ${C.reset}`);
        Game.playerHand.savePlayerName(playerName);
        console.log(`${C.green}✔ Name saved!\n${C.reset}`);
    }

    public static wrapUp() : void {
        Game.calcWinner();
        Deck.reset();
    }

    protected static calcWinner() : void {
        console.log(`${C.cyan}── Result ────────────────────────────${C.reset}`);

        if ( Game.playerHand.sumHand() > 21 ) {
            console.log(`${C.red}${C.bold}${Game.playerHand.getName()} busts!${C.reset}`);
            this.updatePlayerBalance(false);
        }
        else if ( Game.dealerHand.sumHand() > 21 ) {
            console.log(`${C.red}${C.bold}${Game.dealerHand.getName()} busts!${C.reset}`);
            this.updatePlayerBalance(true);
        }
        else if ( Game.playerHand.sumHand() > Game.dealerHand.sumHand() ) {
            console.log(`${C.green}${C.bold}🏆 ${Game.playerHand.getName()} wins!${C.reset}`);
            this.updatePlayerBalance(true);
        }
        else if ( Game.dealerHand.sumHand() > Game.playerHand.sumHand() ) {
            console.log(`${C.red}${C.bold}💀 ${Game.dealerHand.getName()} wins!${C.reset}`);
            this.updatePlayerBalance(false);
        }
        else {
            console.log(`${C.yellow}${C.bold}🤝 It's a draw!${C.reset}`);
        }
        console.log();
    }

    protected static readPlayerBalance() : void {
        let playerBalance = 5000;
        try {
            playerBalance = Number.parseInt(fs.readFileSync("playerBalance.txt", "utf-8").trim());
            if (Number.isNaN(playerBalance)) playerBalance = 5000;
            this.playerBalance = playerBalance;
            this.savePlayerBalance();
        }
        catch (e) {
            this.playerBalance = 5000;
            this.savePlayerBalance();
        }
    }

    protected static savePlayerBalance() {
        try {
            fs.writeFileSync("playerBalance.txt", String(Game.playerBalance));
        }
        catch (e) {
            console.log(`${C.red}Failed to save balance, probably couldnt get write permission.${C.reset}`);
        }
    }   
    
    protected static updatePlayerBalance( isWin : boolean ) {
        let chipsWon = this.playerBet;
        if (!isWin) chipsWon = -(chipsWon);
        this.playerBalance += chipsWon;
        
        const sign = chipsWon >= 0 ? `${C.green}+${chipsWon}` : `${C.red}${chipsWon}`;
        console.log(`  Chips:   ${sign}${C.reset}`);
        console.log(`  Balance: ${C.bold}${C.yellow}${this.playerBalance}${C.reset}\n`);

        this.savePlayerBalance();
    }
}