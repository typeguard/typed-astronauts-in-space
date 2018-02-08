//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     AstronautsInSpace data = nlohmann::json::parse(jsonString);
//     IssCurrentLocation data = nlohmann::json::parse(jsonString);

#include "json.hpp"

namespace quicktype {
    using nlohmann::json;

    struct Person {
        std::string craft;
        std::string name;
    };

    struct AstronautsInSpace {
        int64_t number;
        std::vector<struct Person> people;
        std::string message;
    };

    struct IssPosition {
        std::string longitude;
        std::string latitude;
    };

    struct IssCurrentLocation {
        struct IssPosition iss_position;
        int64_t timestamp;
        std::string message;
    };
    
    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }
}

namespace nlohmann {

    inline void from_json(const json& _j, struct quicktype::Person& _x) {
        _x.craft = _j.at("craft").get<std::string>();
        _x.name = _j.at("name").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::Person& _x) {
        _j = json::object();
        _j["craft"] = _x.craft;
        _j["name"] = _x.name;
    }

    inline void from_json(const json& _j, struct quicktype::AstronautsInSpace& _x) {
        _x.number = _j.at("number").get<int64_t>();
        _x.people = _j.at("people").get<std::vector<struct quicktype::Person>>();
        _x.message = _j.at("message").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::AstronautsInSpace& _x) {
        _j = json::object();
        _j["number"] = _x.number;
        _j["people"] = _x.people;
        _j["message"] = _x.message;
    }

    inline void from_json(const json& _j, struct quicktype::IssPosition& _x) {
        _x.longitude = _j.at("longitude").get<std::string>();
        _x.latitude = _j.at("latitude").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::IssPosition& _x) {
        _j = json::object();
        _j["longitude"] = _x.longitude;
        _j["latitude"] = _x.latitude;
    }

    inline void from_json(const json& _j, struct quicktype::IssCurrentLocation& _x) {
        _x.iss_position = _j.at("iss_position").get<struct quicktype::IssPosition>();
        _x.timestamp = _j.at("timestamp").get<int64_t>();
        _x.message = _j.at("message").get<std::string>();
    }

    inline void to_json(json& _j, const struct quicktype::IssCurrentLocation& _x) {
        _j = json::object();
        _j["iss_position"] = _x.iss_position;
        _j["timestamp"] = _x.timestamp;
        _j["message"] = _x.message;
    }
}
