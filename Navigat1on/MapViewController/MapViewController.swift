//
//  MapViewControlle.swift
//  Navigat1on
//
//  Created by Илья Сидорик on 20.04.2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

final class MapViewController: UIViewController {
    
    private enum LocalizedKeys: String {
        case segmentedControlItemStandard = "segmentedControl.item.standard"
        case segmentedControlItemHybrid = "segmentedControl.item.hybrid"
        case segmentedControlItemSatellite = "segmentedControl.item.satellite"
        case createRouteButtonTitle = "createRouteButton.title"
    }
    
    // MARK: Properties
    
    private let coordinator: Coordinatable
    
//    private let viewModel: IMapViewModel
    
    private var myAnnotations: [MKPointAnnotation] = []
    
    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.delegate = self
        return locationManager
    }()
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        
        mapView.mapType = .standard
        mapView.showsScale = true
        
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var createRouteButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(
            String(localized: String.LocalizationValue(LocalizedKeys.createRouteButtonTitle.rawValue)),
            for: .normal
        )
        button.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        button.backgroundColor = .systemGray3
        return button
    }()
    
    private lazy var mapTypeSegmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: [
            String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemStandard.rawValue)),
            String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemHybrid.rawValue)),
            String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemSatellite.rawValue))
        ])
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.selectedSegmentTintColor = UIColor(red: 32/255, green: 77/255, blue: 197/255, alpha: 1)
        segmentedControl.backgroundColor = UIColor(red: 254/255, green: 237/255, blue: 233/255, alpha: 1)
        segmentedControl.addTarget(self, action: #selector(self.segmentControlChangeValue), for: .valueChanged)

        return segmentedControl
    }()
    
    
    @objc
    private func didTapButton() {
        print(self.mapView.selectedAnnotations)
        
        guard let annotation = self.mapView.selectedAnnotations.first else {
            print("Локация не выбрана")
            return
        }
        
        self.createRouteOnMap(startCoordinate: self.mapView.userLocation.coordinate, finishCoordinate: annotation.coordinate)
    }
    
    // MARK: - Life cycle
    
    init(coordinator: Coordinatable) {
//        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavigationBarItem()
        self.setupView()
        self.setupConstraint()
        self.setupLocationManager()
        self.setupGestureRecognizer()
    }
    
    
    // MARK: - Methods
    
    private func setupNavigationBarItem() {
        let treshBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "trash"),
            style: .plain,
            target: self,
            action: #selector(self.didTapTrashBarButtonItem)
        )
        
        self.navigationItem.rightBarButtonItem = treshBarButtonItem
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.createRouteButton)
        self.view.addSubview(self.mapTypeSegmentedControl)
    }
    
    private func setupGestureRecognizer() {
        let longPressGR = UILongPressGestureRecognizer(target: self, action: #selector(self.addAnnotation))
        longPressGR.minimumPressDuration = 2.0
        self.mapView.addGestureRecognizer(longPressGR)
    }
    
    private func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.delegate = self
    }
    
    private func createRouteOnMap(startCoordinate: CLLocationCoordinate2D, finishCoordinate: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: startCoordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: finishCoordinate))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        directions.calculate { [weak self] response, error in
            guard let response = response else {
                return
            }
            
            guard let route = response.routes.first else {
                return
            }
            self?.mapView.addOverlay(route.polyline)
            self?.mapView.setVisibleMapRect(
                route.polyline.boundingMapRect,
                edgePadding: UIEdgeInsets(top: 80, left: 20, bottom: 100, right: 20),
                animated: true
            )
        }
    }
    
    @objc
    private func didTapTrashBarButtonItem() {
        self.mapView.removeAnnotations(self.myAnnotations)
        self.myAnnotations.removeAll()
        self.mapView.removeOverlays(self.mapView.overlays)
    }
    
    @objc
    private func addAnnotation(gestureRecognizer: UIGestureRecognizer) {
        guard gestureRecognizer.state == .began else {
            return
        }
        let touchPoint = gestureRecognizer.location(in: self.mapView)
        let newCoordinates = self.mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
        let annotation = MKPointAnnotation()
        annotation.coordinate = newCoordinates
        annotation.title = "Новая точка"
        self.myAnnotations.append(annotation)
        self.mapView.addAnnotation(annotation)
    }
    
    @objc
    private func segmentControlChangeValue(segmentedControl: UISegmentedControl) {
        guard let newMapType = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) else {
            return
        }
        switch newMapType {
        case String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemStandard.rawValue)):
            self.mapView.mapType = .standard
        case String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemHybrid.rawValue)):
            self.mapView.mapType = .hybrid
        case String(localized: String.LocalizationValue(LocalizedKeys.segmentedControlItemSatellite.rawValue)):
            self.mapView.mapType = .satellite
        default:
            return
        }
    }
    
    // MARK: - Constraints
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            self.mapView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.mapView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.mapView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.mapView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            self.mapTypeSegmentedControl.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.mapTypeSegmentedControl.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            self.mapTypeSegmentedControl.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),

            
            self.createRouteButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.createRouteButton.bottomAnchor.constraint(equalTo: self.mapTypeSegmentedControl.topAnchor),
        ])
    }
}



    // MARK: - CLLocationManagerDelegate

extension MapViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            manager.requestLocation()
         
        case .restricted, .denied:
            print("Определение локации невозможно")
            
        case .notDetermined:
            print("Определение локации еще пока не разрешено")
            
        @unknown default:
            fatalError()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else {
            return
        }
        
        let region = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: 10_000,
            longitudinalMeters: 10_000
        )
        self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}



    // MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let render = MKPolylineRenderer(overlay: overlay)
        render.strokeColor = .systemBlue
        render.lineWidth = 5.0
        return render
    }
    
}
