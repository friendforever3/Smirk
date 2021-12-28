//
//  LocationManager.swift
//  Requezt-DJ
//
//  Created by Surinder Kumar on 09/08/21.
//

import Foundation
import UIKit
import CoreLocation


class LocationManager : NSObject,CLLocationManagerDelegate{
    
    
    var locationManager:CLLocationManager!
    
    public static var shared = LocationManager()
    
    var currentLat : Double = 0.0
    var currentLong : Double = 0.0
    
    private override init() {
    }
    
    func initialiseLoc(){
            locationManager = CLLocationManager()
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()

            if CLLocationManager.locationServicesEnabled(){
                locationManager.startUpdatingLocation()
            }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation :CLLocation = locations[0] as CLLocation

        print("user latitude = \(userLocation.coordinate.latitude)")
        print("user longitude = \(userLocation.coordinate.longitude)")
        currentLat = userLocation.coordinate.latitude
        currentLong = userLocation.coordinate.longitude
       // self.labelLat.text = "\(userLocation.coordinate.latitude)"
       // self.labelLongi.text = "\(userLocation.coordinate.longitude)"
        /*
        let geocoder1 = CLGeocoder()
        geocoder1.geocodeAddressString("Palolem Beach, Goa, India") { (placemarks, error) in
            print(error?.localizedDescription)
                if error == nil {
                    if let placemark = placemarks?[0] {
                        let placemark = placemarks?.first
                        let lat = placemark?.location?.coordinate.latitude
                        let lon = placemark?.location?.coordinate.longitude
                    }
                }
            }
        
        */
        
        /*
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(userLocation) { (placemarks, error) in
            if (error != nil){
                print("error in reverseGeocode")
            }
            let placemark = placemarks! as [CLPlacemark]
            if placemark.count>0{
                let placemark = placemarks![0]
                print(placemark.locality!)
                print(placemark.administrativeArea!)
                print(placemark.country!)
                print("\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)")
              //  self.labelAdd.text = "\(placemark.locality!), \(placemark.administrativeArea!), \(placemark.country!)"
            }
        }
        */
        locationManager.stopUpdatingLocation()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error \(error)")
    }
    
    func getLoc()->(lat:Double,long:Double){
        return (lat : currentLat, long:currentLong)
    }
    
    func checkUsersLocationServicesAuthorization(){
           /// Check if user has authorized Total Plus to use Location Services
           if CLLocationManager.locationServicesEnabled() {
               switch CLLocationManager.authorizationStatus() {
               case .notDetermined:
                   // Request when-in-use authorization initially
                   // This is the first and the ONLY time you will be able to ask the user for permission
                   self.locationManager.delegate = self
                   locationManager.requestWhenInUseAuthorization()
                   break

               case .restricted, .denied:
                   // Disable location features
                  // switchAutoTaxDetection.isOn = false
                   let alert = UIAlertController(title: "Allow Location Access", message: "App needs access to your location. Turn on Location Services in your device settings.", preferredStyle: UIAlertController.Style.alert)

                   // Button to Open Settings
                   alert.addAction(UIAlertAction(title: "Settings", style: UIAlertAction.Style.default, handler: { action in
                       guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                           return
                       }
                       if UIApplication.shared.canOpenURL(settingsUrl) {
                           UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                               print("Settings opened: \(success)")
                           })
                       }
                   }))
                  // alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
                UIApplication.getTopViewController()?.present(alert, animated: true, completion: nil)

                   break

               case .authorizedWhenInUse, .authorizedAlways:
                   // Enable features that require location services here.
                   print("Full Access")
                   break
               @unknown default:
                fatalError()
               }
           }
       }
    
    
}

