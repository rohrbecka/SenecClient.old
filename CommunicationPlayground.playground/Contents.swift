import Foundation
import SenecClient

private let hostName = "http://192.168.178.79"
private let scriptURL = URL(string: hostName + "/lala.cgi")


private let session = URLSession.shared


// Retrieve energy flow
private let task = session.dataTask(with: SenecEnergyFlow.request(url: scriptURL!)) {data, _, _ in
    if let data = data {
        if let result = try? JSONDecoder().decode(SenecEnergyFlow.self, from: data) {
            print (result)
        }
    }
}
task.resume()



// Retrieve energy statistic
private let statisticTask = session.dataTask(with: SenecEnergyStatistic.request(url: scriptURL!)) {data, _, _ in
    if let data = data {
        if let result = try? JSONDecoder().decode(SenecEnergyStatistic.self, from: data) {
            print (result)
        }
    }
}
statisticTask.resume()



// Retrieve Sockets
private let socketstask = session.dataTask(with: SenecSockets.request(url: scriptURL!)) {data, _, _ in
    if let data = data {
        if let result = try? JSONDecoder().decode(SenecSockets.self, from: data) {
            print (result)
        }
    }
}
socketstask.resume()



let host = LocalSenec
