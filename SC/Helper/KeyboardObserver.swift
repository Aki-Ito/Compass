//
//  KeyboardObserver.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/10.
//

import Foundation
import SwiftUI
import Combine

class KeyboardObserver: ObservableObject {
    
    @Published var keyboardHeight: CGFloat = 0.0
    
    // キーボードの監視開始
    func addObserver() {
        NotificationCenter
            .default
            .addObserver(
                self,
                selector: #selector(self.keyboardWillChangeFrame),
                name: UIResponder.keyboardWillChangeFrameNotification,
                object: nil)
    }
    
    // キーボードの監視終了
    func removeObserver() {
        NotificationCenter
            .default
            .removeObserver(self,
                            name: UIResponder.keyboardWillChangeFrameNotification,
                            object: nil)
    }
    
    // キーボードのフレーム検知処理
    @objc
    func keyboardWillChangeFrame(_ notification: Notification) {
        if let endFrame = notification
            .userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
           let beginFrame = notification
            .userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue {
            let endFrameMinY: CGFloat = endFrame.cgRectValue.minY
            let beginFrameMinY: CGFloat = beginFrame.cgRectValue.minY
            
            self.keyboardHeight = beginFrameMinY - endFrameMinY
            if self.keyboardHeight < 0 {
                self.keyboardHeight = 0
            }
        }
    }
}

