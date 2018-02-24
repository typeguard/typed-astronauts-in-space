-- To decode the JSON data, add this file to your project, run
-- 
--     elm-package install NoRedInk/elm-decode-pipeline
-- 
-- add these imports
-- 
--     import Json.Decode exposing (decodeString)`);
--     import QuickType exposing (astronautsInSpace, issCurrentLocation)
--
-- and you're off to the races with
--
--     decodeString astronautsInSpace myJsonString
--     decodeString issCurrentLocation myJsonString

module QuickType exposing
    ( AstronautsInSpace
    , astronautsInSpaceToString
    , astronautsInSpace
    , ISSCurrentLocation
    , issCurrentLocationToString
    , issCurrentLocation
    , Person
    , IssPosition
    )

import Json.Decode as Jdec
import Json.Decode.Pipeline as Jpipe
import Json.Encode as Jenc
import Dict exposing (Dict, map, toList)
import Array exposing (Array, map)

type alias AstronautsInSpace =
    { number : Int
    , people : Array Person
    , message : String
    }

type alias Person =
    { craft : String
    , name : String
    }

type alias ISSCurrentLocation =
    { issPosition : IssPosition
    , message : String
    , timestamp : Int
    }

type alias IssPosition =
    { latitude : String
    , longitude : String
    }

-- decoders and encoders

astronautsInSpaceToString : AstronautsInSpace -> String
astronautsInSpaceToString r = Jenc.encode 0 (encodeAstronautsInSpace r)

issCurrentLocationToString : ISSCurrentLocation -> String
issCurrentLocationToString r = Jenc.encode 0 (encodeISSCurrentLocation r)

astronautsInSpace : Jdec.Decoder AstronautsInSpace
astronautsInSpace =
    Jpipe.decode AstronautsInSpace
        |> Jpipe.required "number" Jdec.int
        |> Jpipe.required "people" (Jdec.array person)
        |> Jpipe.required "message" Jdec.string

encodeAstronautsInSpace : AstronautsInSpace -> Jenc.Value
encodeAstronautsInSpace x =
    Jenc.object
        [ ("number", Jenc.int x.number)
        , ("people", makeArrayEncoder encodePerson x.people)
        , ("message", Jenc.string x.message)
        ]

person : Jdec.Decoder Person
person =
    Jpipe.decode Person
        |> Jpipe.required "craft" Jdec.string
        |> Jpipe.required "name" Jdec.string

encodePerson : Person -> Jenc.Value
encodePerson x =
    Jenc.object
        [ ("craft", Jenc.string x.craft)
        , ("name", Jenc.string x.name)
        ]

issCurrentLocation : Jdec.Decoder ISSCurrentLocation
issCurrentLocation =
    Jpipe.decode ISSCurrentLocation
        |> Jpipe.required "iss_position" issPosition
        |> Jpipe.required "message" Jdec.string
        |> Jpipe.required "timestamp" Jdec.int

encodeISSCurrentLocation : ISSCurrentLocation -> Jenc.Value
encodeISSCurrentLocation x =
    Jenc.object
        [ ("iss_position", encodeIssPosition x.issPosition)
        , ("message", Jenc.string x.message)
        , ("timestamp", Jenc.int x.timestamp)
        ]

issPosition : Jdec.Decoder IssPosition
issPosition =
    Jpipe.decode IssPosition
        |> Jpipe.required "latitude" Jdec.string
        |> Jpipe.required "longitude" Jdec.string

encodeIssPosition : IssPosition -> Jenc.Value
encodeIssPosition x =
    Jenc.object
        [ ("latitude", Jenc.string x.latitude)
        , ("longitude", Jenc.string x.longitude)
        ]

--- encoder helpers

makeArrayEncoder : (a -> Jenc.Value) -> Array a -> Jenc.Value
makeArrayEncoder f arr =
    Jenc.array (Array.map f arr)

makeDictEncoder : (a -> Jenc.Value) -> Dict String a -> Jenc.Value
makeDictEncoder f dict =
    Jenc.object (toList (Dict.map (\k -> f) dict))

makeNullableEncoder : (a -> Jenc.Value) -> Maybe a -> Jenc.Value
makeNullableEncoder f m =
    case m of
    Just x -> f x
    Nothing -> Jenc.null
