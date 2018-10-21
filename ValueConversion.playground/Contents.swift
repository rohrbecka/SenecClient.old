import Cocoa
import SenecClient



let now = Date()
let unix = now.timeIntervalSince1970





let GUI_BAT_DATA_POWER = SenecValue(string: "fl_41BE04C1") // negative = discharging, positive = charging
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



let hostName = "http://192.168.178.79"
let scriptURL = URL(string: hostName + "/lala.cgi")


let requestString = """
{
"STATISTIC": {
"STAT_DAY_E_HOUSE": "",
"STAT_DAY_E_PV": "",
"STAT_DAY_BAT_CHARGE": "",
"STAT_DAY_BAT_DISCHARGE": "",
"STAT_DAY_E_GRID_IMPORT": "",
"STAT_DAY_E_GRID_EXPORT": "",
"STAT_YEAR_E_PU1_ARR": ""
},
"ENERGY": {
"STAT_STATE": "",
"STAT_STATE_DECODE": "",
"GUI_BAT_DATA_POWER": "",
"GUI_INVERTER_POWER": "",
"GUI_HOUSE_POW": "",
"GUI_GRID_POW": "",
"STAT_MAINT_REQUIRED": "",
"GUI_BAT_DATA_FUEL_CHARGE": "",
"GUI_CHARGING_INFO": "",
"GUI_BOOSTING_INFO": ""
},
"WIZARD": {
"CONFIG_LOADED": ""
},
"SYS_UPDATE": {
"UPDATE_AVAILABLE": ""
}
}
"""


let request2 = """
{ "STATISTIC": {
"STAT_DAY_E_HOUSE": "",
"STAT_DAY_E_PV": "",
"STAT_DAY_BAT_CHARGE": "",
"STAT_DAY_BAT_DISCHARGE": "",
"STAT_DAY_E_GRID_IMPORT": "",
"STAT_DAY_E_GRID_EXPORT": "",
"STAT_YEAR_E_PU1_ARR": ""
}}
"""

let flowRequest = """
{"ENERGY": {
"GUI_BAT_DATA_POWER": "",
"GUI_INVERTER_POWER": "",
"GUI_HOUSE_POW": "",
"GUI_GRID_POW": "",
"GUI_BAT_DATA_FUEL_CHARGE": ""
}}
"""


let socketRequest = """
{
"ENERGY": {
"GUI_POW_SOCK_0_FORCE_ON": "",

"GUI_POW_SOCK_0_ENABLE": "",
"GUI_SOCK_0_DATA_MIN_POW": "",
"GUI_SOCK_0_DATA_MIN_TIME": "",
"GUI_SOCK_0_DATA_ON_TIME": "",
"GUI_SOCK_0_DATA_MAX_TIME": "",

"GUI_POW_SOCK_0_POW_ON": "",
"GUI_POW_SOCK_0_TIME_REM": "",


"GUI_POW_SOCK_1_FORCE_ON": "",

"GUI_POW_SOCK_1_ENABLE": "",
"GUI_SOCK_1_DATA_MIN_POW": "",
"GUI_SOCK_1_DATA_MIN_TIME": "",
"GUI_SOCK_1_DATA_ON_TIME": "",
"GUI_SOCK_1_DATA_MAX_TIME": "",

"GUI_POW_SOCK_1_POW_ON": "",
"GUI_POW_SOCK_1_TIME_REM": ""
}
}
"""

let session = URLSession.shared

var request = URLRequest (url: scriptURL!)
request.httpMethod = "POST"
request.httpBody = socketRequest.data(using: .utf8)
request.addValue("application/json", forHTTPHeaderField: "Accept")
request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content")

let task = session.dataTask(with: request) {data, response, error in
    let str = String(data: data!, encoding: .utf8)

    if let data = data {
        let result = try? JSONDecoder().decode(SenecSockets.self, from: data)
        print (result)
//        print (result?.batteryPowerFlow)
//        print (result?.photovoltaicPowerGeneration)
//        print (result?.gridPowerFlow)
//        print (result?.housePowerConsumption)
//        print (result)
    }

    print (data?.description ?? "")
    print (response?.description ?? "")
    print (error?.localizedDescription ?? "")
}
task.resume()
