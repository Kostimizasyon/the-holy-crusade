import random
import sys
#MLU dealer bj msg doesnt show up
#MLU dealer stand msg too early
#MLU no bust first hand
#MLU proper wins on bust 
#MLU busts at "number"
#MLU input for player name
#MLU make it an exe or smtn
#MLU dealer can bust turn 1 and bust mesage is late
#MLU dealer hits if player has 18-19-20-21
#MLU game doesnt end on bj chance to draw
#++ Bets , doube splits etc  
#++ better dealer ai
#++= ace = 1 or 11 based on the hand 
Deck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11] * 4 + [10] * 16
DealerHand = []
PlayerHand = []

def ir():
 for _ in range(150):
  print("Incorrect response, please type either hit or stand")
  PlayerDesicion = input("Hit or stand?").lower()
  cleanplayerdesicion = PlayerDesicion.strip()
  if cleanplayerdesicion == "Hit".lower():
   g = Draw("g")
   PlayerHand.append(g)
   print("\033[36mPlayer hand is\033[0m", sum(PlayerHand))
   break
  if cleanplayerdesicion == "Stand".lower():
   break
  else:
   continue 
 
def Draw(vrb = "a"):
 vrb = random.choice(Deck)
 Deck.remove(vrb)
 return vrb

def ITSHIGHNOON(person = "Dealer"):
 if person == "Dealer":
  a = Draw()
  b = Draw("b")
  DealerHand.extend([a , b])
  print("\033[35mDealers hand is\033[0m", sum(DealerHand))
  if sum(DealerHand) > 21:
   Bust("Dealer")
  if sum(DealerHand) == 21:
   Blackjack("Dealer")
 else:
  c = Draw("c")
  d = Draw("d")
  PlayerHand.extend([c , d])
  print("\033[36mPlayers hand is\033[0m", sum(PlayerHand))
  if sum(PlayerHand) > 21:
   Bust("Player")
def Stand(person = "Dealer"):
 if person == "Dealer":
  print("\033[35mDealer stands on\033[0m", sum(DealerHand))
 else:
  print("\033[36mPlayer stands \033[0m", sum(PlayerHand))
 
def Bust(person = "Dealer"):
 if person == "Dealer":
  print("\033[35mDealer busts!\033[0m")
  sys.exit("\033[36mPlayer wins!\033[0m")
 else:
  print("\033[36mPlayer busts!\033[0m")
  sys.exit("\033[35mDealer wins!\033[0m")
   
def Blackjack(person = "Dealer"):
 if person == 'Dealer':
  print('\033[35mDealer blackjack!\033[0m')
 else:
  print('\033[36mPlayer blackjack!\033[0m')

def Hit (person = "Dealer"):
  for _ in range(11):
   if person == "Dealer":
     if sum(DealerHand) > 21:
      Bust("Dealer")
      break
     if sum(DealerHand) >= 17:
      Stand("Dealer")
      break
     if sum(DealerHand) == 21:
      Blackjack("Dealer")
      break
     else:
      e = Draw("e")
      DealerHand.append(e)
      continue
   else:
     if sum(PlayerHand) > 21:
      Bust("Player")
      break
     if sum(PlayerHand) == 21:
      Blackjack("Player")
      break
     else:
      PlayerDesicion = input('Hit or stand?').lower()
      cleanplayerdesicion = PlayerDesicion.strip()
      if cleanplayerdesicion == "Hit".lower():
       f = Draw("f")
       PlayerHand.append(f)
       print("\033[36mPlayer hand is\033[0m", sum(PlayerHand))
       continue
      if cleanplayerdesicion == "Stand".lower():
        Stand("Player")
        break
      else:
        ir()

def WinCondition(): 
  if sum(PlayerHand) > sum(DealerHand):
   if sum(PlayerHand) <= 21:
    print("\033[36mPlayer wins!!\033[0m")
   else:
    print("\033[35mDealer wins!\033[0m")
  if sum(DealerHand) > sum(PlayerHand):
   if sum(DealerHand) <= 21:
    print("\033[35mDealer wins!!\033[0m")
   else:
    print("\033[36mPlayer wins!\033[0m")

def GameStart():
 ITSHIGHNOON("Dealer")
 ITSHIGHNOON("Player")
 Hit("Dealer")
 Hit("Player")
 WinCondition()

if sum(DealerHand) <= 21: 
 WinCondition()
else:
 print("\033[36mPlayer wins!\033[0m")
if sum(PlayerHand) <= 21: 
 WinCondition()
else:
 print("\033[35mDealer wins!\033[0m")
GameStart()
if sum(DealerHand) == sum(PlayerHand):
  print("Draw!")