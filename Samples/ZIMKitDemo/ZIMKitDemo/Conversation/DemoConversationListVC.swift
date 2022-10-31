//
//  DemoConversationListVC.swift
//  ZIMKitDemo
//
//  Created by Kael Ding on 2022/8/4.
//

import Foundation
import ZIMKit
import ZIM

class DemoConversationListVC: ConversationListVC {

    override func viewDidLoad() {
        super.viewDidLoad()

        ZIMKitManager.shared.delegate = self

        configUI()
        setupNav()
    }

    func configUI() {

        self.navigationItem.title = "ZEGO IM"

        let image = UIImage(named: "tabbar_message")?.withRenderingMode(.alwaysOriginal)
        let item = UITabBarItem(title: LocalizedStr("demo_message"), image: image, selectedImage: image)
        item.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 11),
            .foregroundColor: UIColor.zim_textGray5
        ], for: .normal)
        item.setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 10),
            .foregroundColor: UIColor.zim_textBlack2
        ], for: .normal)
        item.setBadgeTextAttributes([
            .font: UIFont.systemFont(ofSize: 9, weight: .medium),
            .foregroundColor: UIColor.white
        ], for: .normal)
        item.badgeColor = .zim_backgroundRed
        self.tabBarItem = item
    }

    func setupNav() {
        let leftImage = UIImage(named: "conversation_bar_left")?.withRenderingMode(.alwaysOriginal)
        let leftItem = UIBarButtonItem(image: leftImage, style: .plain, target: self, action: #selector(leftItemClick(_:)))

        let rightImage = UIImage(named: "conversation_bar_right")?.withRenderingMode(.alwaysOriginal)
        let rightItem = UIBarButtonItem(image: rightImage, style: .plain, target: self, action: #selector(rightItemClick(_:)))

        self.navigationItem.leftBarButtonItem = leftItem
        self.navigationItem.rightBarButtonItem = rightItem
    }
}

extension DemoConversationListVC {
    // logout
    @objc func leftItemClick(_ item: UIBarButtonItem?) {
        ZIMKitManager.shared.disconnectUser()
        let loginVC = LoginViewController()
        UIApplication.key?.rootViewController = loginVC
    }

    @objc func rightItemClick(_ item: UIBarButtonItem?) {
        self.showStartChattingAlert()
    }
}

extension DemoConversationListVC: ZIMKitManagerDelegate {
    func onTotalUnreadMessageCountChange(_ totalCount: UInt32) {
        if totalCount == 0 {
            tabBarItem.badgeValue = nil
        } else if totalCount <= 99 {
            tabBarItem.badgeValue = String(totalCount)
        } else {
            tabBarItem.badgeValue = "99+"
        }
    }
    
    func onConnectionStateChange(_ state: ZIMConnectionState, _ event: ZIMConnectionEvent) {
        var title = "ZEGO IM"
        if state == .connecting || state == .reconnecting {
            title = "ZEGO IM (\(LocalizedStr("demo_connecting")))"
        } else if state == .disconnected {
            title = "ZEGO IM (\(LocalizedStr("demo_disconnected")))"
        }
        self.navigationItem.title = title
        
        if event == .kickedOut {
            onUserKickedout()
        }
    }
    
    func onUserKickedout() {
        if self.presentedViewController != nil {
            self.dismiss(animated: true)
        }
        let msg = LocalizedStr("demo_user_kick_out")
        let alert = UIAlertController(title: nil, message: msg, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: LocalizedStr("demo_confirm"), style: .default) { _ in
            self.leftItemClick(nil)
        }
        alert.addAction(confirmAction)
        self.present(alert, animated: true)
    }
}
