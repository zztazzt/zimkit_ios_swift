//
//  KeyCenter.swift
//  ZIMKitDemo
//
//  Created by Kael Ding on 2022/8/2.
//

import Foundation

struct KeyCenter {
    static func appID() -> UInt32 {
        // beta
//        return 103641243
        // official
        return 2031514356
    }
    static func appSign() -> String {
        // beta
//        return "42b1bbb0a283348555987dbf7f2b1fb8bd660f0a6e29d0b805dc1211a4d7df88"

        // official
        return "d0e83faa119daa065ae553fb23c68a3e624a1f879d5fb2d0c24e066d9859d214"
    }
}
