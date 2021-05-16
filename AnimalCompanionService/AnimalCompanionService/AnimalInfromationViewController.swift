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
    
    //위도 경도 좌표 변수
    var XPos = NSMutableString()
    var YPos = NSMutableString()
    
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
        url = "http://apis.data.go.kr/B551182/hospInfoService/getHospBasisList?pageNo=1&numOfRows=10&serviceKey=sea100UMmw23Xycs33F1EQnumONR%2F9ElxBLzkilU9Yr1oT4TrCot8Y2p0jyuJP72x9rG9D8CN5yuEs6AS2sAiw%3D%3D&sidoCd=110000&sgguCd="
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
        if element.isEqual(to: "yadmNm"){
            yadmNm.append(string)
        } else if element.isEqual(to: "addr"){
            addr.append(string)
        }
        //위도 경도
        else if element.isEqual(to: "XPos"){
            XPos.append(string)
        }else if element.isEqual(to: "YPos"){
            YPos.append(string)
        }
    }
    
    
    //element의 끝에서 feed데이터를 dictionary에 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String,
                namespaceURI: String?, qualifiedName qName: String?)
    {
        if(elementName as NSString).isEqual(to : "item"){
            if !yadmNm.isEqual(nil){
                elements.setObject(yadmNm, forKey: "yadmNm" as NSCopying)
            }
            if !addr.isEqual(nil){
                elements.setObject(addr, forKey: "addr" as NSCopying)
            }
            //위도 경도
            if !XPos.isEqual(nil){
                elements.setObject(XPos, forKey: "XPos" as NSCopying)
            }
            if !YPos.isEqual(nil){
                elements.setObject(YPos, forKey: "YPos" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    //테이블뷰 셀의 내용은 title과 subtitle 을 posts 배열의 원소(dictionary)에서 title과 date 에 해당하는 value 로 설정
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "yadmNm") as! NSString as String
        cell.detailTextLabel?.text = (posts.object(at: indexPath.row) as AnyObject).value(forKey: "addr") as! NSString as String
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController{
                mapViewController.posts = posts
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
