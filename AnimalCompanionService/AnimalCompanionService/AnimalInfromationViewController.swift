//
//  AnimalInfromationViewController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/16.
//

import UIKit

class AnimalInfromationViewController: UITableViewController, XMLParserDelegate {
   
    
    @IBOutlet var tbData: UITableView!
    
    
    var url : String?
    var sido1 : String?
    var serviceKey1 : String?
    
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

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return posts.count
    }

    //parse오브젝트 초기화하고 XMLparserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
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
    
    //테이블뷰 셀의 내용은 title과 subtitle 을 posts 배열의 원소(dictionary)에서 title과 date 에 해당하는 value 로 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "kind") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "local") as! NSString as String
        
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
//        if segue.identifier == "segueToMapView" {
//            if let mapViewController = segue.destination as? MapViewController{
//                mapViewController.posts = posts
//            }
//        }
        
        if segue.identifier == "segueToAnimalDetail"{
            if let cell = sender as? UITableViewCell{
                var url1 : String?
                url1 = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upr_cd="
                
                let indexPath = tableView.indexPath(for: cell)
                var row : Int = 0
                row = indexPath!.row
                
                //hospitalname = (posts.object(at: (indexPath?.row)!) as AnyObject).value(forKey: "yadmNm") as! NSString as String
                //hospitalname_utf8 = hospitalname.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
                if let detailAnimalController = segue.destination as?
                    DetailAnimalController{
//                    detailAnimalController.url = url! + "&yadmNm=" +
//                    hospitalname_utf8
                    detailAnimalController.url = url1! + sido1! + "&numOfRows=" + String(row) + serviceKey1!
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
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
