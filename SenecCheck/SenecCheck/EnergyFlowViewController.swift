//
//  ViewController.swift
//  SenecCheck
//
//  Created by André Rohrbeck on 26.12.18.
//  Copyright © 2018 André Rohrbeck. All rights reserved.
//

import UIKit
import SenecUI_iOS
import SenecClient_iOS



internal final class EnergyFlowViewController: UIViewController {

    @IBOutlet internal weak var stackView: UIStackView!
    @IBOutlet internal var energyFlowView: EnergyFlowView!
    @IBOutlet internal var socketTableView: UITableView!

    private let socketTableViewModel: SocketTableViewModel = {
        return SocketTableViewModel()
    }()

    private var host: SenecHost?


    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        energyFlowView.tintColor = UIColor.init(named: "UITint")
        energyFlowView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        host = LocalSenecHost(url: URL(string: "http://192.168.178.79")!)
        socketTableView.dataSource = socketTableViewModel
        socketTableView.estimatedRowHeight = 65.0
        socketTableView.rowHeight = UITableView.automaticDimension
        socketTableView.backgroundColor = .black
    }


    public override func viewWillAppear(_ animated: Bool) {
        energyFlowView.viewModel = nil
        host?.startGettingEnergyFlow(every: 5.0) {[weak self] result in
            switch result {
            case .failure (let error):
                let alert = UIAlertController(title: "Networking Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.energyFlowView.viewModel = nil
            case .success (let value):
                self?.energyFlowView.viewModel = value
            }
        }


        host?.startGettingSocketSettings(every: 10.0) {[weak self] result in
            switch result {
            case .failure (let error):
                let alert = UIAlertController(title: "Networking Error",
                                              message: error.localizedDescription,
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self?.socketTableViewModel.viewModel = nil
            case .success (let value):
                let sockets = value.socketSettings.enumerated().map {
                    SocketTableCellViewModel(socket: $0.element, socketNumber: $0.offset + 1)
                }
                self?.socketTableViewModel.viewModel = sockets
                self?.socketTableView.reloadData()
            }
        }
    }



    public override func viewWillDisappear(_ animated: Bool) {
        host?.stopGettingEnergyFlow()
    }
}


extension SenecEnergyFlow: EnergyFlowViewModel {
    public var maxPower: Double {
        return 7000.0
    }

    public var stateOfCharge: Double {
        return batteryStateOfCharge
    }
}



internal enum SenecSocketMode: SocketMode, Equatable, CaseIterable {
    case off
    case automatic
    case scheduled
    // swiftlint:disable identifier_name
    case on

    public var localizedTitle: String {
        switch self {
        case .off: return "Off"
        case .automatic: return "Auto"
        case .scheduled: return "Time"
        case .on: return "On"
        }
    }
}



internal struct SocketTableCellViewModel: SocketTableCellPresentable {
    public let socketName: String
    public let sortedModes: [SocketMode] = {
        return SenecSocketMode.allCases
    }()
    public let selectedModeIndex: Int

    public let powerOn: Bool
    public let remainingTime: TimeInterval


    public var senecMode: SenecSocketMode {
        guard let senecMode = sortedModes[selectedModeIndex] as? SenecSocketMode else {
            preconditionFailure("Within the SocketTableCellViewModel all modes should be SenecSocektModes.")
        }
        return senecMode
    }

    public var remainingTimeString: String {
        if senecMode == SenecSocketMode.on {
            return ""
        } else {
            return "xx:xx"
        }
    }


    public init (socket: SenecSocketSetting, socketNumber: Int) {
        socketName = "Socket \(socketNumber)"
        switch socket.mode {
        case .off: selectedModeIndex = 0
        case .automatic: selectedModeIndex = 1
        case .time: selectedModeIndex = 2
        case .forced: selectedModeIndex = 3
        }
        powerOn = socket.status.powerOn
        remainingTime = TimeInterval(socket.status.timeRemaining)
    }
}
