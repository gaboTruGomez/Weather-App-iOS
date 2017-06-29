//
//  Constants.swift
//  WeatherApp
//
//  Created by Gabriel Trujillo Gómez on 6/29/17.
//  Copyright © 2017 Gabriel Trujillo Gómez. All rights reserved.
//

import Foundation

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "67655fdcb6a6cb5e2e42305c8bd03d90"

typealias DownloadComplete = () -> ()

let CURRENT_WEATHER_URL_HARDCODED = "\(BASE_URL)\(LATITUDE)\(Location.sharedInstance.latitude!)\(LONGITUDE)\(Location.sharedInstance.longitude!)\(APP_ID)\(APP_KEY)"
let FORECAST_URL_HARDOCDED = "http://api.openweathermap.org/data/2.5/forecast/daily?lat=-32&lon=139&cnt=10&appid=\(APP_KEY)"

