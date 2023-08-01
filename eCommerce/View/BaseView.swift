//
//  BaseView.swift
//  eCommerce
//
//  Created by mac on 31/07/2023.
//

import SwiftUI

struct BaseView: View {
    @StateObject var baseViewModel = BaseViewModel()
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $baseViewModel.currentTab) {
            HomeView()
                .environmentObject(baseViewModel)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.black.opacity(0.04))
                .tag(Tab.Home)
            Text("Heart").tag(Tab.Heart)
            Text("Clipboard").tag(Tab.Clipboard)
            Text("Person").tag(Tab.Person)
        }
        .overlay(
            HStack(spacing: 0) {
                TabButton(Tab: .Home)
                TabButton(Tab: .Heart)
                    .offset(x: -10)
                
                Button {
                    
                } label: {
                    Image("cart")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 26, height: 26)
                        .offset(x: -1)
                        .padding(18)
                        .foregroundColor(Color.white)
                        .background(Color.red)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y: 5)
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                }
                .offset(y: -30)
                
                TabButton(Tab: .Clipboard)
                    .offset(x: 10)
                TabButton(Tab: .Person)
            }
                .background(
                    Color.white
                        .clipped()
                        .shadow(color: Color.black.opacity(0.04), radius: 5, x: -5, y: -5)
                        .ignoresSafeArea(.container, edges: .bottom)
                )
                .offset(y: baseViewModel.showDetail ? 200: 0), alignment: .bottom
        )
    }
    
    @ViewBuilder
    func TabButton(Tab: Tab) -> some View {
        Button {
            withAnimation {
                baseViewModel.currentTab = Tab
            }
        } label: {
            Image(Tab.rawValue)
                .resizable()
                .renderingMode(.template)
                .aspectRatio(contentMode: .fit)
                .frame(width: 25, height: 25)
                .foregroundColor(baseViewModel.currentTab == Tab ? Color.red : Color.gray.opacity(0.5))
                .frame(maxWidth: .infinity)
        }
    }
}

//struct BaseView_Previews: PreviewProvider {
//    static var previews: some View {
//        BaseView()
//    }
//}
