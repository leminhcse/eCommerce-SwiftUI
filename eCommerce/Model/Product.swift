//
//  Product.swift
//  eCommerce
//
//  Created by mac on 31/07/2023.
//

import SwiftUI

struct Product: Identifiable {
    var id = UUID().uuidString
    var thumbnail: String
    var title: String
    var price: String
    var description: String
    var productColor: Color
    var isLiked: Bool = false
    var rating: Int
}

var products = [
Product(thumbnail: "adidas1", title: "Adidas Stan Smith", price: "$119.99", description: "Attenir Skin Clear Cleanse Oil cleanses makeup, skin stains and impurities on the skin while leaving it supple and firm.", productColor: Color("pcolor3"), rating: 4),
Product(thumbnail: "adidas2", title: "Alphabounce", price: "$75.99", description: "Dress Lift Day Emulsion is Attenir's anti-ageing regenerating lifting emulsion for daily facial care.", productColor: Color("pcolor2"), rating: 3),
Product(thumbnail: "adidas3", title: "Ultraboost", price: "$99.99", description: "Recast vitamin c facial serum is a extremely light weight serum infused with the stable form of vitamin c.", productColor: Color("pcolor3"), rating: 4),
Product(thumbnail: "adidas4", title: "Ultraboost Clear Green", price: "$219.99", description: "Let the luxurious feel and exotic scents of Hawaiian Tropic Sheer Touch take you to the tropics.", productColor: Color("pcolor4"), rating: 5),
]

