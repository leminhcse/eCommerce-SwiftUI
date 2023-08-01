//
//  BaseViewModel.swift
//  eCommerce
//
//  Created by mac on 31/07/2023.
//

import SwiftUI

class BaseViewModel: ObservableObject {
    @Published var currentTab: Tab = .Home
    @Published var homeTab = "facewash"
    @Published var currentProduct: Product?
    @Published var showDetail = false
}

enum Tab: String {
    case Home = "home"
    case Heart = "heart"
    case Clipboard = "clipboard"
    case Person = "profile"
}
