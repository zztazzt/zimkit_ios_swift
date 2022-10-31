//
//  Conversation+Dispatcher.swift
//  Pods-ZIMKitDemo
//
//  Created by Kael Ding on 2022/7/29.
//

import Foundation
import ZIM

extension MessagesDispatcher: DispatchViewControllerProtocol {
    public func viewController() -> UIViewController? {
        switch self {
        case let .messagesList(id, type, name):
            return MessagesListVC(with: id, type: type, conversationName: name)
        }
    }
}

extension MessagesActionDispatcher: DispatchActionProtocol {
    public func callAction() -> AnyObject? {
        return nil
    }
}

