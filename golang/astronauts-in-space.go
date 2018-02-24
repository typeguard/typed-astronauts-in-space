// To parse and unparse this JSON data, add this code to your project and do:
//
//    astronautsInSpace, err := UnmarshalAstronautsInSpace(bytes)
//    bytes, err = astronautsInSpace.Marshal()
//
//    iSSCurrentLocation, err := UnmarshalISSCurrentLocation(bytes)
//    bytes, err = iSSCurrentLocation.Marshal()

package main

import "encoding/json"

func UnmarshalAstronautsInSpace(data []byte) (AstronautsInSpace, error) {
	var r AstronautsInSpace
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *AstronautsInSpace) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

func UnmarshalISSCurrentLocation(data []byte) (ISSCurrentLocation, error) {
	var r ISSCurrentLocation
	err := json.Unmarshal(data, &r)
	return r, err
}

func (r *ISSCurrentLocation) Marshal() ([]byte, error) {
	return json.Marshal(r)
}

type AstronautsInSpace struct {
	Number  int64    `json:"number"` 
	People  []Person `json:"people"` 
	Message string   `json:"message"`
}

type Person struct {
	Craft string `json:"craft"`
	Name  string `json:"name"` 
}

type ISSCurrentLocation struct {
	IssPosition IssPosition `json:"iss_position"`
	Message     string      `json:"message"`     
	Timestamp   int64       `json:"timestamp"`   
}

type IssPosition struct {
	Latitude  string `json:"latitude"` 
	Longitude string `json:"longitude"`
}
