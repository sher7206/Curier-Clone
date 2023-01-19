//
//  NetworkMonitor.swift
//  Paywork
//
//  Created by Asliddin Rasulov on 28/06/22.
//

import UIKit
import Network

class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.main
    let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    public private(set) var connectionType: ConnectionType = .unknown
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init() {
        self.monitor = NWPathMonitor()
    }
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .unsatisfied
            self.getConnectionType(path)
            
            let storyboard = UIStoryboard(name: "NetworkMonitorView", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "networkmonitor") as! NetworkMonitorView
            vc.providesPresentationContextTransitionStyle = true
            vc.definesPresentationContext = true
            vc.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
            vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            
            if self.isConnected {
                UIApplication.getTopViewController()?.present(vc, animated: true, completion: nil)
            } else {
                UIApplication.getTopViewController()?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
        } else
        if path.usesInterfaceType(.cellular) {
            connectionType = .cellular
        } else
        if path.usesInterfaceType(.wiredEthernet) {
            connectionType = .ethernet
        } else {
            connectionType = .unknown
        }
    }
    
}
