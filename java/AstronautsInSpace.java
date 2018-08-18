package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class AstronautsInSpace {
    private String message;
    private Person[] people;
    private long number;

    @JsonProperty("message")
    public String getMessage() { return message; }
    @JsonProperty("message")
    public void setMessage(String value) { this.message = value; }

    @JsonProperty("people")
    public Person[] getPeople() { return people; }
    @JsonProperty("people")
    public void setPeople(Person[] value) { this.people = value; }

    @JsonProperty("number")
    public long getNumber() { return number; }
    @JsonProperty("number")
    public void setNumber(long value) { this.number = value; }
}
