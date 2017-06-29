//
//  Forecast.swift
//  WeatherApp
//
//  Created by Gabriel Trujillo Gómez on 6/29/17.
//  Copyright © 2017 Gabriel Trujillo Gómez. All rights reserved.
//

import Foundation

class Forecast
{
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: String!
    private var _lowTemp: String!
    
    var date: String
    {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    var weatherType: String
    {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    var highTemp: String
    {
        if _highTemp == nil {
            _highTemp = ""
        }
        return _highTemp
    }
    var lowTemp: String
    {
        if _lowTemp == nil {
            _lowTemp = ""
        }
        return _lowTemp
    }

    init(weatherDict: Dictionary<String, Any>)
    {
        if let temp = weatherDict["temp"] as? Dictionary<String, Any>
        {
            if let minTemp = temp["min"] as? Double
            {
                let celsiusTemp = minTemp - 273.15
                self._lowTemp = "\(celsiusTemp)º"
            }
            if let maxTemp = temp["max"] as? Double
            {
                let celsiusTemp = maxTemp - 273.15
                self._highTemp = "\(celsiusTemp)º"
            }
        }
        if let weather = weatherDict["weather"] as? [Dictionary<String, Any>]
        {
            if let main = weather[0]["main"] as? String
            {
                    self._weatherType = main
            }
        }
        if let date = weatherDict["dt"] as? Double
        {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dayOfTheWeek()
        }
    }
}

extension Date {
    func dayOfTheWeek() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
