// To parse this data:
//
//   const Convert = require("./file");
//
//   const astronautsInSpace = Convert.toAstronautsInSpace(json);
//   const iSSCurrentLocation = Convert.toISSCurrentLocation(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
function toAstronautsInSpace(json) {
    return cast(JSON.parse(json), r("AstronautsInSpace"));
}

function astronautsInSpaceToJson(value) {
    return JSON.stringify(uncast(value, r("AstronautsInSpace")), null, 2);
}

function toISSCurrentLocation(json) {
    return cast(JSON.parse(json), r("ISSCurrentLocation"));
}

function iSSCurrentLocationToJson(value) {
    return JSON.stringify(uncast(value, r("ISSCurrentLocation")), null, 2);
}

function invalidValue(typ, val) {
    throw Error(`Invalid value ${JSON.stringify(val)} for type ${JSON.stringify(typ)}`);
}

function jsonToJSProps(typ) {
    if (typ.jsonToJS === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.json] = { key: p.js, typ: p.typ });
        typ.jsonToJS = map;
    }
    return typ.jsonToJS;
}

function jsToJSONProps(typ) {
    if (typ.jsToJSON === undefined) {
        var map = {};
        typ.props.forEach((p) => map[p.js] = { key: p.json, typ: p.typ });
        typ.jsToJSON = map;
    }
    return typ.jsToJSON;
}

function transform(val, typ, getProps) {
    function transformPrimitive(typ, val) {
        if (typeof typ === typeof val) return val;
        return invalidValue(typ, val);
    }

    function transformUnion(typs, val) {
        // val must validate against one typ in typs
        var l = typs.length;
        for (var i = 0; i < l; i++) {
            var typ = typs[i];
            try {
                return transform(val, typ, getProps);
            } catch (_) {}
        }
        return invalidValue(typs, val);
    }

    function transformEnum(cases, val) {
        if (cases.indexOf(val) !== -1) return val;
        return invalidValue(cases, val);
    }

    function transformArray(typ, val) {
        // val must be an array with no invalid elements
        if (!Array.isArray(val)) return invalidValue("array", val);
        return val.map(el => transform(el, typ, getProps));
    }

    function transformObject(props, additional, val) {
        if (val === null || typeof val !== "object" || Array.isArray(val)) {
            return invalidValue("object", val);
        }
        var result = {};
        Object.getOwnPropertyNames(props).forEach(key => {
            const prop = props[key];
            const v = Object.prototype.hasOwnProperty.call(val, key) ? val[key] : undefined;
            result[prop.key] = transform(v, prop.typ, getProps);
        });
        Object.getOwnPropertyNames(val).forEach(key => {
            if (!Object.prototype.hasOwnProperty.call(props, key)) {
                result[key] = transform(val[key], additional, getProps);
            }
        });
        return result;
    }

    if (typ === "any") return val;
    if (typ === null) {
        if (val === null) return val;
        return invalidValue(typ, val);
    }
    if (typ === false) return invalidValue(typ, val);
    while (typeof typ === "object" && typ.ref !== undefined) {
        typ = typeMap[typ.ref];
    }
    if (Array.isArray(typ)) return transformEnum(typ, val);
    if (typeof typ === "object") {
        return typ.hasOwnProperty("unionMembers") ? transformUnion(typ.unionMembers, val)
            : typ.hasOwnProperty("arrayItems")    ? transformArray(typ.arrayItems, val)
            : typ.hasOwnProperty("props")         ? transformObject(getProps(typ), typ.additional, val)
            : invalidValue(typ, val);
    }
    return transformPrimitive(typ, val);
}

function cast(val, typ) {
    return transform(val, typ, jsonToJSProps);
}

function uncast(val, typ) {
    return transform(val, typ, jsToJSONProps);
}

function a(typ) {
    return { arrayItems: typ };
}

function u(...typs) {
    return { unionMembers: typs };
}

function o(props, additional) {
    return { props, additional };
}

function m(additional) {
    return { props: [], additional };
}

function r(name) {
    return { ref: name };
}

const typeMap = {
    "AstronautsInSpace": o([
        { json: "message", js: "message", typ: "" },
        { json: "people", js: "people", typ: a(r("Person")) },
        { json: "number", js: "number", typ: 0 },
    ], false),
    "Person": o([
        { json: "craft", js: "craft", typ: "" },
        { json: "name", js: "name", typ: "" },
    ], false),
    "ISSCurrentLocation": o([
        { json: "iss_position", js: "iss_position", typ: r("IssPosition") },
        { json: "timestamp", js: "timestamp", typ: 0 },
        { json: "message", js: "message", typ: "" },
    ], false),
    "IssPosition": o([
        { json: "longitude", js: "longitude", typ: "" },
        { json: "latitude", js: "latitude", typ: "" },
    ], false),
};

module.exports = {
    "astronautsInSpaceToJson": astronautsInSpaceToJson,
    "toAstronautsInSpace": toAstronautsInSpace,
    "iSSCurrentLocationToJson": iSSCurrentLocationToJson,
    "toISSCurrentLocation": toISSCurrentLocation,
};
