//
//  ReachabilityManager.swift
//  Avatar world city life mod
//
//  Created by Alex N
//

import Foundation
import Reachability

class ReachabilityManager_AW {
    static let shared = ReachabilityManager_AW()

    var reachability: Reachability?
    var isReachabilityPaused = false
    var ifNeedShowMsg = true
    var completion: () -> Void = {}
    var isActiveInternet: () -> Void = {}

    private init() {
        do {
            reachability = try Reachability()
            try reachability?.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }

    func setupReachabilityObserver_AW() {
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged_AW(note:)), name: .reachabilityChanged, object: reachability)
    }

    @objc func reachabilityChanged_AW(note: Notification) {
        guard let reachability = note.object as? Reachability else { return }

        if !isReachabilityPaused {
            if reachability.connection == .unavailable && reachability.connection != .wifi && reachability.connection != .cellular {
                completion()
                
                guard ifNeedShowMsg else { return }
                ifNeedShowMsg = false
//                AlertManager_AW.showInfoAlert_AW(with: "Warning:", msg: "No internet connection.", doneActionHandler: {
//                    self.ifNeedShowMsg = true
//                })
                
                print("No internet connection.")
            } else {
                isActiveInternet()
            }
        }
    }

    func pauseReachability_AW() {
        isReachabilityPaused = true
        reachability?.stopNotifier()
    }

    func resumeReachability_AW() {
        isReachabilityPaused = false
        do {
            try reachability?.startNotifier()
        } catch {
            print("Could not start reachability notifier")
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: nil)
        reachability?.stopNotifier()
    }
}
