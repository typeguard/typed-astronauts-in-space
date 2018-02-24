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
    return cast(JSON.parse(json), o("AstronautsInSpace"));
}

function astronautsInSpaceToJson(value) {
    return JSON.stringify(value, null, 2);
}

function toISSCurrentLocation(json) {
    return cast(JSON.parse(json), o("ISSCurrentLocation"));
}

function iSSCurrentLocationToJson(value) {
    return JSON.stringify(value, null, 2);
}

function cast(obj, typ) {
    if (!isValid(typ, obj)) {
        throw `Invalid value`;
    }
    return obj;
}

function isValid(typ, val) {
    if (typ === undefined) return true;
    if (typ === null) return val === null || val === undefined;
    return typ.isUnion  ? isValidUnion(typ.typs, val)
            : typ.isArray  ? isValidArray(typ.typ, val)
            : typ.isMap    ? isValidMap(typ.typ, val)
            : typ.isEnum   ? isValidEnum(typ.name, val)
            : typ.isObject ? isValidObject(typ.cls, val)
            :                isValidPrimitive(typ, val);
}

function isValidPrimitive(typ, val) {
    return typeof typ === typeof val;
}

function isValidUnion(typs, val) {
    // val must validate against one typ in typs
    return typs.find(typ => isValid(typ, val)) !== undefined;
}

function isValidEnum(enumName, val) {
    const cases = typeMap[enumName];
    return cases.indexOf(val) !== -1;
}

function isValidArray(typ, val) {
    // val must be an array with no invalid elements
    return Array.isArray(val) && val.every(element => {
        return isValid(typ, element);
    });
}

function isValidMap(typ, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    // all values in the map must be typ
    return Object.keys(val).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
        return isValid(typ, val[prop]);
    });
}

function isValidObject(className, val) {
    if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
    let typeRep = typeMap[className];
    return Object.keys(typeRep).every(prop => {
        if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
        return isValid(typeRep[prop], val[prop]);
    });
}

function a(typ) {
    return { typ, isArray: true };
}

function e(name) {
    return { name, isEnum: true };
}

function u(...typs) {
    return { typs, isUnion: true };
}

function m(typ) {
    return { typ, isMap: true };
}

function o(className) {
    return { cls: className, isObject: true };
}

const typeMap = {
    "AstronautsInSpace": {
        number: 0,
        people: a(o("Person")),
        message: "",
    },
    "Person": {
        craft: "",
        name: "",
    },
    "ISSCurrentLocation": {
        iss_position: o("IssPosition"),
        message: "",
        timestamp: 0,
    },
    "IssPosition": {
        latitude: "",
        longitude: "",
    },
};

module.exports = {
    "astronautsInSpaceToJson": astronautsInSpaceToJson,
    "toAstronautsInSpace": toAstronautsInSpace,
    "iSSCurrentLocationToJson": iSSCurrentLocationToJson,
    "toISSCurrentLocation": toISSCurrentLocation,
};
