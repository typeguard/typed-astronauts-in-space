package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class IssPosition {
    private String longitude;
    private String latitude;

    @JsonProperty("longitude")
    public String getLongitude() { return longitude; }
    @JsonProperty("longitude")
    public void setLongitude(String value) { this.longitude = value; }

    @JsonProperty("latitude")
    public String getLatitude() { return latitude; }
    @JsonProperty("latitude")
    public void setLatitude(String value) { this.latitude = value; }
}
