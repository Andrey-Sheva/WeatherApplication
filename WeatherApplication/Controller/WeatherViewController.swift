//
//  ViewController.swift
//  WeatherApplication
//
//  Created by Андрей Шевчук on 29.05.2020.
//  Copyright © 2020 Андрей Шевчук. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {
    
    @IBOutlet weak var locationButton: UIButton!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    @IBAction func locationDetection(_ sender: Any) {
        locationManger.requestLocation()
    }
    
    
    let locationManger = CLLocationManager()
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        weatherManager.delegate = self
        searchTextField.delegate = self
        locationManger.delegate = self

        locationManger.requestWhenInUseAuthorization()
        locationManger.requestLocation()
    }

}




extension WeatherViewController: UITextFieldDelegate{
        
               @IBAction func searchButton(_ sender: Any) {
                   searchTextField.endEditing(true)
                   print(searchTextField.text!)
               }
               func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                   searchTextField.endEditing(true)
                   return true
               }
               func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
                   if searchTextField.text != "" {
                       return true
                   }else {
                       searchTextField.placeholder = "type something"
                       return false
                   }
           }
               
               func textFieldDidEndEditing(_ textField: UITextField) {
                   if let city = searchTextField.text{
                       weatherManager.fetchWeather(cityName: city)
                   }
                   searchTextField.text = ""
               }
       }

extension WeatherViewController: WeatherManagerDelegate{
     
        func didUpdateWeather(_ weatherManger: WeatherManager, weather: WeatherModel){
            DispatchQueue.main.async {
                self.temperatureLabel.text = String(weather.cityTemperature - 273.15)
                self.conditionImageView.image = UIImage(systemName: weather.conditionName)
                self.cityLabel.text = weather.cityName
                
            }
        }
        func didFailError(error: Error){
            print(error)
        }
        
    }

extension WeatherViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last{
            locationManger.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
