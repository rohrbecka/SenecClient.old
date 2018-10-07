//
//  SenecValue.swift
//  SenecClient
//
//  Created by André Rohrbeck on 07.10.18.
//

import Foundation


/// A value in the Senecs JSON API.
///
/// - Author:       André Rohrbeck
/// - Copyright:    André Rohrbeck © 2018
/// - Date:         2018-10-07
internal enum SenecValue: Equatable {

    case float (_ value: Double)
    case uint8 (_ value: UInt8)
    case uint16 (_ value: UInt16)
    case uint32 (_ value: UInt32)
    case uint64 (_ value: UInt64)
    case int8 (_ value: Int8)
    case int16 (_ value: Int16)
    case int32 (_ value: Int32)
    case int64 (_ value: Int64)
    case string (_ value: String)
    case char (_ value: Character)



    internal init?(string: String) {
        guard let type = SenecValueType(of: string) else {
            return nil
        }
        let stringWithoutPrefix = string.senecPrefixRemoved

        switch type {
        case .float:
            guard let floatValue = hexToFloat(stringWithoutPrefix) else { return nil }
            self = .float(floatValue)
        case .uint8:
            guard let intValue = UInt8(stringWithoutPrefix, radix: 16) else { return nil }
            self = .uint8(intValue)
        case .uint16:
            guard let intValue = UInt16(stringWithoutPrefix, radix: 16) else { return nil }
            self = .uint16(intValue)
        case .uint32:
            guard let intValue = UInt32(stringWithoutPrefix, radix: 16) else { return nil }
            self = .uint32(intValue)
        case .uint64:
            guard let intValue = UInt64(stringWithoutPrefix, radix: 16) else { return nil }
            self = .uint64(intValue)
        case .int8:
            guard let intValue = UInt8(stringWithoutPrefix, radix: 16) else { return nil }
            self = .int8(Int8(bitPattern: intValue))
        case .int16:
            guard let intValue = UInt16(stringWithoutPrefix, radix: 16) else { return nil }
            self = .int16(Int16(bitPattern: intValue))
        case .int32:
            guard let intValue = UInt32(stringWithoutPrefix, radix: 16) else { return nil }
            self = .int32(Int32(bitPattern: intValue))
        case .int64:
            guard let intValue = UInt64(stringWithoutPrefix, radix: 16) else { return nil }
            self = .int64(Int64(bitPattern: intValue))
        case .char:
            NSLog("char format for Senec Values is not supported yet.")
            return nil
        case .string:
            NSLog("string format for Senec Values is not supported yet.")
            return nil
        }
    }



    /// Returns the `Double` value represented by this `SenecValue`.
    internal var double: Double? {
        switch self {
        case .float(let value):
            return value;
        default:
            return nil
        }
    }


    internal var int: Int? {
        switch self {
        case .uint8(let value):
            return Int(value)
        default:
            return nil
        }
    }
}



/// Converts a hexadecimal `string` representation into a Double value.
fileprivate func hexToFloat(_ string: String) -> Double? {
    guard let intValue = Int(string, radix: 16) else {
        return nil
    }

    let sign = intValue & 0x8000_0000 != 0 ? -1.0 : 1.0
    let exponent = Double( ((intValue >> 23) & 0xff) - 127 )
    let mantissa = 1 + (Double (intValue & 0x7f_ffff) / Double (0x7f_ffff))
    let floatValue = sign * mantissa * pow(2.0, exponent)
    return floatValue
}



fileprivate extension String {
    /// Returns the string. If the string has a Senec-type prefix (something before a '_')
    /// the prefix including the underscore is removed.
    var senecPrefixRemoved: String {
        guard let endOfPrefix = self.firstIndex(of: "_") else {
            return self
        }
        let beginningOfSubstring = self.index(after: endOfPrefix)
        return String(self[beginningOfSubstring...])
    }
}
