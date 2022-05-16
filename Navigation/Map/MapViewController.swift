//
//  MapViewController.swift
//  Navigation
//
//  Created by TIS Developer on 16.05.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController {
    
    let recognize = UILongPressGestureRecognizer()
    private let locationManager = CLLocationManager()
    
    let mapView: MKMapView = {
        let map = MKMapView()
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    let mapTypeControll: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Схема","Гибрид","Спутник"])
        control.translatesAutoresizingMaskIntoConstraints = false
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(changeMapType), for: .valueChanged)
        control.accessibilityIgnoresInvertColors = true
        control.selectedSegmentTintColor = .systemGreen
        control.backgroundColor = .green
        return control
    }()
    
    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(systemName: "mappin.slash.circle"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(removeAnnotations), for: .touchUpInside)
        return button
    }()
    
    private var userTrackingButton: MKUserTrackingButton = {
        var button = MKUserTrackingButton()
        button.layer.backgroundColor = UIColor(white: 1, alpha: 0.8).cgColor
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        self.title = "Карта"
        mapView.delegate = self
        setupSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkLocationEnabled()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        //перестать отслеживать местоположение
        locationManager.stopUpdatingLocation()
    }
    
    //настройки местоположения
    func setupManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
    }
    
    //проверка включения локации
    func checkLocationEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            setupManager()
            checkUserLocation()
        } else {
            showAlertLocation(title: "У вас выключена служба геолокации", message: "Для корректной работы приложения необходимо разрешить использовать ваше местоположение", url: URL(string: "App-Prefs:root=LOCATION_SERVICES"))
        }
    }
    
    func showAlertLocation(title: String, message: String?, url: URL?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let settingAction = UIAlertAction(title: "Настройки", style: .default) { (alert) in
            
            DispatchQueue.main.async {
                guard let url = URL(string: UIApplication.openSettingsURLString),
                      UIApplication.shared.canOpenURL(url)
                else {
                    return
                }
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(settingAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {return}
        let region = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation else { return }
        let alert = UIAlertController(title: "Построить маршрут?", message: nil, preferredStyle: .alert)
        let alertYes = UIAlertAction(title: "Да", style: .default) { _ in
            let directionRequest = MKDirections.Request()

            let sourcePlacemark = MKPlacemark(coordinate: self.mapView.userLocation.coordinate)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)

            let destinationPlacemark = MKPlacemark(coordinate: annotation.coordinate)
            let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

            directionRequest.source = sourceMapItem
            directionRequest.destination = destinationMapItem
            directionRequest.transportType = .walking

            let directions = MKDirections(request: directionRequest)

            directions.calculate { [weak self] response, error in
                guard let self = self else { return }

                guard let response = response else {
                    if let error = error {
                        print(error)
                    }
                    return
                }
                let route = response.routes[0]
                self.mapView.addOverlay(route.polyline, level: .aboveRoads)

                let rect = route.polyline.boundingMapRect

                self.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }

        let alertNo = UIAlertAction(title: "Нет", style: .default)
        [alertYes,alertNo].forEach(alert.addAction(_:))
        self.present(alert, animated: true)
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = UIColor.red
        renderer.lineWidth = 5
        return renderer
    }
}

extension MapViewController {

    func setupSubviews() {
        [mapView, button, mapTypeControll].forEach(view.addSubview(_:))
        recognize.addTarget(self, action: #selector(self.addPins))
        mapView.addGestureRecognizer(recognize)
        
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        // configure tracking button
        mapView.addSubview(userTrackingButton)
        userTrackingButton.mapView = mapView

        let constraints = [
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 10),
            button.widthAnchor.constraint(equalToConstant: 40),
            button.heightAnchor.constraint(equalToConstant: 40),

            mapTypeControll.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mapTypeControll.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30),
            mapTypeControll.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mapTypeControll.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20),
            mapTypeControll.heightAnchor.constraint(equalToConstant: 30),
            
            userTrackingButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -150),
            userTrackingButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -10),
            userTrackingButton.heightAnchor.constraint(equalToConstant: 50),
            userTrackingButton.widthAnchor.constraint(equalToConstant: 50),
        ]

        NSLayoutConstraint.activate(constraints)
    }

    func checkUserLocation() {
        if #available(iOS 14.0, *) {
            switch locationManager.authorizationStatus {
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
                locationManager.requestAlwaysAuthorization()
            case .authorizedAlways:
                mapView.showsUserLocation = true
            default:
                break
            }
        } else {
            switch CLLocationManager.authorizationStatus() {
            case .notDetermined:
                locationManager.requestAlwaysAuthorization()
            case .restricted:
                locationManager.requestAlwaysAuthorization()
            case .denied:
                break
            case .authorizedAlways:
                mapView.showsUserLocation = true
            case .authorizedWhenInUse:
                mapView.showsUserLocation = true
            @unknown default:
                break
            }
        }
    }

    @objc func addPins() {
        let location = recognize.location(in: mapView)
        let coordinate = mapView.convert(location, toCoordinateFrom: nil)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mapView.addAnnotation(annotation)
    }

    @objc func removeAnnotations() {
        let annotations = mapView.annotations
        mapView.removeAnnotations(annotations)
        let overlays = mapView.overlays
        mapView.removeOverlays(overlays)
    }

    @objc func changeMapType() {
        switch mapTypeControll.selectedSegmentIndex {
        case 0:
            mapView.mapType = .standard
        case 1:
            mapView.mapType = .hybrid
        case 2:
            mapView.mapType = .satellite
        default: break
        }
    }
}
