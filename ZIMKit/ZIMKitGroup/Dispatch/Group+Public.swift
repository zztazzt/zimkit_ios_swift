//
//  Conversation+Dispatcher.swift
//  Pods-ZIMKitDemo
//
//  Created by Kael Ding on 2022/7/29.
//

import Foundation
import ZIM

extension GroupDispatcher: DispatchViewControllerProtocol {
    public func viewController() -> UIViewController? {
        switch self {
        case .groupCreate(let type):
            return GroupCreateVC(type)
        case let .groupDetail(groupID, groupName):
            return GroupDetailVC(groupID, groupName)
        }
    }
}

extension GroupActionDispatcher: DispatchActionProtocol {
    public func callAction() -> AnyObject? {
        return nil
    }
}



