import Cocoa





let floatString = "fl_40B2E822";





// Conversion of float into a value
let floatPrefix = "fl_"
guard floatString.hasPrefix(floatPrefix) else {
    preconditionFailure("Not a float string.")
}
let hexString = floatString.dropFirst(floatPrefix.count).lowercased()

guard let intValue = Int(hexString, radix: 16) else {
    preconditionFailure("float value malformed")
}

let sign = intValue & 0x8000_0000 != 0 ? -1.0 : 1.0
let exponent = Double( ((intValue >> 23) & 0xff) - 127 )
let mantissa = 1 + (Double (intValue & 0x7f_ffff) / Double (0x7f_ffff))
let floatValue = sign * mantissa * pow(2.0, exponent)


