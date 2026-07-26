import random
import os
Deck = [1, 2, 3, 4, 5, 6, 7, 8, 9, 11] * 4 + [10] * 16
DealerHand = []
PlayerHand = []
def namedefinition():
 if os.path.exists("playername.txt") == False:
  global PlayerName
  PlayerName = input("gimme a name to use").strip()
  with open("playername.txt", 'w')as f:
   f.write(PlayerName)
 if os.path.exists("playername.txt") == True:
  with open("playername.txt", 'r')as file:
   PlayerName = file.read()
  GameStart()

def namereset():
 try:
  os.remove("playername.txt")
  exit()
 except FileNotFoundError:
  print("You dont have a name dumbo")
  exit()

def ir():
 while True:
  print("\033[31mIncorrect response, please type either hit or stand\033[0m")
  PlayerDesicion = input("Hit or stand?").lower().strip()
  if PlayerDesicion == "Hit".lower().strip():
   g = Draw("g")
   PlayerHand.append(g)
   print(f"\033[36m{PlayerName}'s hand is\033[0m", sum(PlayerHand))
   break
  if PlayerDesicion == "Stand".lower().strip():
   break
  if PlayerDesicion == "namereset".lower().strip():
   namereset()
   break 

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
  print(f"\033[36m{PlayerName}'s hand is\033[0m", sum(PlayerHand))
  if sum(PlayerHand) > 21:
   Bust("Player")

def Stand(person = "Dealer"):
 if person == "Dealer":
  print("\033[35mDealer stands on\033[0m", sum(DealerHand))
 else:
  print(f"\033[36m{PlayerName} stands on\033[0m", sum(PlayerHand))
 
def Bust(person = "Dealer"):
 if person == "Dealer":
  print("\033[35mDealer busts on\033[0m", sum(DealerHand))
 else:
  print(f"\033[36m{PlayerName} busts on\033[0m", sum(PlayerHand))
def Blackjack(person = "Dealer"):
 if person == 'Dealer':
  print('\033[35mDealer blackjack!\033[0m')
 else:
  print(f'\033[36m{PlayerName} blackjack!\033[0m')

def Hit (person = "Dealer"):
  for _ in range(11):
   if person == "Dealer":
     if sum(DealerHand) > 21:
      Bust("Dealer")
      break
     if sum(DealerHand) < sum(PlayerHand) and sum(PlayerHand) > 17:
      e = Draw("e")
      DealerHand.append(e)
      continue
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
      PlayerDesicion = input('Hit or stand?').lower().strip()
      if PlayerDesicion == "Hit".lower().strip():
       f = Draw("f")
       PlayerHand.append(f)
       print(f"\033[36m{PlayerName}'s hand is\033[0m", sum(PlayerHand))
       continue
      if PlayerDesicion == "Stand".lower().strip():
        Stand("Player")
        break
      if PlayerDesicion == "namereset".lower().strip():
       namereset()
      else:
        ir()

def WinCondition(): 
  if sum(PlayerHand) == sum(DealerHand):
    print("\033[33mDraw!!\033[0m")
  if sum(PlayerHand) > sum(DealerHand):
   if sum(PlayerHand) <= 21:
    print(f"\033[36m{PlayerName} wins!!\033[0m")
   else:
    print("\033[35mDealer wins!\033[0m")
  if sum(DealerHand) > sum(PlayerHand):
   if sum(DealerHand) <= 21:
    print("\033[35mDealer wins!!\033[0m")
   else:
    print(f"\033[36m{PlayerName} wins!\033[0m")

def GameStart():
 ITSHIGHNOON("Dealer")
 ITSHIGHNOON("Player")
 Hit("Player")
 Hit("Dealer")
 WinCondition()
 Deck.extend(DealerHand)
 Deck.extend(PlayerHand)
 DealerHand.clear()
 PlayerHand.clear()
 Restart = input("\033[32mCare for another game? Y/N\033[0m").lower().strip()
 if Restart == "Y".lower().strip():
  GameStart()
 if Restart == "N".lower().strip():
   exit()
 else:
   print("\033[31mPlease type Y or N\033[0m")
   GameStart()

if __name__ == "__main__":
 namedefinition()
