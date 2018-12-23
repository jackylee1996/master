//
//  MapViewController.swift
//  Campus Walk
//
//  Created by Jackeline Lee on 10/15/18.
//  Copyright © 2018 Jackeline Lee. All rights reserved.
//

import Foundation
import MapKit

class Place : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var title : String?
    init(title: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
    }
    var mapItem : MKMapItem {
        let placeMark = MKPlacemark(coordinate: coordinate)
        let item = MKMapItem(placemark: placeMark)
        return item
    }
}

class MapViewController : UIViewController, MKMapViewDelegate, BuildingDelegate, ImageDelegate, FavoriteDelegate, CLLocationManagerDelegate{
    func pinIt(indexPath: IndexPath) {
        print("pinning")
    }
    

    
    func favorite(indexPath: IndexPath) {
        print("marking favorite")
    }
    
    func addPin(indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        let building = mapModel.getBuilding(at: indexPath)
        let coordinate = CLLocationCoordinate2DMake(building.latitude, building.longitude)
        let annotation = Place(title: building.name, coordinate: coordinate)
        
        mapView.addAnnotation(annotation)
        
        let circle = MKCircle(center: coordinate, radius: 50.0)
        mapView.add(circle)

        let geoCoder = CLGeocoder()
        let location = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)

        geoCoder.reverseGeocodeLocation(location) { (placeMarks, error) in
            guard (error == nil) else {print(error!.localizedDescription); return}
//            if let placeMark = placeMarks?[0] {
//                let street = placeMark.thoroughfare ?? ""
//                let number = placeMark.subThoroughfare ?? ""
//            }
        }
    }
    
    func removePin(indexPath: IndexPath) {
        self.dismiss(animated: true, completion: nil)
        let building = mapModel.getBuilding(at: indexPath)
        annotation.coordinate = CLLocationCoordinate2DMake(building.latitude, building.longitude)
        let annotationList = mapView.annotations
        for annotation in annotationList{
            mapView.removeAnnotation(annotation)
        }
    }
    @IBAction func removeAllPins(_ sender: Any) {
        let annotationList = mapView.annotations
        for annotation in annotationList{
            mapView.removeAnnotation(annotation)
        }
    }
    @IBOutlet weak var removeAll: UIButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var mapType: UISegmentedControl!
    
    let annotation = MKPointAnnotation()
    let mapModel = MapModel.sharedInstance
    let spanDelta = 0.03
    
    let locationManager = CLLocationManager()
    
    var previousMapLocation : CLLocation?
    
    var isTracking = false
    var pathCoordinates : [CLLocationCoordinate2D]?
    var userPath : MKPolyline?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let location = mapModel.initialLocation
        let coordinate = location.coordinate
        let span = MKCoordinateSpan(latitudeDelta: spanDelta, longitudeDelta: spanDelta)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if CLLocationManager.locationServicesEnabled() {
            let status = CLLocationManager.authorizationStatus()
            switch status {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways, .authorizedWhenInUse:
                mapView.showsUserLocation = true
            default:
                break

            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .denied, .restricted:
            mapView.showsUserLocation = false
        case .authorizedAlways, .authorizedWhenInUse:
            mapView.showsUserLocation = true
        default:
            break

        }
    }
    @IBAction func tracking(_ sender: Any) {
        isTracking = !isTracking
        if isTracking {
            locationManager.startUpdatingLocation()
            pathCoordinates = []
        } else {
            locationManager.stopUpdatingLocation()
            pathCoordinates = nil
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if isTracking {
            let newCoordinates = locations.map {$0.coordinate}
            pathCoordinates?.append(contentsOf: newCoordinates)
            
            if let userPath = userPath {
                mapView.remove(userPath)
            }
            
            userPath = MKPolyline(coordinates: pathCoordinates!, count: pathCoordinates!.count)
            mapView.add(userPath!)
            
        }
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is Place:
            return annotationView(forPlace: annotation as! Place)
        default:
            return nil
        }
    }
    
    func annotationView(forPlace place:Place) -> MKAnnotationView {
        let identifier = "Place"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView{
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: place, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        
        return view
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        switch overlay {
        case is MKPolygon:
            let polygon = MKPolygonRenderer(polygon: overlay as! MKPolygon)
            polygon.fillColor = UIColor.lightGray
            polygon.strokeColor = UIColor.blue
            polygon.alpha = 0.4
            polygon.lineWidth = 2.0
            return polygon
        case is MKCircle:
            let circle = MKCircleRenderer(circle: overlay as! MKCircle)
            circle.fillColor = UIColor.red
            circle.alpha = 0.7
            return circle
        case is MKPolyline:
            let line = MKPolylineRenderer(polyline: overlay as! MKPolyline)
            line.strokeColor = UIColor.blue
            line.lineWidth = 4.0
            return line
        default:
            assert(false, "unhandled overlay")
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        switch view.annotation {
        case is Place:
            let place = view.annotation as! Place
            let alertView = UIAlertController(title: place.title, message: nil, preferredStyle: .actionSheet)
            
            let actionDirection = UIAlertAction(title: "Directions", style: .default) { (action) in
                self.requestDirections(place)
            }
            alertView.addAction(actionDirection)
            
            let actionCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertView.addAction(actionCancel)
            self.present(alertView, animated: true, completion: nil)
        default:
            break
        }
        
    }
    
    func requestDirections(_ place:Place) {
        let walkingRouteRequest = MKDirectionsRequest()
        walkingRouteRequest.source = MKMapItem.forCurrentLocation()
        walkingRouteRequest.destination = place.mapItem
        walkingRouteRequest.transportType = .walking
        walkingRouteRequest.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: walkingRouteRequest)
        directions.calculate { (response, error) in
            guard error == nil else {print(error?.localizedDescription); return}
            
            let route = response?.routes.first!
            self.mapView.add((route?.polyline)!)
            let steps = route?.steps
            
            
        }
    }
    
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = mapView.region.center
        let  newLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
        let distance = previousMapLocation?.distance(from: newLocation)
    }
    
    func mapView(_ mapView: MKMapView, regionWillChangeAnimated animated: Bool) {
        let center = mapView.region.center
        previousMapLocation = CLLocation(latitude: center.latitude, longitude: center.longitude)
    }
    
    @IBAction func cancelSearch(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelFavorite(segue:UIStoryboardSegue) {
        dismiss(animated: true, completion: nil)
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        switch segue.identifier {
        case "BuildingSegue":
            let navController = segue.destination as! UINavigationController
            let buildingViewController = navController.topViewController as! BuildingTableViewController
            buildingViewController.delegate = self
        case "favorites":
            let navController = segue.destination as! UINavigationController
            let favoriteViewController = navController.topViewController as! FavoriteTableViewController
            favoriteViewController.delegate = self
        default:
            assert(false, "Unhandled Segue")
        }
    }
    
    
    @IBAction func mapMode(_ sender: UISegmentedControl) {
        switch (sender.selectedSegmentIndex){
        case 0:
            mapView.mapType = .hybrid
        case 1:
            mapView.mapType = .standard
        case 2:
            mapView.mapType = .satellite
        default:
            break
        }
    }

}


