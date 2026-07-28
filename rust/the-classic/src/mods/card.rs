#[derive(Clone, Copy)]
pub enum Faces {
    Hearts,
    Spades,
    Diamonds,
    Clubs,
    Egg
}

impl Faces {

    fn to_string(&self) -> &str {

        match self {
            
            Faces::Hearts => "Hearts",
            Faces::Spades => "Spades",
            Faces::Diamonds => "Diamonds",
            Faces::Clubs => "Clubs",
            Faces::Egg => "How did we get here?"

        }

    }

}

pub struct Card {

    value: usize,
    face: Faces

}

impl Card {

    pub fn new(value : usize, face : Faces) -> Self {
        Self { value, face }
    }

    pub fn to_string(&self) -> String {
        self.value.to_string() + " of "+ self.face.to_string()
    }

    pub fn get_card_val(&self) -> usize {
        self.value
    }

}
