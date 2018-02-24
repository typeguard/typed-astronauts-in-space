// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
// 
// use generated_module::AstronautsInSpace;
// 
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: AstronautsInSpace = serde_json::from_str(&json).unwrap();
// }

extern crate serde_json;

#[derive(Serialize, Deserialize)]
pub struct AstronautsInSpace {
    #[serde(rename = "number")]
    number: i64,

    #[serde(rename = "people")]
    people: Vec<Person>,

    #[serde(rename = "message")]
    message: String,
}

#[derive(Serialize, Deserialize)]
pub struct Person {
    #[serde(rename = "craft")]
    craft: String,

    #[serde(rename = "name")]
    name: String,
}

#[derive(Serialize, Deserialize)]
pub struct IssCurrentLocation {
    #[serde(rename = "iss_position")]
    iss_position: IssPosition,

    #[serde(rename = "message")]
    message: String,

    #[serde(rename = "timestamp")]
    timestamp: i64,
}

#[derive(Serialize, Deserialize)]
pub struct IssPosition {
    #[serde(rename = "latitude")]
    latitude: String,

    #[serde(rename = "longitude")]
    longitude: String,
}
