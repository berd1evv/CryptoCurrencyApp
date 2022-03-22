//
//  ViewControllerCell.swift
//  CryptocurrencyApp
//
//  Created by Eldiiar on 21/3/22.
//

import UIKit
import SnapKit
import Charts

class CryptoViewControllerCell: UITableViewCell {
        
    private let cryptoImage : UIImageView = {
        let imgView = UIImageView(image: UIImage(named: "bch"))
        imgView.contentMode = .scaleAspectFit
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    private let cryptoLabel : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoSymbol : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.font = .systemFont(ofSize: 20)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoPrice : UILabel = {
        let lbl = UILabel()
        lbl.textColor = UIColor(named: "ColorBlack")
        lbl.font = .boldSystemFont(ofSize: 18)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let cryptoChange : UILabel = {
        let lbl = UILabel()
        lbl.textColor = .green
        lbl.font = .boldSystemFont(ofSize: 17)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let chartView: LineChartView = {
        let cView = LineChartView()
        cView.xAxis.enabled = false
        cView.leftAxis.enabled = false
        cView.rightAxis.enabled = false
        cView.chartDescription?.enabled = false
        cView.legend.enabled = false
        cView.animate(xAxisDuration: 2.5)
        cView.translatesAutoresizingMaskIntoConstraints = false
        return cView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(cryptoImage)
        addSubview(cryptoLabel)
        addSubview(cryptoSymbol)
        addSubview(cryptoPrice)
        addSubview(cryptoChange)
        addSubview(chartView)
        
        setUpConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getData(imageURL: String, label: String, symbol: String, price: Double, change: Double, array: [Double]) {
        guard let url = URL(string: imageURL) else { return }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.cryptoImage.image = image
                    }
                }
            }
        }
        if change.isLess(than: 0) {
            cryptoChange.textColor = .red
            cryptoChange.text = "\(String(format: "%.2f", change))%"
        } else {
            cryptoChange.text = "+\(String(format: "%.2f", change))%"
        }
        cryptoLabel.text = label
        cryptoSymbol.text = symbol
        cryptoPrice.text = "$\(String(price))"
        
        updateGraph(arr: array)
    }
    
    func updateGraph(arr: [Double]) {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<arr.count {
            let value = ChartDataEntry(x: Double(i), y: arr[i])
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(entries: lineChartEntry, label: "")
        line1.mode = .cubicBezier
        if  cryptoChange.textColor == .red{
            line1.colors = [NSUIColor(red: 1, green: 0, blue: 0, alpha: 1)]
        } else {
            line1.colors = [NSUIColor(red: 0, green: 1, blue: 0, alpha: 1)]
        }
        
        line1.drawCircleHoleEnabled = false
        line1.drawCirclesEnabled = false
        line1.drawIconsEnabled = true
        line1.drawHorizontalHighlightIndicatorEnabled = false
        line1.drawVerticalHighlightIndicatorEnabled = false
        line1.drawValuesEnabled = true
        
        let data = LineChartData()
        data.setDrawValues(false)
        data.addDataSet(line1)
        chartView.data = data
    }
    
    func setUpConstraints() {
        cryptoImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        cryptoLabel.snp.makeConstraints { make in
            make.left.equalTo(cryptoImage.snp.right).offset(10)
            make.top.equalToSuperview().offset(15)
            make.width.equalTo(140)
        }
        
        cryptoSymbol.snp.makeConstraints { make in
            make.top.equalTo(cryptoLabel.snp.bottom).offset(2)
            make.left.equalTo(cryptoImage.snp.right).offset(10)
            make.width.equalTo(60)
        }
        
        cryptoPrice.snp.makeConstraints { make in
            make.right.equalTo(chartView.snp.left).offset(-10)
            make.top.equalToSuperview().offset(17)
            make.width.equalTo(100)
        }
        
        cryptoChange.snp.makeConstraints { make in
            make.right.equalTo(chartView.snp.left).offset(-10)
            make.top.equalTo(cryptoPrice.snp.bottom).offset(5)
            make.width.equalTo(80)
        }
        
        chartView.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalToSuperview()
        }
    }

}
