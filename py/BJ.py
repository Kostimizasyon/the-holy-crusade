import random
#you could try if person ==  but it looks like it might be more trouble than its worh
#error message is given 2 times at the end on the 2nd error
#try to make it so that the player keeps writing till they actually type hit or stand
#Blackjack - bust doesnt give stand message
#+= ace = 1 or 11 based on the hand 1 in 13 Face Cards(king queen jack)=10 1 in 3.25 number cards 2-10 1 in 1.44 
#+= 52 card deck 4 ace 16 face 36 numbered
#+ = make arrays 
PCard1 = random.randint(1, 10)
PCard2 = random.randint(1, 10)
PCard3 = random.randint(1, 10)
PCard4 = random.randint(1, 10)
PCard5 = random.randint(1, 10)
PCard6 = random.randint(1, 10)
PlayerHand = PCard1 + PCard2
PlayerHand1 = PCard3 + PlayerHand
PlayerHand2 = PlayerHand1 + PCard4
PlayerHand3 = PlayerHand2 + PCard5
PlayerHand4 = PlayerHand3 + PCard6

DCard1 = random.randint(1, 10)
DCard2 = random.randint(1, 10)
DCard3 = random.randint(1, 10)
DCard4 = random.randint(1, 10)
DCard5 = random.randint(1, 10)
DCard6 = random.randint(1, 10)
DealerHand = DCard1 + DCard2
DealerHand1 = DCard3 + DealerHand
DealerHand2 = DealerHand1 + DCard4
DealerHand3 = DealerHand2 + DCard5
DealerHand4 = DealerHand3 + DCard6
#def ir():
#   for _ in range(150):
#      print("Incorrect response, please type hit or stand")
#      PlayerDesicion = input('Hit or stand? ').lower()
#      if PlayerDesicion == "stand":
#       print("Player stands on", PlayerHand) 
#       break
#      elif PlayerDesicion == "hit":
#       print ("Player hits!")
#       
#      else:
#        PlayerDesicion = input('Hit or stand? ')
#        print("Incorrect response, please type hit or stand")
#        continue
  
def Hitagainagain( person = "Dealer"):
 if DealerHand3 > 21: 
  print(person + " bust!")
 if  DealerHand3< 16:
   dHitagainagainagain("Dealer")
 if DealerHand3 >= 16:
  print("Dealer stands on", DealerHand3)
  if  DealerHand3== 21:
   print(person + " blackjack!")

def dHitagain( person = "Dealer" ):
 if DealerHand2 > 21:  
  print(person + " bust!")
 if DealerHand2 < 16:
   Hitagainagain("Dealer")
 if DealerHand2 >= 16:
  print("Dealer stands on", DealerHand2)
 if DealerHand2 == 21:
  print(person + " blackjack!")

def dHit(person = "Dealer"):
 if DealerHand1 > 21:
   print(person + " bust!")
 if DealerHand1 < 16:
  dHitagain("Dealer")
 if DealerHand1 >= 16:
   print("Dealer stands on", DealerHand1)
 if DealerHand1 == 21:
   print(person + " blackjack!")

def dHitagainagainagain( person = "Dealer"):
 if DealerHand4 > 21: 
  print(person + " bust!")
 if DealerHand4< 21:
   print("Dealer stands on", DealerHand4)
 if DealerHand4== 21:
  print(person + " blackjack!")
  
def dHitagainagain( person = "Dealer"):
 if DealerHand3 > 21: 
  print(person + " bust!")
 if  DealerHand3< 16:
   dHitagainagainagain("Dealer")
 if DealerHand3 >= 16:
  print("Dealer stands on", DealerHand3)
  if  DealerHand3== 21:
   print(person + " blackjack!")

def dHitagain( person = "Dealer" ):
 if DealerHand2 > 21:  
  print(person + " bust!")
 if DealerHand2 < 16:
   dHitagainagain("Dealer")
 if DealerHand2 >= 16:
  print("Dealer stands on", DealerHand2)
 if DealerHand2 == 21:
  print(person + " blackjack!")

def dHit(person = "Dealer"):
 if DealerHand1 > 21:
   print(person + " bust!")
 if DealerHand1 < 16:
  dHitagain("Dealer")
 if DealerHand1 >= 16:
   print("Dealer stands on", DealerHand1)
 if DealerHand1 == 21:
   print(person + " blackjack!")
 
def Dealer():
  
   if DealerHand == 21:
      print("Dealer blackjack!")
   if DealerHand > 21:
      print("Dealer bust!")
   if DealerHand <= 16: 
    dHit("Dealer")
   if DealerHand > 16:
     print("Dealer stands on" , DealerHand)

def Player():
  print ("Players hand is", PlayerHand) 
  PlayerDesicion = input('Hit or stand? ')
  if "stand" in PlayerDesicion:
    print("Player stands on", PlayerHand) 
    
  if "hit" in PlayerDesicion:
   print ("Player hits!")
   x"Hit("Player")
  
  else:
    print("Incorrect response, please type hit or stands")
  PlayerDesicion = input('Hit or stand? ')
  #ir()
Player()
Dealer()
