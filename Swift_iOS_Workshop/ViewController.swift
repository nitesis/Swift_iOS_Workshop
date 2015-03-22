//
//  ViewController.swift
//  Swift_iOS_Workshop
//
//  Created by pat on 15.03.2015.
//  Copyright (c) 2015 extrabright. All rights reserved.
//

import UIKit
import CoreLocation

/*
 * Brugg AG: 47.479501, 8.213011
 */

class ViewController: UIViewController, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    
    private var weatherRequest: WeatherRequest? = nil
    private var location: CLLocation? = nil
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        checkPermission()
    }
    
    private func checkPermission() {
        NSLog("Checking permission")
        switch(CLLocationManager.authorizationStatus()) {
        case .Denied:
            showDeviceNotAllowed()
        case .Restricted:
            showDeviceNotAllowed()
        case .NotDetermined:
            askForPermission()
        case .AuthorizedWhenInUse:
            startLocationRequest()
        default:
            NSLog("other status, do nothing")
        }
    }
    
    private func showDeviceNotAllowed() {
        UIAlertView(title: "Oops", message: "Die Standortbestimmung ist für die App nicht freigegeben", delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    private func askForPermission() {
        NSLog("Requesting permission")
        locationManager.requestWhenInUseAuthorization()
    }
    
    private func startLocationRequest() {
        NSLog("Start location request")
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    
    // MARK: - methods from CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        if locations.count == 0 || self.location != nil {
            return
        }

        if let location = locations[0] as? CLLocation {
            NSLog("Received location %@", location)
            
            self.location = location
            locationManager.stopUpdatingLocation()
            
            performServerRequest()
        }
    }
    
    private func performServerRequest() {
        if let location = self.location {
            let longitude = location.coordinate.longitude
            let latitude = location.coordinate.latitude
            self.weatherRequest = WeatherRequest(latitude: latitude, longitude: longitude)
            weatherRequest?.successBlock = { weatherData in
                NSLog("Received a weather data: %@", weatherData)
                
                self.cityLabel.text = weatherData.city
                self.weatherLabel.text = weatherData.weather
                self.tempLabel.text = self.tempStringForDouble(weatherData.temp)
                self.minTempLabel.text = self.tempStringForDouble(weatherData.minTemp)
                self.maxTempLabel.text = self.tempStringForDouble(weatherData.maxTemp)
                self.humidityLabel.text = self.humidityStringForInt(weatherData.humidity)
                
                WeatherHelper.loadIcon(weatherData.icon, imageView: self.iconImageView)
            }
            weatherRequest?.performRequest()
        }
    }
    
    private func tempStringForDouble(temp: Double?) -> String {
        return temp != nil ? String(format: "%.0f\u{00b0}", temp!) : "--\u{00b0}"
    }
    
    private func humidityStringForInt(humidity: Int?) -> String {
        return humidity != nil ? "\(humidity!)%" : "--%"
    }
    
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        NSLog("Did change authorization")
        if status == CLAuthorizationStatus.AuthorizedWhenInUse {
            startLocationRequest()
        }
    }

    @IBAction func reloadPressed(sender: AnyObject) {
        self.location = nil
        startLocationRequest()
    }
}

