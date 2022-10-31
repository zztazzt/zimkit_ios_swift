//
//  DispatchCenter.swift
//  ZIMKitCommon
//
//  Created by Kael Ding on 2022/7/29.
//

import UIKit
import ZIM

public protocol DispatchProtocol { }


public protocol DispatchViewControllerProtocol {
    func viewController() -> UIViewController?
}

public protocol DispatchActionProtocol {
    func callAction() -> AnyObject?
}
