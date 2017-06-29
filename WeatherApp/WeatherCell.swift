//
//  WeatherCell.swift
//  WeatherApp
//
//  Created by Gabriel Trujillo Gómez on 6/29/17.
//  Copyright © 2017 Gabriel Trujillo Gómez. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var highTempabel: UILabel!
    @IBOutlet weak var lowTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func cofigureCell(forecast: Forecast)
    {
        dayLabel.text = forecast.date
        weatherTypeLabel.text = forecast.weatherType
        highTempabel.text = "\(forecast.highTemp)"
        lowTempLabel.text = "\(forecast.lowTemp)"
        weatherImg.image = UIImage(named: forecast.weatherType)
    }
}
