//
//  ViewController.swift
//  getLocation
//
//  Created by Sung Jun Hong on 12/1/18.
//  Copyright © 2018 Sung Jun Hong. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController {


    var locationList = [CLLocation]()
    var markerList = [GMSMarker]()
    var prev: UIView!
    var count = 0
    @IBOutlet weak var longitude: UITextField!
    @IBOutlet weak var latitude: UITextField!
    @IBOutlet weak var navigation: UINavigationItem!
    @IBOutlet weak var map_view: UIView!
    @IBAction func nextMarker(_ sender: Any) {
        if (count == (markerList.count)){
            count = 0
        }
        let marker = markerList[count]
        let camera = GMSCameraPosition.camera(withLatitude:marker.position.latitude, longitude:marker.position.longitude,zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        for marker in markerList{
            marker.map = mapView
        }
        
        let location = locationList[count]
        CLGeocoder().reverseGeocodeLocation(location) {(placemark,error) in
            if error != nil{
                print("error")
            }
            else{
                if let place = placemark?[0]{
                    self.navigation.title = place.name
                }
            }
        }
        count += 1
        
    }
    @IBAction func toMain(_ sender: Any) {
        
//        let camera =     GMSCameraPosition.camera(withLatitude: Double(latitude.text!)!, longitude: Double(longitude.text!)!, zoom: 6.0)
//         let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        self.view = self.prev
        self.navigation.title = ""
//        print(markerMap)
//        mapView.invalidate()
    }
    @IBAction func getLocation(_ sender: Any) {
        //get location based on longitutde and latitude with google url
        
        //first check if the location is a valid location

//        let prevView = view
        let camera =     GMSCameraPosition.camera(withLatitude: Double(latitude.text!)!, longitude: Double(longitude.text!)!, zoom: 11.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        let newMarker = GMSMarker()
        newMarker.position = CLLocationCoordinate2D(latitude: Double(latitude.text!)!, longitude: Double(longitude.text!)!)

        newMarker.map = mapView
        let location = CLLocation(latitude: Double(latitude.text!)!,longitude: Double(longitude.text!)!)
        locationList.append(location)
        markerList.append(newMarker)
        for marker in markerList{
            marker.map = mapView
        }
        displayAddress (marker: newMarker)
        count = 0



    }
    
    func displayAddress(marker: GMSMarker){
        let location = locationList[locationList.count - 1]
        CLGeocoder().reverseGeocodeLocation(location) {(placemark,error) in
            if error != nil{
                print("error")
            }
            else{
                if let place = placemark?[0]{
                    self.navigation.title = place.name
                    marker.title = place.name
                    marker.snippet = place.country
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.prev = view
//        let prevView = view
//         Do any additional setup after loading the view, typically from a nib.
        
    }
    


}

