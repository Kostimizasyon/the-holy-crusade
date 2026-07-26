#include <iostream>
#include <queue>
#include <random>
std::random_device rd;
std::mt19937 engine(rd());

struct Deck {

    std::queue<int> deck;

    Deck() {

        int oneCount,tenCount = 0;

        int upperLimit = 10;
        int lowerLimit = 1;

        for (int i = 0; i < 52; i++) {

            std::uniform_int_distribution<int> randomCard(lowerLimit, upperLimit);
            int cardValue = randomCard(engine);

            switch (cardValue) {
                case 1:
                    oneCount++;
                    if (oneCount == 4) {
                        lowerLimit = 2;
                    }
                    deck.push(cardValue);
                    break;
                case 10:
                    tenCount++;
                    if (tenCount == 12) {
                        upperLimit = 9;
                    }
                    deck.push(cardValue);
                    break;
                default:
                    deck.push(cardValue);
                    break;
            }

        }



    }   

};

struct Hand {

    std::string playerName = "";
    int handValue;

    Hand(std::string playerName) {

        this->playerName = playerName;
        handValue = 0;

    }

    void drawCard(Deck& deck) {
        
        int drawnCard = deck.deck.front();
        deck.deck.pop();

        switch (drawnCard) {
            case 1:
            case 11:
                if (handValue + 11 > 21) {
                    handValue += 1;
                } else {
                    handValue += 11;
                }
                break;
            default:
                handValue += drawnCard;
                break;
        }

        if (handValue > 21) {
            std::cout << playerName << "Busts!" << "\n";
        }

    }

};

class BlackJackGame {

    Hand playerHand = Hand("Player");
    Hand dealerHand = Hand("Dealer");
    
    public:

        BlackJackGame() {
            
            Deck deck;

            playerHand.drawCard(deck);
            dealerHand.drawCard(deck);
            playerHand.drawCard(deck);
            dealerHand.drawCard(deck);
            
            displayGameStatus();

        }

        void displayGameStatus() {

            std::cout << "Player: " << playerHand.handValue << "\n";
            std::cout << "Dealer: " << dealerHand.handValue << "\n";

        }

        void hit(Hand &hand, Deck &deck) {

            std::cout<< hand.playerName << " hits!\n";
            hand.drawCard(deck);
            if (hand.handValue > 21) {
                std::cout << hand.playerName << " busts! Game over.\n";
            } 
            else {
            displayGameStatus();
            }
        } 

        void stand(Deck &deck) {

            std::cout << "Player stands!\n";

            while (dealerHand.handValue < 17) {
                hit(dealerHand, deck);
            }

            if (dealerHand.handValue > 21) {
                std::cout << "Dealer busts! Player wins!\n";
            } else if (dealerHand.handValue > playerHand.handValue) {
                std::cout << "Dealer wins!\n";
            } else if (dealerHand.handValue < playerHand.handValue) {
                std::cout << "Player wins!\n";
            } else {
                std::cout << "It's a draw!\n";
            }

        }

};

int main() {
    
    BlackJackGame game = BlackJackGame();

    //FAULTS => Amount of 10s and 1s is not guaranteed to be correct => maybe add some checks

    return 0;

}