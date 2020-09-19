//
//  MapViewController.swift
//  MyPlaces
//
//  Created by Alexandr Badmaev on 19.09.2020.
//  Copyright © 2020 Alexandr Badmaev. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    // MARK: - Properties
    @IBOutlet var mapView: MKMapView!
    
    var place = Place()
    let annotaionId = "annotaionId"

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView.delegate = self
        setupPlacemark()
    }
    
    // MARK: - Actions
    @IBAction func closeVC() {
        dismiss(animated: true)
    }
    
    // MARK: - Methods
    private func setupPlacemark() {
        guard let location = place.location else { return }
        
        let geocoder = CLGeocoder()
        
        // определение координат по адресу. в возврате массив меток (чаще одна)
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            if let error = error {
                print(error)
                return
            }
            
            guard let placemarks = placemarks else { return }
            
            let placemark = placemarks.first
            
            // описание точки на карте
            let annotation = MKPointAnnotation()
            annotation.title = self.place.name
            annotation.subtitle = self.place.type
            
            // положение аннотации
            guard let placemarkLocation = placemark?.location else { return }
            annotation.coordinate = placemarkLocation.coordinate
            
            // задать видимую область карты чтобы были видны все созданные аннотации
            self.mapView.showAnnotations([annotation], animated: true)
            // выделение аннотации
            self.mapView.selectAnnotation(annotation, animated: true)
        }
    }
    
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !(annotation is MKUserLocation) else { return nil }
        
        var annotaionView = mapView.dequeueReusableAnnotationView(withIdentifier: annotaionId) as? MKPinAnnotationView
        
        if annotaionView == nil {
            annotaionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotaionId)
            // чтобы отобразить аннотацию в виде баннера
            annotaionView?.canShowCallout = true
        }
        
        if let imageData = place.imageData {
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
            imageView.layer.cornerRadius = 10
            imageView.clipsToBounds = true
            imageView.image = UIImage(data: imageData)
            annotaionView?.rightCalloutAccessoryView = imageView
        }
        
        return annotaionView
    }
}
