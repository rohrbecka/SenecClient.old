import Foundation


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
{"STATISTIC": {
"STAT_DAY_E_HOUSE": "",
"STAT_DAY_E_PV": "",
"STAT_DAY_BAT_CHARGE": "",
"STAT_DAY_BAT_DISCHARGE": "",
"STAT_DAY_E_GRID_IMPORT": "",
"STAT_DAY_E_GRID_EXPORT": "",
"STAT_YEAR_E_PU1_ARR": ""
}
}
"""

let session = URLSession.shared

var request = URLRequest (url: scriptURL!)
request.httpMethod = "POST"
request.httpBody = request2.data(using: .utf8)
request.addValue("application/json", forHTTPHeaderField: "Accept")
request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content")

let task = session.dataTask(with: request) {data, response, error in
    let str = String(data: data!, encoding: .utf8)

    let result = JSONDecoder().decode(SenecEnergyStatistic.self, from: data)
    print (result)

    print (data?.description ?? "")
    print (response?.description ?? "")
    print (error?.localizedDescription ?? "")
}
task.resume()
