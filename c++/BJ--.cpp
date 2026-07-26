#include <vector>
#include <iostream>
#include <algorithm>
#include <string>
using namespace std;
vector<int> Deck = {1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10};
vector<int> PlayerHand = {};
vector<int> DealerHand = {};
int dsum = 0;
int psum = 0;

void WinCondition() {
 if (psum > dsum && psum <= 21 && dsum <= 21) {
    cout << "You win!!" << endl;
 }
 else if (psum < dsum && psum <= 21 && dsum <= 21) {
   cout << "Dealer wins!!" << endl;
 }
 else if (psum > 21) {
  cout <<"You bust!" << endl;
 }
 else if (dsum > 21) {
  cout <<"Dealer busts!" << endl;
 }
}
void start() {
  for (int i = 0; i < 2; i++) {
  int randomselect = rand() % Deck.size();
  int card = Deck[randomselect];
  DealerHand.push_back(card);
  auto first = Deck.begin();
  auto last = Deck.end();
  auto rcard = find(first, last, card);
  Deck.erase(rcard);
  dsum += card;
  }
  cout << "Dealers starting hand is : " << dsum << endl;
  for (int i = 0; i < 2; i++) {
  int randomselect = rand() % Deck.size();
  int card = Deck[randomselect];
  PlayerHand.push_back(card);
  auto first = Deck.begin();
  auto last = Deck.end();
  auto rcard = find(first, last, card);
  Deck.erase(rcard);
  psum += card;
  }
  cout << "Your starting hand is : " << psum << endl;
}
void dealer() {

for(;dsum <=  19;) { 
  int randomselect = rand() % Deck.size();
  int card = Deck[randomselect];
  DealerHand.push_back(card);
  auto first = Deck.begin();
  auto last = Deck.end();
  auto rcard = find(first, last, card);
  Deck.erase(rcard);
  dsum += card;
  cout << "Dealer draws : " << card << endl;
 }
 cout << "Dealers stands on :" << dsum << endl;
}
 
void pHit() {
 int randomselect = rand() % Deck.size();   
 int card = Deck[randomselect];
 PlayerHand.push_back(card);
 auto first = Deck.begin();
 auto last = Deck.end();
 auto rcard = find(first, last, card);
 Deck.erase(rcard);
 psum += card;
 cout << "You draw : " << card << endl;
 cout << "Your hand is : " << psum << endl;
} 

void options() {
 int i = 0;
 while (i == 0) {
 cout << "Hit or Stand?" << endl;   
 string userinput;
 cin >> userinput;
 if (userinput == "Hit") {
  pHit();
 }
 else if (userinput == "Stand") {
  cout << "You stand on : " << psum << endl;
  dealer();
  break;
 }
 else{
 cout << "Please type either Hit or Stand" << endl;
 }      
 }
 WinCondition();
}

int main() {
 srand(time(0));
 start();
 options();
}