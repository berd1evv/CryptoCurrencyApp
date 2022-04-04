//
//  Networking.swift
//  CryptocurrencyApp
//
//  Created by Eldiiar on 21/3/22.
//

import Foundation

class Networking {
    
    static let shared = Networking()
    
    func cryptoNetworking(completion: @escaping ([CryptoModel]) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=24h") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil { return }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([CryptoModel].self, from: data)
                    completion(decodedData)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func cryptoDetailsNetworking(cryptoId: Int, completion: @escaping (CryptoModel) -> ()) {
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=true&price_change_percentage=24h") else { return }
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if error != nil { return }

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode([CryptoModel].self, from: data)
                    completion(decodedData[cryptoId])
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

}
