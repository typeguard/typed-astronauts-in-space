// To parse the JSON, install Klaxon and do:
//
//   val astronautsInSpace = AstronautsInSpace.fromJson(jsonString)
//   val iSSCurrentLocation = ISSCurrentLocation.fromJson(jsonString)

package quicktype

import com.beust.klaxon.*

private val klaxon = Klaxon()

data class AstronautsInSpace (
    val message: String,
    val people: List<Person>,
    val number: Long
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<AstronautsInSpace>(json)
    }
}

data class Person (
    val craft: String,
    val name: String
)

data class ISSCurrentLocation (
    @Json(name = "iss_position")
    val issPosition: IssPosition,

    val timestamp: Long,
    val message: String
) {
    public fun toJson() = klaxon.toJsonString(this)

    companion object {
        public fun fromJson(json: String) = klaxon.parse<ISSCurrentLocation>(json)
    }
}

data class IssPosition (
    val longitude: String,
    val latitude: String
)
