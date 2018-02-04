package io.quicktype;

import java.util.Map;
import com.fasterxml.jackson.annotation.*;

public class Person {
    private String craft;
    private String name;

    @JsonProperty("craft")
    public String getCraft() { return craft; }
    @JsonProperty("craft")
    public void setCraft(String value) { this.craft = value; }

    @JsonProperty("name")
    public String getName() { return name; }
    @JsonProperty("name")
    public void setName(String value) { this.name = value; }
}
