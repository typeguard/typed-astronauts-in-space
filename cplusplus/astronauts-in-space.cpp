//  To parse this JSON data, first install
//
//      Boost     http://www.boost.org
//      json.hpp  https://github.com/nlohmann/json
//
//  Then include this file, and then do
//
//     AstronautsInSpace data = nlohmann::json::parse(jsonString);
//     IssCurrentLocation data = nlohmann::json::parse(jsonString);

#pragma once

#include "json.hpp"

#include <boost/optional.hpp>
#include <stdexcept>
#include <regex>
namespace quicktype {
    using nlohmann::json;

    inline json get_untyped(const json &j, const char *property) {
        if (j.find(property) != j.end()) {
            return j.at(property).get<json>();
        }
        return json();
    }

    class Person {
        public:
        Person() = default;
        virtual ~Person() = default;

        private:
        std::string craft;
        std::string name;

        public:
        const std::string & get_craft() const { return craft; }
        std::string & get_mutable_craft() { return craft; }
        void set_craft(const std::string& value) { this->craft = value; }

        const std::string & get_name() const { return name; }
        std::string & get_mutable_name() { return name; }
        void set_name(const std::string& value) { this->name = value; }
    };

    class AstronautsInSpace {
        public:
        AstronautsInSpace() = default;
        virtual ~AstronautsInSpace() = default;

        private:
        std::string message;
        std::vector<Person> people;
        int64_t number;

        public:
        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string& value) { this->message = value; }

        const std::vector<Person> & get_people() const { return people; }
        std::vector<Person> & get_mutable_people() { return people; }
        void set_people(const std::vector<Person>& value) { this->people = value; }

        const int64_t & get_number() const { return number; }
        int64_t & get_mutable_number() { return number; }
        void set_number(const int64_t& value) { this->number = value; }
    };

    class IssPosition {
        public:
        IssPosition() = default;
        virtual ~IssPosition() = default;

        private:
        std::string longitude;
        std::string latitude;

        public:
        const std::string & get_longitude() const { return longitude; }
        std::string & get_mutable_longitude() { return longitude; }
        void set_longitude(const std::string& value) { this->longitude = value; }

        const std::string & get_latitude() const { return latitude; }
        std::string & get_mutable_latitude() { return latitude; }
        void set_latitude(const std::string& value) { this->latitude = value; }
    };

    class IssCurrentLocation {
        public:
        IssCurrentLocation() = default;
        virtual ~IssCurrentLocation() = default;

        private:
        IssPosition iss_position;
        int64_t timestamp;
        std::string message;

        public:
        const IssPosition & get_iss_position() const { return iss_position; }
        IssPosition & get_mutable_iss_position() { return iss_position; }
        void set_iss_position(const IssPosition& value) { this->iss_position = value; }

        const int64_t & get_timestamp() const { return timestamp; }
        int64_t & get_mutable_timestamp() { return timestamp; }
        void set_timestamp(const int64_t& value) { this->timestamp = value; }

        const std::string & get_message() const { return message; }
        std::string & get_mutable_message() { return message; }
        void set_message(const std::string& value) { this->message = value; }
    };
}

namespace nlohmann {
    inline void from_json(const json& _j, quicktype::Person& _x) {
        _x.set_craft( _j.at("craft").get<std::string>() );
        _x.set_name( _j.at("name").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::Person& _x) {
        _j = json::object();
        _j["craft"] = _x.get_craft();
        _j["name"] = _x.get_name();
    }

    inline void from_json(const json& _j, quicktype::AstronautsInSpace& _x) {
        _x.set_message( _j.at("message").get<std::string>() );
        _x.set_people( _j.at("people").get<std::vector<quicktype::Person>>() );
        _x.set_number( _j.at("number").get<int64_t>() );
    }

    inline void to_json(json& _j, const quicktype::AstronautsInSpace& _x) {
        _j = json::object();
        _j["message"] = _x.get_message();
        _j["people"] = _x.get_people();
        _j["number"] = _x.get_number();
    }

    inline void from_json(const json& _j, quicktype::IssPosition& _x) {
        _x.set_longitude( _j.at("longitude").get<std::string>() );
        _x.set_latitude( _j.at("latitude").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::IssPosition& _x) {
        _j = json::object();
        _j["longitude"] = _x.get_longitude();
        _j["latitude"] = _x.get_latitude();
    }

    inline void from_json(const json& _j, quicktype::IssCurrentLocation& _x) {
        _x.set_iss_position( _j.at("iss_position").get<quicktype::IssPosition>() );
        _x.set_timestamp( _j.at("timestamp").get<int64_t>() );
        _x.set_message( _j.at("message").get<std::string>() );
    }

    inline void to_json(json& _j, const quicktype::IssCurrentLocation& _x) {
        _j = json::object();
        _j["iss_position"] = _x.get_iss_position();
        _j["timestamp"] = _x.get_timestamp();
        _j["message"] = _x.get_message();
    }
}
