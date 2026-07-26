export default class Card {

	protected value: string = "";
	protected face: string = "";

	constructor(value: string, face: string) {
		this.value = value;
		this.face = face;
	}

	toString() : string {
		return (this.value + " of " + this.face);
	}
	
	displayCard() : void {
		console.log( this.value + " of " + this.face );
	}
	
	getCardValue() : number {
		switch (this.value) {
			case ("Ace"):
				return 67; //Since aces are 1 or 11 depending of the current deck sum, we will mark it to calculate it later
			case ("K"):
			case ("Q"):
			case ("J"):
				return 10; //returning 10 in case of our face cards
			default:
				return (Number.parseInt(this.value)); //casting our result as a number if they are just numbers
		};
	}

};
