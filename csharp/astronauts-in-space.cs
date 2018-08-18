// To parse this JSON data, add NuGet 'Newtonsoft.Json' then do one of these:
//
//    using QuickType;
//
//    var astronautsInSpace = AstronautsInSpace.FromJson(jsonString);
//    var issCurrentLocation = IssCurrentLocation.FromJson(jsonString);

namespace QuickType
{
    using System;
    using System.Collections.Generic;

    using System.Globalization;
    using Newtonsoft.Json;
    using Newtonsoft.Json.Converters;

    public partial class AstronautsInSpace
    {
        [JsonProperty("message")]
        public string Message { get; set; }

        [JsonProperty("people")]
        public Person[] People { get; set; }

        [JsonProperty("number")]
        public long Number { get; set; }
    }

    public partial class Person
    {
        [JsonProperty("craft")]
        public string Craft { get; set; }

        [JsonProperty("name")]
        public string Name { get; set; }
    }

    public partial class IssCurrentLocation
    {
        [JsonProperty("iss_position")]
        public IssPosition IssPosition { get; set; }

        [JsonProperty("timestamp")]
        public long Timestamp { get; set; }

        [JsonProperty("message")]
        public string Message { get; set; }
    }

    public partial class IssPosition
    {
        [JsonProperty("longitude")]
        public string Longitude { get; set; }

        [JsonProperty("latitude")]
        public string Latitude { get; set; }
    }

    public partial class AstronautsInSpace
    {
        public static AstronautsInSpace FromJson(string json) => JsonConvert.DeserializeObject<AstronautsInSpace>(json, QuickType.Converter.Settings);
    }

    public partial class IssCurrentLocation
    {
        public static IssCurrentLocation FromJson(string json) => JsonConvert.DeserializeObject<IssCurrentLocation>(json, QuickType.Converter.Settings);
    }

    public static class Serialize
    {
        public static string ToJson(this AstronautsInSpace self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
        public static string ToJson(this IssCurrentLocation self) => JsonConvert.SerializeObject(self, QuickType.Converter.Settings);
    }

    internal static class Converter
    {
        public static readonly JsonSerializerSettings Settings = new JsonSerializerSettings
        {
            MetadataPropertyHandling = MetadataPropertyHandling.Ignore,
            DateParseHandling = DateParseHandling.None,
            Converters = {
                new IsoDateTimeConverter { DateTimeStyles = DateTimeStyles.AssumeUniversal }
            },
        };
    }
}
