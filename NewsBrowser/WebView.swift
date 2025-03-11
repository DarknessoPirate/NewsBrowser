//
//  WebView.swift
//  NewsBrowser
//
//  Created by RMS on 11/03/2025.
//


import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let requestUrl = URL(string: url) {
            let request = URLRequest(url: requestUrl)
            uiView.load(request)
        }
    }
}
