//
//  ActivityIndicatorHelper.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/17.
//

import Foundation
import SwiftUI
struct ActivityIndicatorHelper: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicatorHelper>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: .large)
    }
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicatorHelper>) {
        uiView.startAnimating()
    }
}
