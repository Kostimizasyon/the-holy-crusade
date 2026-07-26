pub enum Faces {
    Hearts,
    Spades,
    Diamonds,
    Clubs
}

impl Faces {

    fn to_string(&self) -> &str {

        match self {
            
            Faces::Hearts => "Hearts",
            Faces::Spades => "Spades",
            Faces::Diamonds => "Diamonds",
            Faces::Clubs => "Clubs"

        }

    }

}

pub struct Cards {

    value: i32,
    face: Faces

}

impl Cards {

    fn new(value : i32, face : Faces) -> Self {
        Self { value, face }
    }

    fn to_string(&self) -> String {

        self.value.to_string() + " of "+ self.face.to_string()

    }

}
