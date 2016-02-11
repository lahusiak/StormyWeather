
//
//  CurrentWeather.swift
//  StormyWeather
//
//  Created by Laryssa Husiak on 2/5/16.
//  Copyright © 2016 Laryssa Husiak. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case ClearDay = "clear-day"
    case ClearNight = "clear-night"
    case Rain = "rain"
    case Snow = "snow"
    case Sleet = "sleet"
    case Wind = "wind"
    case Fog = "fog"
    case Cloudy = "cloudy"
    case PartlyCloudyDay = "partly-cloudy-day"
    case PartlyCloudyNight = "partly-cloudy-night"
    
    func toImage() -> UIImage? {
        var imageName: String
        
        switch self {
        case .ClearDay:
            imageName = "clear-day.png"
        case .ClearNight:
            imageName = "clear-night.png"
        case .Rain:
            imageName = "rain.png"
        case .Snow:
            imageName = "snow.png"
        case .Sleet:
            imageName = "sleet.png"
        case .Wind:
            imageName = "wind.png"
        case .Fog:
            imageName = "fog.png"
        case .Cloudy:
            imageName = "cloudy.png"
        case .PartlyCloudyDay:
            imageName = "cloudy-day.png"
        case .PartlyCloudyNight:
            imageName = "cloudy-night.png"
        }

        return UIImage(named: imageName)
    }
}




struct CurrentWeather{

    let temperature: Int?
    let humidity: Int?
    let precipProbability: Int?
    var icon: UIImage? = UIImage(named: "default.png")
    
    let summary: String?
    
    init(weatherDictionary: [String: AnyObject]){
        
        //as! is not safe for pulling data from web
        //will change and refactor this in future
        
        
        temperature = weatherDictionary["temperature"] as? Int
        if let humidityFloat = weatherDictionary["humidity"] as? Double{
        humidity = Int(humidityFloat * 100)
        }else{
            humidity = nil
        }
        if let precipProbabilityFloat = weatherDictionary["precipProbability"] as? Double{
        precipProbability = Int(precipProbabilityFloat * 100)
        }else{
            precipProbability = nil
        }
    
        summary = weatherDictionary["summary"] as? String
        
        
        if let iconString = weatherDictionary["icon"] as? String,
        let weatherIcon: Icon = Icon(rawValue: iconString){
            icon = weatherIcon.toImage()
        
            
        }
    
    }
    
    
}