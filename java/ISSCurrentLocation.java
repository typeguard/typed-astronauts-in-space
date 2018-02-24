package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class ISSCurrentLocation {
    private IssPosition issPosition;
    private String message;
    private long timestamp;

    @JsonProperty("iss_position")
    public IssPosition getIssPosition() { return issPosition; }
    @JsonProperty("iss_position")
    public void setIssPosition(IssPosition value) { this.issPosition = value; }

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("timestamp")
    public long getTimestamp() { return timestamp; }
    @JsonProperty("timestamp")
    public void setTimestamp(long value) { this.timestamp = value; }
}
