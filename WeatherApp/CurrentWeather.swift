//
//  CurrentWeather.swift
//  WeatherApp
//
//  Created by Gabriel Trujillo Gómez on 6/29/17.
//  Copyright © 2017 Gabriel Trujillo Gómez. All rights reserved.
//

import Foundation
import Alamofire

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemp: String!
    
    var cityName: String {
        if _cityName == nil
        {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        self._date = "Today, \(currentDate)"
        
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil {
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = ""
        }
        return _currentTemp
    }
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete)
    {
        // Alamofire download
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL_HARDCODED)!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, Any>
            {
                if let name = dict["name"] as? String
                {
                    self._cityName = name.capitalized
                }
                if let weatherDict = dict["weather"] as? [Dictionary<String, Any>]
                {
                    if let weather = weatherDict[0]["main"] as? String
                    {
                        self._weatherType = weather.capitalized
                    }
                }
                if let main = dict["main"] as? Dictionary<String, Any>
                {
                    if let currentTemperature = main["temp"] as? Double
                    {
                        let celsiusTemp = currentTemperature - 273.15
                        self._currentTemp = "\(celsiusTemp)°"
                    }
                }
            }
            completed()
        }
    }
}
