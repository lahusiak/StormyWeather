//
//  ViewController.swift
//  StormyWeather
//
//  Created by Laryssa Husiak on 2/2/16.
//  Copyright © 2016 Laryssa Husiak. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    
    @IBOutlet weak var currentHumidityLabel: UILabel?
    
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    
    
    @IBOutlet weak var currentWeatherIcon: UIImageView?

    @IBOutlet weak var currentWeatherSummary: UILabel?
    
    @IBOutlet weak var refreshButton: UIButton!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    

    
    let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        retrieveWeatherForecast()
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func retrieveWeatherForecast() {
        let forecastAPIKey = valueForAPIKey("ForecastAPIKey")
        let forecastService = ForecastService(APIKey: forecastAPIKey)
        forecastService.getForecast(coordinate.lat, long: coordinate.long){
    
            (let currently) in
            if let currentWeather = currently {
                dispatch_async(dispatch_get_main_queue()){
    
                    if let temperature = currentWeather.temperature{
                        self.currentTemperatureLabel?.text = "\(temperature)º"
                    }
                    if let humidity = currentWeather.humidity{
                        self.currentHumidityLabel?.text = "\(humidity)%"
                    }
                    if let prepProbability = currentWeather.precipProbability{
                        self.currentPrecipitationLabel?.text = "\(prepProbability)%"
                    }
                    if let icon = currentWeather.icon{
                        self.currentWeatherIcon?.image = icon
                    }
                    if let summary = currentWeather.summary{
                        self.currentWeatherSummary?.text = summary
                    }
                    self.toggleRefreshAnimation(false)
                }
            }
        }

    }


    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
        
    }


    func toggleRefreshAnimation(on: Bool){
        refreshButton?.hidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    
    }


}

