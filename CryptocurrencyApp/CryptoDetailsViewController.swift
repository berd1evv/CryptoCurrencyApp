//
//  CryptoDetailsViewController.swift
//  CryptocurrencyApp
//
//  Created by Eldiiar on 21/3/22.
//

import UIKit
import Charts

class CryptoDetailsViewController: UIViewController {
    
    var id = 0
    var arr: [Double] = []
    
    private let cryptoName : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 26)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoMarketCap : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoMarketCapDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "Market Cap"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoMarketCapRank : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoMarketCapRankDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "Rank"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoPrice : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoPriceDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "Price"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoVolume : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoVolumeDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "24h Volume"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoChange : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoChangeDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "24h Change"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoChangePercentage : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .green
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoChangePercentageDescription : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 12)
        lbl.textAlignment = .left
        lbl.text = "Change Percentage"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let chartView: LineChartView = {
        let cView = LineChartView()
        cView.xAxis.enabled = false
        cView.rightAxis.enabled = false
        cView.legend.enabled = false
        cView.animate(xAxisDuration: 2.5)
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor(named: "ColorWhite")
        
        view.addSubview(chartView)
        view.addSubview(cryptoName)
        view.addSubview(cryptoMarketCap)
        view.addSubview(cryptoMarketCapRank)
        view.addSubview(cryptoPrice)
        view.addSubview(cryptoVolume)
        view.addSubview(cryptoChange)
        view.addSubview(cryptoChangePercentage)
        
        view.addSubview(cryptoMarketCapRankDescription)
        view.addSubview(cryptoMarketCapDescription)
        view.addSubview(cryptoPriceDescription)
        view.addSubview(cryptoVolumeDescription)
        view.addSubview(cryptoChangeDescription)
        view.addSubview(cryptoChangePercentageDescription)
        
        setUpConstraints()
        
        parse()
    }
    
    func parse() {
        Networking.shared.cryptoDetailsNetworking(cryptoId: id) { data in
            DispatchQueue.main.async {
                self.arr = data.sparkline_in_7d.price
                self.cryptoName.text = data.name
                self.cryptoMarketCap.text = "$\(String(format: "%.0f", data.market_cap))"
                self.cryptoMarketCapRank.text = "#\(String(format: "%.0f", data.market_cap_rank))"
                self.cryptoPrice.text = "$\(String(data.current_price))"
                self.cryptoVolume.text = "$\(String(format: "%.0f", data.total_volume))"
                self.cryptoChange.text = "$\(String(format: "%.4f", data.price_change_24h))"
                if data.price_change_percentage_24h.isLess(than: 0) {
                    self.cryptoChangePercentage.textColor = .red
                    self.cryptoChangePercentage.text = "\(String(data.price_change_percentage_24h))%"
                } else {
                    self.cryptoChangePercentage.text = "+\(String(format: "%.2f", data.price_change_percentage_24h))%"
                }
                
                self.updateGraph()
            }
        }
    }
    
    func updateGraph() {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<arr.count {
            let value = ChartDataEntry(x: Double(i), y: arr[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry)
        line1.colors = [NSUIColor(red: 0.4, green: 0.6, blue: 1, alpha: 1)]
        line1.drawCircleHoleEnabled = false
        line1.drawCirclesEnabled = false
        line1.drawIconsEnabled = true
        line1.lineWidth = 2
        line1.drawFilledEnabled = true
        
        let data = LineChartData()
        data.addDataSet(line1)
        chartView.data = data
    }
    
    func setUpConstraints() {
        cryptoName.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(cryptoName.snp.bottom).offset(5)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(240)
        }
        
        cryptoMarketCapRank.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(40)
            make.left.equalTo(60)
        }
        
        cryptoMarketCap.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(40)
            make.right.equalTo(-60)
        }
        
        cryptoPrice.snp.makeConstraints { make in
            make.top.equalTo(cryptoMarketCapRank.snp.bottom).offset(40)
            make.left.equalTo(60)
        }
        
        cryptoVolume.snp.makeConstraints { make in
            make.top.equalTo(cryptoMarketCap.snp.bottom).offset(40)
            make.left.equalTo(cryptoMarketCap)
        }
        
        cryptoChange.snp.makeConstraints { make in
            make.top.equalTo(cryptoPrice.snp.bottom).offset(40)
            make.left.equalTo(60)
        }
        
        cryptoChangePercentage.snp.makeConstraints { make in
            make.top.equalTo(cryptoVolume.snp.bottom).offset(40)
            make.left.equalTo(cryptoVolume)
        }
        
        //Descriptions
        
        cryptoMarketCapRankDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoMarketCapRank.snp.top)
            make.left.equalTo(cryptoMarketCapRank.snp.left)
        }
        
        cryptoMarketCapDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoMarketCap.snp.top)
            make.left.equalTo(cryptoMarketCap.snp.left)
        }
        
        cryptoPriceDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoPrice.snp.top)
            make.left.equalTo(cryptoPrice)
        }
        
        cryptoVolumeDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoVolume.snp.top)
            make.left.equalTo(cryptoVolume)
        }
        
        cryptoChangeDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoChange.snp.top)
            make.left.equalTo(cryptoChange)
        }
        
        cryptoChangePercentageDescription.snp.makeConstraints { make in
            make.bottom.equalTo(cryptoChangePercentage.snp.top)
            make.left.equalTo(cryptoChangePercentage)
        }
    }
    
    
}
