//
//  BarHelper.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/07/05.
//

import Foundation
import SwiftUI
class BarHelper{
    static let shared = BarHelper()
    
    func dispSize() -> CGFloat{
        var statusBarHeight: CGFloat
        if #available(iOS 13.0, *) {
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.filter {$0.isKeyWindow}.first
            statusBarHeight = window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            statusBarHeight = UIApplication.shared.statusBarFrame.height
        }
        return statusBarHeight
    }
}
