# To use this code, make sure you
#
#     import json
#
# and then, to convert JSON from a string, do
#
#     result = astronauts_in_space_from_dict(json.loads(json_string))
#     result = iss_current_location_from_dict(json.loads(json_string))

from typing import Any, List, TypeVar, Callable, Type, cast


T = TypeVar("T")


def from_str(x: Any) -> str:
    assert isinstance(x, str)
    return x


def from_list(f: Callable[[Any], T], x: Any) -> List[T]:
    assert isinstance(x, list)
    return [f(y) for y in x]


def from_int(x: Any) -> int:
    assert isinstance(x, int) and not isinstance(x, bool)
    return x


def to_class(c: Type[T], x: Any) -> dict:
    assert isinstance(x, c)
    return cast(Any, x).to_dict()


class Person:
    craft: str
    name: str

    def __init__(self, craft: str, name: str) -> None:
        self.craft = craft
        self.name = name

    @staticmethod
    def from_dict(obj: Any) -> 'Person':
        assert isinstance(obj, dict)
        craft = from_str(obj.get("craft"))
        name = from_str(obj.get("name"))
        return Person(craft, name)

    def to_dict(self) -> dict:
        result: dict = {}
        result["craft"] = from_str(self.craft)
        result["name"] = from_str(self.name)
        return result


class AstronautsInSpace:
    message: str
    people: List[Person]
    number: int

    def __init__(self, message: str, people: List[Person], number: int) -> None:
        self.message = message
        self.people = people
        self.number = number

    @staticmethod
    def from_dict(obj: Any) -> 'AstronautsInSpace':
        assert isinstance(obj, dict)
        message = from_str(obj.get("message"))
        people = from_list(Person.from_dict, obj.get("people"))
        number = from_int(obj.get("number"))
        return AstronautsInSpace(message, people, number)

    def to_dict(self) -> dict:
        result: dict = {}
        result["message"] = from_str(self.message)
        result["people"] = from_list(lambda x: to_class(Person, x), self.people)
        result["number"] = from_int(self.number)
        return result


class IssPosition:
    longitude: str
    latitude: str

    def __init__(self, longitude: str, latitude: str) -> None:
        self.longitude = longitude
        self.latitude = latitude

    @staticmethod
    def from_dict(obj: Any) -> 'IssPosition':
        assert isinstance(obj, dict)
        longitude = from_str(obj.get("longitude"))
        latitude = from_str(obj.get("latitude"))
        return IssPosition(longitude, latitude)

    def to_dict(self) -> dict:
        result: dict = {}
        result["longitude"] = from_str(self.longitude)
        result["latitude"] = from_str(self.latitude)
        return result


class ISSCurrentLocation:
    iss_position: IssPosition
    timestamp: int
    message: str

    def __init__(self, iss_position: IssPosition, timestamp: int, message: str) -> None:
        self.iss_position = iss_position
        self.timestamp = timestamp
        self.message = message

    @staticmethod
    def from_dict(obj: Any) -> 'ISSCurrentLocation':
        assert isinstance(obj, dict)
        iss_position = IssPosition.from_dict(obj.get("iss_position"))
        timestamp = from_int(obj.get("timestamp"))
        message = from_str(obj.get("message"))
        return ISSCurrentLocation(iss_position, timestamp, message)

    def to_dict(self) -> dict:
        result: dict = {}
        result["iss_position"] = to_class(IssPosition, self.iss_position)
        result["timestamp"] = from_int(self.timestamp)
        result["message"] = from_str(self.message)
        return result


def astronauts_in_space_from_dict(s: Any) -> AstronautsInSpace:
    return AstronautsInSpace.from_dict(s)


def astronauts_in_space_to_dict(x: AstronautsInSpace) -> Any:
    return to_class(AstronautsInSpace, x)


def iss_current_location_from_dict(s: Any) -> ISSCurrentLocation:
    return ISSCurrentLocation.from_dict(s)


def iss_current_location_to_dict(x: ISSCurrentLocation) -> Any:
    return to_class(ISSCurrentLocation, x)
