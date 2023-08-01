//
//  HomeView.swift
//  eCommerce
//
//  Created by mac on 31/07/2023.
//

import SwiftUI

struct HomeView: View {
    
    @Namespace var animation
    @State var currentSlider: Int = 0
    @State var sliders: [Slider] = []
    @EnvironmentObject var baseViewModel: BaseViewModel
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack {
                    Button {
                        
                    } label: {
                        Image("menu")
                            .resizable()
                            .renderingMode(.template)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                    }
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "magnifyingglass").font(.title2)
                    }
                }
                .foregroundColor(.black)
                .overlay(
                    Text("E-Commerce").frame(width: 128, height: 64)
                )
                
                // SLIDER
                VStack(spacing: 15) {
                    VStack(alignment: .leading, spacing: 12) {
                        HomeSlider(trailingSpace: 40, index: $currentSlider, items: sliders) { slider in
                            GeometryReader { proxy in
                                let sliderSize = proxy.size
                                Image(slider.sliderImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: sliderSize.width, height: 160)
                                    .cornerRadius(12)
                            }
                        }
                        .padding(.vertical, 10)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .onAppear {
                        for index in 1...4 {
                            sliders.append(Slider(sliderImage: "slider\(index)"))
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // SLIDER INDICATOR
                HStack(spacing: 10) {
                    ForEach(sliders.indices, id: \.self) { index in
                        Circle()
                            .fill(Color.black.opacity(currentSlider == index ? 1 : 0.1))
                            .frame(width: 7, height: 8)
                            .scaleEffect(currentSlider == index ? 1.4 : 1)
                            .animation(.spring(), value: currentSlider == index)
                    }
                }
                .padding(.top, 120)
                
                // BODY TOP
                HStack {
                    Text("Our Products")
                        .font(.title.bold())
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        HStack(spacing: 3) {
                            Text("Sort by").font(.caption.bold())
                            Image(systemName: "chevron.down").font(.caption.bold())
                        }
                        .foregroundColor(.gray)
                    }
                }
                .padding(.top, 10)
                
                // CATEGORY LIST SLIDER
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 18) {
                        CategoryItem(image: "cat1", title: "Alphabounce")
                        CategoryItem(image: "cat2", title: "Ultraboost")
                        CategoryItem(image: "cat3", title: "Alphaboost")
                        CategoryItem(image: "cat4", title: "Superstar")
                    }
                    .padding(.vertical)
                }
                let columns = Array(repeating: GridItem(.flexible(), spacing: 15), count: 2)
                
                // GRIDVIEW
                LazyVGrid(columns: columns, spacing: 18) {
                    ForEach(products) { product in
                        if #available(iOS 15.0, *) {
                            CardView(product: product)
                                .onTapGesture {
                                    withAnimation {
                                        baseViewModel.currentProduct = product
                                        baseViewModel.showDetail = true
                                    }
                                }
                        }
                    }
                }
            }
            .padding()
            .padding(.bottom, 100)
        }
    }
    
    @available(iOS 15.0, *)
    @ViewBuilder
    func CardView(product: Product) -> some View {
        VStack(spacing: 15) {
            Button {
                
            } label: {
                if #available(iOS 15.0, *) {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 13))
                        .foregroundColor(product.isLiked ? .white : .gray)
                        .padding(5)
                        .background(Color.red.opacity(product.isLiked ? 1: 0), in: Circle()
                    )
                } else {
                    Image(systemName: "suit.heart.fill")
                        .font(.system(size: 13))
                        .foregroundColor(product.isLiked ? .white : .gray)
                        .padding(5)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            
            Image(product.thumbnail)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .matchedGeometryEffect(id: product.thumbnail, in: animation)
                .padding()
                .rotationEffect(.init(degrees: -20))
                .background(
                    ZStack {
                        Circle()
                            .fill(product.productColor)
                            .padding(-10)
                        Circle()
                            .stroke(Color.white, lineWidth: 1.4)
                            .padding(-3)
                    }
                )
            
            Text(product.title)
                .fontWeight(.semibold)
                .padding(.top)
                .multilineTextAlignment(.center)
            
            Text(product.price)
                .font(.title2.bold())
            
            // RATING
            HStack(spacing: 4) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: "star.fill")
                        .font(.system(size: 9.5))
                        .foregroundColor(product.rating >= index ? .yellow : Color.gray.opacity(0.6))
                }
                
                Text("(\(product.rating).0")
                    .font(.caption.bold())
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white, in: RoundedRectangle(cornerRadius: 1))
    }
    
    @ViewBuilder
    func CategoryItem(image: String, title: String) -> some View {
        Button {
            withAnimation {baseViewModel.homeTab = title}
        } label: {
            HStack(spacing: 8) {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 27, height: 27)
                    .foregroundColor(.clear)
                Text(title)
                    .font(.system(size: 12.5))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
            }
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(
                ZStack {
                    if baseViewModel.homeTab == title {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.white)
                            .matchedGeometryEffect(id: "TAB", in: animation)
                            .shadow(color: Color.black.opacity(0.04), radius: 5, x: 5, y:5)
                    }
                }
            )
        }
    }
}
