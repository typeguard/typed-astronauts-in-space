// Example code that deserializes and serializes the model.
// extern crate serde;
// #[macro_use]
// extern crate serde_derive;
// extern crate serde_json;
//
// use generated_module::[object Object];
//
// fn main() {
//     let json = r#"{"answer": 42}"#;
//     let model: [object Object] = serde_json::from_str(&json).unwrap();
// }

extern crate serde_json;

#[derive(Serialize, Deserialize)]
pub struct AstronautsInSpace {
    #[serde(rename = "message")]
    message: String,

    #[serde(rename = "people")]
    people: Vec<Person>,

    #[serde(rename = "number")]
    number: i64,
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

    #[serde(rename = "timestamp")]
    timestamp: i64,

    #[serde(rename = "message")]
    message: String,
}

#[derive(Serialize, Deserialize)]
pub struct IssPosition {
    #[serde(rename = "longitude")]
    longitude: String,

    #[serde(rename = "latitude")]
    latitude: String,
}
