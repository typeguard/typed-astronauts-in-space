// To parse this data:
//
//   import { Convert, AstronautsInSpace, ISSCurrentLocation } from "./file";
//
//   const astronautsInSpace = Convert.toAstronautsInSpace(json);
//   const iSSCurrentLocation = Convert.toISSCurrentLocation(json);
//
// These functions will throw an error if the JSON doesn't
// match the expected interface, even if the JSON is valid.

export interface AstronautsInSpace {
    number:  number;
    people:  Person[];
    message: string;
}

export interface Person {
    craft: string;
    name:  string;
}

export interface ISSCurrentLocation {
    iss_position: IssPosition;
    timestamp:    number;
    message:      string;
}

export interface IssPosition {
    longitude: string;
    latitude:  string;
}

// Converts JSON strings to/from your types
// and asserts the results of JSON.parse at runtime
export module Convert {
    export function toAstronautsInSpace(json: string): AstronautsInSpace {
        return cast(JSON.parse(json), O("AstronautsInSpace"));
    }

    export function astronautsInSpaceToJson(value: AstronautsInSpace): string {
        return JSON.stringify(value, null, 2);
    }

    export function toISSCurrentLocation(json: string): ISSCurrentLocation {
        return cast(JSON.parse(json), O("ISSCurrentLocation"));
    }

    export function iSSCurrentLocationToJson(value: ISSCurrentLocation): string {
        return JSON.stringify(value, null, 2);
    }
    
    function cast<T>(obj: any, typ: any): T {
        if (!isValid(typ, obj)) {
            throw `Invalid value`;
        }
        return obj;
    }

    function isValid(typ: any, val: any): boolean {
        if (typ === undefined) return true;
        if (typ === null) return val === null || val === undefined;
        return typ.isUnion  ? isValidUnion(typ.typs, val)
                : typ.isArray  ? isValidArray(typ.typ, val)
                : typ.isMap    ? isValidMap(typ.typ, val)
                : typ.isEnum   ? isValidEnum(typ.name, val)
                : typ.isObject ? isValidObject(typ.cls, val)
                :                isValidPrimitive(typ, val);
    }

    function isValidPrimitive(typ: string, val: any) {
        return typeof typ === typeof val;
    }

    function isValidUnion(typs: any[], val: any): boolean {
        // val must validate against one typ in typs
        return typs.find(typ => isValid(typ, val)) !== undefined;
    }

    function isValidEnum(enumName: string, val: any): boolean {
        const cases = typeMap[enumName];
        return cases.indexOf(val) !== -1;
    }

    function isValidArray(typ: any, val: any): boolean {
        // val must be an array with no invalid elements
        return Array.isArray(val) && val.every((element, i) => {
            return isValid(typ, element);
        });
    }

    function isValidMap(typ: any, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        // all values in the map must be typ
        return Object.keys(val).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(val, prop)) return true;
            return isValid(typ, val[prop]);
        });
    }

    function isValidObject(className: string, val: any): boolean {
        if (val === null || typeof val !== "object" || Array.isArray(val)) return false;
        let typeRep = typeMap[className];
        return Object.keys(typeRep).every(prop => {
            if (!Object.prototype.hasOwnProperty.call(typeRep, prop)) return true;
            return isValid(typeRep[prop], val[prop]);
        });
    }

    function A(typ: any) {
        return { typ, isArray: true };
    }

    function E(name: string) {
        return { name, isEnum: true };
    }

    function U(...typs: any[]) {
        return { typs, isUnion: true };
    }

    function M(typ: any) {
        return { typ, isMap: true };
    }

    function O(className: string) {
        return { cls: className, isObject: true };
    }

    const typeMap: any = {
        "AstronautsInSpace": {
            number: 0,
            people: A(O("Person")),
            message: "",
        },
        "Person": {
            craft: "",
            name: "",
        },
        "ISSCurrentLocation": {
            iss_position: O("IssPosition"),
            timestamp: 0,
            message: "",
        },
        "IssPosition": {
            longitude: "",
            latitude: "",
        },
    };
}
