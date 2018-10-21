//
//  SenecCommunication.swift
//  SenecClient
//
//  Created by André Rohrbeck on 21.10.18.
//

import Foundation



extension SenecEnergyFlow: Requestable {
    public static func request(url: URL) -> URLRequest {
        return senecRequest(url: url, content: JSONEnergyFlow())
    }
}



extension SenecEnergyStatistic: Requestable {
    public static func request(url: URL) -> URLRequest {
        return senecRequest(url: url, content: JSONEnergyStatistic())
    }
}



extension SenecSockets: Requestable {
    public static func request(url: URL) -> URLRequest {
        return senecRequest(url: url, content: JSONSocketsInformation())
    }
}



/// Creates a URLRequest usable for requesting information from a Senec system.
///
/// The function fails, if the JSON encoding of `content` fails. This is considered
/// being a programmer error.
///
/// - Parameter url:     The URL from which to request the information
/// - Parameter content: The Senec Value, which serves as request.
private func senecRequest<T: Encodable>(url: URL, content: T) -> URLRequest {
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("application/x-www-form-urlencoded; charset=UTF-8", forHTTPHeaderField: "Content")

    do {
        let data = try JSONEncoder().encode(content)
        request.httpBody = data
        return request
    } catch let error {
        preconditionFailure("JSON encoding problem: " + error.localizedDescription)
    }
    return request
}
