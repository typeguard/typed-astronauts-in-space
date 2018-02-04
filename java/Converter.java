// To use this code, add the following Maven dependency to your project:
//
//     com.fasterxml.jackson.core : jackson-databind : 2.9.0
//
// Import this package:
//
//     import io.quicktype.Converter;
//
// Then you can deserialize a JSON string with
//
//     AstronautsInSpace data = Converter.AstronautsInSpaceFromJsonString(jsonString);
//     ISSCurrentLocation data = Converter.ISSCurrentLocationFromJsonString(jsonString);

package io.quicktype;

import java.util.Map;
import java.io.IOException;
import com.fasterxml.jackson.databind.*;
import com.fasterxml.jackson.core.JsonProcessingException;

public class Converter {
    // Serialize/deserialize helpers

    public static AstronautsInSpace AstronautsInSpaceFromJsonString(String json) throws IOException {
        return getAstronautsInSpaceObjectReader().readValue(json);
    }

    public static String AstronautsInSpaceToJsonString(AstronautsInSpace obj) throws JsonProcessingException {
        return getAstronautsInSpaceObjectWriter().writeValueAsString(obj);
    }

    public static ISSCurrentLocation ISSCurrentLocationFromJsonString(String json) throws IOException {
        return getISSCurrentLocationObjectReader().readValue(json);
    }

    public static String ISSCurrentLocationToJsonString(ISSCurrentLocation obj) throws JsonProcessingException {
        return getISSCurrentLocationObjectWriter().writeValueAsString(obj);
    }

    private static ObjectReader AstronautsInSpaceReader;
    private static ObjectWriter AstronautsInSpaceWriter;

    private static void instantiateAstronautsInSpaceMapper() {
        ObjectMapper mapper = new ObjectMapper();
        AstronautsInSpaceReader = mapper.reader(AstronautsInSpace.class);
        AstronautsInSpaceWriter = mapper.writerFor(AstronautsInSpace.class);
    }

    private static ObjectReader getAstronautsInSpaceObjectReader() {
        if (AstronautsInSpaceReader == null) instantiateMapper();
        return AstronautsInSpaceReader;
    }

    private static ObjectWriter getAstronautsInSpaceObjectWriter() {
        if (AstronautsInSpaceWriter == null) instantiateMapper();
        return AstronautsInSpaceWriter;
    }

    private static ObjectReader ISSCurrentLocationReader;
    private static ObjectWriter ISSCurrentLocationWriter;

    private static void instantiateISSCurrentLocationMapper() {
        ObjectMapper mapper = new ObjectMapper();
        ISSCurrentLocationReader = mapper.reader(ISSCurrentLocation.class);
        ISSCurrentLocationWriter = mapper.writerFor(ISSCurrentLocation.class);
    }

    private static ObjectReader getISSCurrentLocationObjectReader() {
        if (ISSCurrentLocationReader == null) instantiateMapper();
        return ISSCurrentLocationReader;
    }

    private static ObjectWriter getISSCurrentLocationObjectWriter() {
        if (ISSCurrentLocationWriter == null) instantiateMapper();
        return ISSCurrentLocationWriter;
    }
}
