#[derive(Debug,PartialEq)]
pub enum TriangleOrder {
    Equalateral,
    Isosceles,
    Scalene,
}

pub struct Triangle(TriangleOrder);

impl Triangle {
    pub fn build(sides: [usize; 3]) -> Result<Triangle, String> {
        let mut sorted = sides.clone();
        sorted.sort();
        let big = sorted[2];
        let med = sorted[1];
        let sml = sorted[0];

        if sml < 1 || big >= med + sml {
            Err(String::from("Invalid sides"))
        } else if big == med && med == sml {
            Ok(Triangle(TriangleOrder::Equalateral))
        } else if big == med || med == sml || sml == big {
            Ok(Triangle(TriangleOrder::Isosceles))
        } else {
            Ok(Triangle(TriangleOrder::Scalene))
        }
    }

    pub fn is_equilateral(&self) -> bool {
        self.order() == &TriangleOrder::Equalateral
    }

    pub fn is_isosceles(&self) -> bool {
        self.order() == &TriangleOrder::Isosceles
    }

    pub fn is_scalene(&self) -> bool {
        self.order() == &TriangleOrder::Scalene
    }

    pub fn order(&self) -> &TriangleOrder {
        let &Triangle(ref value) = self;
        value
    }
}
