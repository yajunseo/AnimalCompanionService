//
//  Animal2ViewController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/30.
//

import UIKit

class Animal2ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource {

    @IBOutlet weak var tbData: UITableView!
 
    var url : String?
    
    //xml파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    //feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    //title과 date 같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    //저장 문자열 변수
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    
    var kind = NSMutableString()
    var local = NSMutableString()
    //위도 경도 좌표 변수
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    var imageurl = NSMutableString()
    
    
    var hospitalname = ""
    var hospitalname_utf8 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //XML 파싱
        beginParsing()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func beginParsing()
    {
        //url = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upr_cd=6260000&ServiceKey=14LZYq3Lnyj3IOVhgRlTNzGTD8cON64czIilWCGmI8%2BHRGck4fpCi%2F3v54yCMngqYnXUPy13i2jE7lvBYS4ZKQ%3D%3D"
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    //parser가 새로운 element를 발견하면 변수를 생성한다
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if(elementName as NSString).isEqual(to: "item")
        {
            elements = NSMutableDictionary()
            elements = [:]
            kind = NSMutableString()
            kind = ""
            local = NSMutableString()
            local = ""
            imageurl = NSMutableString()
            imageurl = ""
        
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            //위도 경도
            XPos = NSMutableString()
            XPos = ""
            YPos = NSMutableString()
            YPos = ""
            
        }
    }
    
    //title과 pubDate을 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        if element.isEqual(to: "kindCd"){
            kind.append(string)
        } else if element.isEqual(to: "orgNm"){
            local.append(string)
        }
        //위도 경도
        else if element.isEqual(to: "orgNm"){
            XPos.append(string)
        }else if element.isEqual(to: "orgNm"){
            YPos.append(string)
        }else if element.isEqual(to: "popfile"){
            imageurl.append(string)
        }
    }
    
    
    //element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to : "item"){
            if !kind.isEqual(nil){
                elements.setObject(kind, forKey: "kind" as NSCopying)
            }
            if !local.isEqual(nil){
                elements.setObject(local, forKey: "local" as NSCopying)
            }
            //위도 경도
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "orgNm" as NSCopying)
            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "orgNm" as NSCopying)
            }
            if !imageurl.isEqual(nil){
                elements.setObject(imageurl, forKey: "imageurl" as NSCopying)
            }
            posts.add(elements)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "kind") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "local") as! NSString as String
        //국회의원 사진 url을 다운로드하여 표시
        if let url = URL(string: (posts.object(at: indexPath.row) as AnyObject).value(forKey: "imageurl") as! NSString as String)
        {
            if let data = try? Data(contentsOf: url)
            {
                cell.imageView?.image = UIImage(data: data)
            }
        }
        return cell
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController{
                mapViewController.posts = posts
            }
        }
        
//        if segue.identifier == "segueToAnimalDetail"{
//            if let cell = sender as? UITableViewCell{
//                let indexPath = tableView.indexPath(for: cell)
//                hospitalname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "yadmNm") as! NSString as String
//                hospitalname_utf8 = hospitalname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
//                if let detailAnimalController = segue.destination as?
//                    DetailAnimalController{
//                    detailAnimalController.url = url! + "&yadmNm=" +
//                    hospitalname_utf8
//                }
//            }
//        }
//
    
        if segue.identifier == "segueToAnimalDetail" {
            if let navController = segue.destination as? UINavigationController{
                if let detailAnimalController = navController.topViewController as? DetailAnimalController{
                    detailAnimalController.url = url
                }
            }
        }
        //if segue.identifier == "segueToInformationView"{
        //    if let cell = sender as? UITableViewCell{
        //        let indexPath = tableView.indexPath(for: cell)
        //        hospitalname = (posts.object(at: (indexPath?.row)!) as //AnyObject).value(forKey: "yadmNm") as! NSString as String
         //       hospitalname_utf8 = hospitalname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        //        if let detailHospitalTableViewController = segue.destination as?
        //            DetailHospitalTableViewController{
        //            detailHospitalTableViewController.url = url! + "&yadmNm=" +
        //            hospitalname_utf8
         //       }
         //   }
        
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
