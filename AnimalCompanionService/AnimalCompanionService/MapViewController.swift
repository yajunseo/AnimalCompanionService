//
//  MapViewController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/16.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON

class MapViewController: UIViewController, MKMapViewDelegate {
    @IBOutlet weak var mapView: MKMapView!

    var addressString = ""
    var posts = NSMutableArray()
    
    let regionRadius: CLLocationDistance = 5000
    func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                      latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
    var hospitals: [Hospital] = []
    
    //PublicArt.json 파일을 파싱해서 Artwork 객체 배열 생성
    func loadInitialData() {
        // 1. PublicArt.json 파일을 읽어서 data에 저장
        for post in posts{
            let yadmNm = (post as AnyObject).value(forKey: "local") as! NSString as String
            let addr = (post as AnyObject).value(forKey: "local") as! NSString as String
            let XPos = (post as AnyObject).value(forKey: "local") as! NSString as String
            let YPos = (post as AnyObject).value(forKey: "local") as! NSString as String
            let lat = (YPos as NSString).doubleValue
            let lon = (XPos as NSString).doubleValue
            let hospital = Hospital(title: yadmNm, locationName: addr, coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
            hospitals.append(hospital)
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl){
        let location = view.annotation as! Hospital
        let launchOptions = [MKLaunchOptionsDirectionsModeKey:
        MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard let annotation = annotation as? Hospital else {return nil}
        let identifier = "marker"
        var view: MKMarkerAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)as? MKMarkerAnnotationView{
            dequeuedView.annotation = annotation
            view = dequeuedView
        }else{
            view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
       }
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let NAVER_CLIENT_ID = "vw8hzgh8q2"
        let NAVER_CLIENT_SECRET = "VD3QUUpLxKIuRrs4TrrDmc6V8nJRUPNrixF5frV8"
        let NAVER_GEOCODE_URL = "https://naveropenapi.apigw.ntruss.com/map-geocode/v2/geocode?query="
        
        
        
        var 주소 = ""
        주소 = addressString
        let encodeAddress = 주소.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let header1 = HTTPHeader(name: "X-NCP-APIGW-API-KEY-ID", value: NAVER_CLIENT_ID)
        let header2 = HTTPHeader(name: "X-NCP-APIGW-API-KEY", value: NAVER_CLIENT_SECRET)
        let headers = HTTPHeaders([header1,header2])
        
        var initialLocation = CLLocation(latitude: 0, longitude: 0)
        
        AF.request(NAVER_GEOCODE_URL + encodeAddress, method: .get,headers: headers).validate()
                .responseJSON { response in
                    switch response.result {
                    case .success(let value as [String:Any]):
                        let json = JSON(value)
                        let data = json["addresses"]
                        let lat = data[0]["y"]
                        let lon = data[0]["x"]
                        //print(type(of: lat))
                        //let vlat = lat.doubleValue
                        //let vlon = lon.doubleValue
                        let vlat = lat.double
                        var vlon = lon.double
                        print(type(of: vlat))
                        //initialLocation = CLLocation(latitude: lat.rawValue as! CLLocationDegrees, longitude: lon.rawValue as! CLLocationDegrees)
                        //let vlat = (data[0]["y"] as? NSString)?.doubleValue
                        //let vlon = (data[0]["x"] as? NSString)?.doubleValue
                        //vlon = lon.doubleValue
                        //vlon = 129.20632609999998
                        print("홍대입구역의","위도는", lat,"경도는", lon)
                        initialLocation = CLLocation(latitude: vlat ?? 35.1948366, longitude: vlon ?? 129.2063261)
                    case .failure(let error):
                        //initialLocation = CLLocation(latitude: 37.557576, longitude: 126.9251192)
                        print(error.errorDescription ?? "")
                    default :
                        //initialLocation = CLLocation(latitude: 37.557576, longitude: 126.9251192)
                        fatalError()
                    }
                }
        
        print(addressString)
    
        //initialLocation = CLLocation(latitude: 35.177502399999995, longitude: 128.9170219)
        //let initialLocation = CLLocation(latitude: 37.557576, longitude: 126.9251192)
        
        centerMapOnLocation(location: initialLocation)
        mapView.delegate = self
        loadInitialData()
        mapView.addAnnotations(hospitals)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
