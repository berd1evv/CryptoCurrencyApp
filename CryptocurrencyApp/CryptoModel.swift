//
//  ViewControllerModel.swift
//  CryptocurrencyApp
//
//  Created by Eldiiar on 21/3/22.
//

import Foundation

class CryptoModel: Codable {
    var name: String
    var symbol: String
    var image: String
    var current_price: Double
    var market_cap_rank: Double
    var market_cap: Double
    var price_change_24h: Double
    var price_change_percentage_24h: Double
    var total_volume: Double
    var sparkline_in_7d: Price
}

class Price: Codable {
    var price: [Double]
}
