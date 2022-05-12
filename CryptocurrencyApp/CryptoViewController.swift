//
//  ViewController.swift
//  CryptocurrencyApp
//
//  Created by Eldiiar on 21/3/22.
//

import UIKit

class CryptoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var arr: [CryptoModel] = []
    let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorWhite")
        title = "Crypto Currency"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.frame = view.frame
        tableView.register(CryptoViewControllerCell.self, forCellReuseIdentifier: "cell")
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(didPullRefresh), for: .valueChanged)
                
        parse()
        
        view.addSubview(tableView)
    }
    
    @objc func didPullRefresh() {
        parse()
    }
    
    func parse() {
        Networking.shared.cryptoNetworking { data in
            self.arr.removeAll()
            DispatchQueue.main.async {
                self.arr = data
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CryptoViewControllerCell
        let item = arr[indexPath.row]
        cell.getData(imageURL: item.image, label: item.name, symbol: item.symbol, price: item.current_price, change: item.price_change_percentage_24h, array: item.sparkline_in_7d.price)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let destination = CryptoDetailsViewController()
        destination.id = indexPath[1]
        navigationController?.pushViewController(destination, animated: true)
    }
    

}


