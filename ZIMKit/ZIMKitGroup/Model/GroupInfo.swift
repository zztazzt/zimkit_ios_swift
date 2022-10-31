//
//  GroupInfo.swift
//  ZIMKit
//
//  Created by Kael Ding on 2022/8/31.
//

import Foundation
import ZIM

struct GroupInfo {
    let id: String
    var name: String
    var avatarUrl: String
    var notice: String
    var attributes: [String: String]

    init(with info: ZIMGroupFullInfo) {
        id = info.baseInfo.groupID
        name = info.baseInfo.groupName
        avatarUrl = info.baseInfo.groupAvatarUrl
        notice = info.groupNotice
        attributes = info.groupAttributes
    }
}
