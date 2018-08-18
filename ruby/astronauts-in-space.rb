# This code may look unusually verbose for Ruby (and it is), but
# it performs some subtle and complex validation of JSON data.
#
# To parse this JSON, add 'dry-struct' and 'dry-types' gems, then do:
#
#   astronauts_in_space = AstronautsInSpace.from_json! "{…}"
#   puts astronauts_in_space.people.first.craft
#
#   iss_current_location = ISSCurrentLocation.from_json! "{…}"
#   puts iss_current_location.iss_position.longitude
#
# If from_json! succeeds, the value returned matches the schema.

require 'json'
require 'dry-types'
require 'dry-struct'

module Types
  include Dry::Types.module

  Int    = Strict::Int
  Hash   = Strict::Hash
  String = Strict::String
end

class Person < Dry::Struct
  attribute :craft,       Types::String
  attribute :person_name, Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      craft:       d.fetch("craft"),
      person_name: d.fetch("name"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "craft" => @craft,
      "name"  => @person_name,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class AstronautsInSpace < Dry::Struct
  attribute :message, Types::String
  attribute :people,  Types.Array(Person)
  attribute :number,  Types::Int

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      message: d.fetch("message"),
      people:  d.fetch("people").map { |x| Person.from_dynamic!(x) },
      number:  d.fetch("number"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "message" => @message,
      "people"  => @people.map { |x| x.to_dynamic },
      "number"  => @number,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class IssPosition < Dry::Struct
  attribute :longitude, Types::String
  attribute :latitude,  Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      longitude: d.fetch("longitude"),
      latitude:  d.fetch("latitude"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "longitude" => @longitude,
      "latitude"  => @latitude,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end

class ISSCurrentLocation < Dry::Struct
  attribute :iss_position, IssPosition
  attribute :timestamp,    Types::Int
  attribute :message,      Types::String

  def self.from_dynamic!(d)
    d = Types::Hash[d]
    new(
      iss_position: IssPosition.from_dynamic!(d.fetch("iss_position")),
      timestamp:    d.fetch("timestamp"),
      message:      d.fetch("message"),
    )
  end

  def self.from_json!(json)
    from_dynamic!(JSON.parse(json))
  end

  def to_dynamic
    {
      "iss_position" => @iss_position.to_dynamic,
      "timestamp"    => @timestamp,
      "message"      => @message,
    }
  end

  def to_json(options = nil)
    JSON.generate(to_dynamic, options)
  end
end
