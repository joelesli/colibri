//
//  MapViewController.swift
//  colibri-api
//
//  Created by Joel Martinez on 12/16/17.
//  Copyright © 2017 JOELESLI. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    let networkHelper = NetworkHelper()
    
    @IBOutlet weak var slider: UISlider!
    var minTime : Int?
    var maxTime : Int?
    
    var system : System?
    var annotations = [MKAnnotation]()
    @IBOutlet weak var viewMap: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = system?.operatorName
        
        viewMap.addAnnotations(annotations)
        fetchAnnotations()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupSlider(min: Int?, max: Int?) {
        guard let mi = min, let mx = max else {
            return
        }
        slider.setValue(0.0, animated: true)
    }

    @IBAction func valueChanged(_ sender: UISlider) {
        let window = 300
        let start = Int(sender.value * Float(annotations.count - window))
        let end = start + window < annotations.count ? start + window : annotations.count - 1
        let selectedAnnotations = Array(annotations[start...end])
        viewMap.removeAnnotations(viewMap.annotations)
        viewMap.addAnnotations(selectedAnnotations)
        viewMap.showAnnotations(selectedAnnotations, animated: true)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func fetchAnnotations() {
        
        if let mac = system?.mac {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            networkHelper.getGPSHistory(parameters: ["mac":mac], callback: { (results) in
                if let history = results.last as? GPSHistory,
                    let gpsHistory = history.history  {
                    
                    let gpsPoints = gpsHistory.sorted(by: { (point01, point02) -> Bool in
                        return point01.time ?? 0 < point02.time ?? 0
                    })
                    
                    self.annotations = gpsPoints
                    
                    self.minTime = gpsPoints.first?.time
                    self.maxTime = gpsPoints.last?.time
                    
                    DispatchQueue.main.async {
                        self.valueChanged(self.slider)
                        UIApplication.shared.isNetworkActivityIndicatorVisible = false
                    }
                    
                }
                else {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
        }
        
        
    }
}

extension MapViewController : MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "annotation"
        
        var view : MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView
        
        if view == nil {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
        }
        
        view?.pinTintColor = UIColor(hue: normalizedTimeFor(annotation: annotation), saturation: 1, brightness: 1, alpha: 1)
        
//        print(annotation)
        
        return view
    }
    
    func normalizedTimeFor(annotation: MKAnnotation) -> CGFloat {
        
        guard let point = annotation as? GPSData, let time = point.time, let min = minTime, let max = maxTime else {
            return 0
        }
        
        let numerator = CGFloat(integerLiteral: time) - CGFloat(integerLiteral: min)
        let denominator = CGFloat(integerLiteral: max) - CGFloat(integerLiteral: min)
        
        return numerator/denominator
    }
    
}
