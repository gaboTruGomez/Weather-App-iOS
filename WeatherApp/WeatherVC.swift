//
//  ViewController.swift
//  WeatherApp
//
//  Created by Gabriel Trujillo Gómez on 6/28/17.
//  Copyright © 2017 Gabriel Trujillo Gómez. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        locationAuthStatus()
    
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        tableView.delegate   = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()
    }
    
    func locationAuthStatus()
    {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        {
            currentLocation = locationManager.location
            while currentLocation == nil
            {
                currentLocation = locationManager.location
            }
            Location.sharedInstance.latitude  = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather.downloadWeatherDetails {
                self.downloadForeastData {
                    self.updateMainUI()
                }
            }
        }
        else
        {
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell
        {
            let forecast = forecasts[indexPath.row]
            cell.cofigureCell(forecast: forecast)
            
            return cell
        }
    
        return WeatherCell()
    }
    
    func updateMainUI()
    {
        dateLabel.text               = currentWeather.date
        tempLabel.text               = currentWeather.currentTemp
        placeLabel.text              = currentWeather.cityName
        currentWeatherTypeLabel.text = currentWeather.weatherType
        currentWeatherImg.image      = UIImage(named: currentWeather.weatherType)
    }
    
    func downloadForeastData(completed: @escaping DownloadComplete)
    {
        let forecastURL = URL(string: FORECAST_URL_HARDOCDED)!
        Alamofire.request(forecastURL).responseJSON { response in
            if let dict = response.result.value as? Dictionary<String, Any>
            {
                if let list = dict["list"] as? [Dictionary<String, Any>]
                {
                    for obj in list
                    {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
}

