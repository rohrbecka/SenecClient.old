//
//  SenecSockets.swift
//  SenecClient
//
//  Created by André Rohrbeck on 19.10.18.
//

import Foundation

public struct SenecSockets: Decodable {

    private let socketSettings: [SenecSocketSetting]



    public init (settings: [SenecSocketSetting]) {
        socketSettings = settings
    }



    public init(from decoder: Decoder) throws {
        let jsonEnergy = try JSONSocketsInformation(from: decoder)
        let jsonSockets = jsonEnergy.socketSettings

        let socket0Settings: SenecSocketSetting = {
            let trigger: SenecSocketSetting.AutomaticSocketModeTrigger = {
                let minTime = SenecValue(string: jsonSockets.socket0MinTimeString)?.intValue ?? 0
                let minPower = SenecValue(string: jsonSockets.socket0MinPowerString)?.intValue ?? 0
                let onTime = SenecValue(string: jsonSockets.socket0OnTimeString)?.intValue ?? 0
                let maxTime = SenecValue(string: jsonSockets.socket0MaxTimeString)?.intValue ?? 0
                return SenecSocketSetting.AutomaticSocketModeTrigger(minTime: minTime,
                                                                     minPower: minPower,
                                                                     onTime: onTime,
                                                                     maxTime: maxTime)
            }()
            let status: SenecSocketSetting.SocketStatus = {
                let powerOn = SenecValue(string: jsonSockets.socket0StatusOnString)?.boolValue ?? false
                let timeRemaining = SenecValue(string: jsonSockets.socket0TimeRemainingString)?.intValue ?? 0
                return SenecSocketSetting.SocketStatus(powerOn: powerOn, timeRemaining: timeRemaining)
            }()

            let mode: SenecSocketSetting.SocketMode = {
                let forced = SenecValue(string: jsonSockets.socket0ForcedOnString)?.boolValue ?? false
                let auto = SenecValue(string: jsonSockets.socket0AutomaticOnString)?.boolValue ?? false
                if !forced && !auto {
                    return .off
                } else if forced {
                    return .forced
                } else {
                    return .automatic
                }
            }()
            return SenecSocketSetting(mode: mode, trigger: trigger, status: status)
        }()

        let socket1Settings: SenecSocketSetting = {
            let trigger: SenecSocketSetting.AutomaticSocketModeTrigger = {
                let minTime = SenecValue(string: jsonSockets.socket1MinTimeString)?.intValue ?? 0
                let minPower = SenecValue(string: jsonSockets.socket1MinPowerString)?.intValue ?? 0
                let onTime = SenecValue(string: jsonSockets.socket1OnTimeString)?.intValue ?? 0
                let maxTime = SenecValue(string: jsonSockets.socket1MaxTimeString)?.intValue ?? 0
                return SenecSocketSetting.AutomaticSocketModeTrigger(minTime: minTime,
                                                                     minPower: minPower,
                                                                     onTime: onTime,
                                                                     maxTime: maxTime)
            }()
            let status: SenecSocketSetting.SocketStatus = {
                let powerOn = SenecValue(string: jsonSockets.socket1StatusOnString)?.boolValue ?? false
                let timeRemaining = SenecValue(string: jsonSockets.socket1TimeRemainingString)?.intValue ?? 0
                return SenecSocketSetting.SocketStatus(powerOn: powerOn, timeRemaining: timeRemaining)
            }()

            let mode: SenecSocketSetting.SocketMode = {
                let forced = SenecValue(string: jsonSockets.socket1ForcedOnString)?.boolValue ?? false
                let auto = SenecValue(string: jsonSockets.socket1AutomaticOnString)?.boolValue ?? false
                if !forced && !auto {
                    return .off
                } else if forced {
                    return .forced
                } else {
                    return .automatic
                }
            }()
            return SenecSocketSetting(mode: mode, trigger: trigger, status: status)
        }()
        self.init(settings: [socket0Settings, socket1Settings])
    }


    public subscript (index: Int) -> SenecSocketSetting {
        return socketSettings[index]
    }

}



internal struct JSONSocketsInformation: Codable, Equatable {

    fileprivate let socketSettings: JSONSenecSocketSettings

    private enum CodingKeys: String, CodingKey {
        case socketSettings = "ENERGY"
    }

    public init() {
        socketSettings = JSONSenecSocketSettings (socket0ForcedOnString: "",
                                                  socket0AutomaticOnString: "",
                                                  socket0MinPowerString: "",
                                                  socket0MinTimeString: "",
                                                  socket0OnTimeString: "",
                                                  socket0MaxTimeString: "",
                                                  socket0StatusOnString: "",
                                                  socket0TimeRemainingString: "",
                                                  socket1ForcedOnString: "",
                                                  socket1AutomaticOnString: "",
                                                  socket1MinPowerString: "",
                                                  socket1MinTimeString: "",
                                                  socket1OnTimeString: "",
                                                  socket1MaxTimeString: "",
                                                  socket1StatusOnString: "",
                                                  socket1TimeRemainingString: "")
    }
}


private struct JSONSenecSocketSettings: Codable, Equatable {
    let socket0ForcedOnString: String
    let socket0AutomaticOnString: String
    let socket0MinPowerString: String
    let socket0MinTimeString: String
    let socket0OnTimeString: String
    let socket0MaxTimeString: String
    let socket0StatusOnString: String
    let socket0TimeRemainingString: String

    let socket1ForcedOnString: String
    let socket1AutomaticOnString: String
    let socket1MinPowerString: String
    let socket1MinTimeString: String
    let socket1OnTimeString: String
    let socket1MaxTimeString: String
    let socket1StatusOnString: String
    let socket1TimeRemainingString: String

    enum CodingKeys: String, CodingKey {
        case socket0ForcedOnString = "GUI_POW_SOCK_0_FORCE_ON"
        case socket0AutomaticOnString = "GUI_POW_SOCK_0_ENABLE"
        case socket0MinPowerString = "GUI_SOCK_0_DATA_MIN_POW"
        case socket0MinTimeString = "GUI_SOCK_0_DATA_MIN_TIME"
        case socket0OnTimeString = "GUI_SOCK_0_DATA_ON_TIME"
        case socket0MaxTimeString = "GUI_SOCK_0_DATA_MAX_TIME"
        case socket0StatusOnString = "GUI_POW_SOCK_0_POW_ON"
        case socket0TimeRemainingString = "GUI_POW_SOCK_0_TIME_REM"

        case socket1ForcedOnString = "GUI_POW_SOCK_1_FORCE_ON"
        case socket1AutomaticOnString = "GUI_POW_SOCK_1_ENABLE"
        case socket1MinPowerString = "GUI_SOCK_1_DATA_MIN_POW"
        case socket1MinTimeString = "GUI_SOCK_1_DATA_MIN_TIME"
        case socket1OnTimeString = "GUI_SOCK_1_DATA_ON_TIME"
        case socket1MaxTimeString = "GUI_SOCK_1_DATA_MAX_TIME"
        case socket1StatusOnString = "GUI_POW_SOCK_1_POW_ON"
        case socket1TimeRemainingString = "GUI_POW_SOCK_1_TIME_REM"
    }
}
