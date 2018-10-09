import Cocoa
import SenecClient



let now = Date()
let unix = now.timeIntervalSince1970





let GUI_BAT_DATA_POWER = SenecValue(string: "fl_C3FF68B3") // negative = discharging, positive = charging
let GUI_HOUSE_POW = SenecValue(string: "fl_43F59E76") // Hausverbrauch, always positive
let GUI_GRID_POW = SenecValue(string: "fl_C19CA3D7") // negative = sending to grid, positive: getting from grid)
let GUI_BAT_DATA_FUEL_CHARGE = SenecValue(string: "fl_4287A5E4") // Battery SoC
let GUI_INVERTER_POWER = SenecValue(string: "fl_80000000") // PV generation


// Conversion of float into a value
let floatPrefix = "fl_"
//let hexString = floatString.dropFirst(floatPrefix.count).lowercased()
//
//guard let intValue = Int(hexString, radix: 16) else {
//    preconditionFailure("float value malformed")
//}
//
//let sign = intValue & 0x8000_0000 != 0 ? -1.0 : 1.0
//let exponent = Double( ((intValue >> 23) & 0xff) - 127 )
//let mantissa = 1 + (Double (intValue & 0x7f_ffff) / Double (0x7f_ffff))
//let floatValue = sign * mantissa * pow(2.0, exponent)
