//
//  DetailAnimalController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/29.
//

import UIKit

class DetailAnimalController: UITableViewController, XMLParserDelegate {

    @IBOutlet weak var detailTableView: UITableView!
    
    @IBAction func doneToDetailViewController(segue:UIStoryboardSegue){
    }
    
    var url : String?
    var parser = XMLParser()
    let postsname : [String] = ["품종", "성별", "색상", "무게", "나이", "중성화 완료", "특징", "보호센터", "주소"]
    var posts : [String] = ["","","","","","","","",""]
    var element = NSString()
//    var yadmNm = NSMutableString()
//    var addr = NSMutableString()
//    var telno = NSMutableString()
//    var hospUrl = NSMutableString()
//    var clCdNm = NSMutableString()
//    var estbDd = NSMutableString()
//    var drTotCnt = NSMutableString()
//    var sdrCnt = NSMutableString()
//    var gdrCnt = NSMutableString()
//    var resdntCnt = NSMutableString()
//    var intnCnt = NSMutableString()
    
    var kind = NSMutableString()
    var sex = NSMutableString()
    var color = NSMutableString()
    var weight = NSMutableString()
    var age = NSMutableString()
    var neutralization = NSMutableString()
    var characteristic = NSMutableString()
    var center = NSMutableString()
    var addr = NSMutableString()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        beginParsing()
    }

    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        //detailTableView!.reloadData()
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            posts = ["","","","","","","","",""]
            
//            yadmNm = NSMutableString()
//            yadmNm = ""
//            addr = NSMutableString()
//            addr = ""
//
//            telno = NSMutableString()
//            telno = ""
//            hospUrl = NSMutableString()
//            hospUrl = ""
//            clCdNm = NSMutableString()
//            clCdNm = ""
//            estbDd = NSMutableString()
//            estbDd = ""
//            drTotCnt = NSMutableString()
//            drTotCnt = ""
//            sdrCnt = NSMutableString()
//            sdrCnt = ""
//            gdrCnt = NSMutableString()
//            gdrCnt = ""
//            resdntCnt = NSMutableString()
//            resdntCnt = ""
//            intnCnt = NSMutableString()
//            intnCnt = ""
            
            kind = NSMutableString()
            kind = ""
            sex = NSMutableString()
            sex = ""
            color = NSMutableString()
            color = ""
            weight = NSMutableString()
            weight = ""
            age = NSMutableString()
            age = ""
            neutralization = NSMutableString()
            neutralization = ""
            characteristic = NSMutableString()
            characteristic = ""
            center = NSMutableString()
            center = ""
            addr = NSMutableString()
            addr = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
//        if element.isEqual(to: "yadmNm"){
//            yadmNm.append(string)
//        }else if element.isEqual(to: "addr"){
//            addr.append(string)
//        }else if element.isEqual(to: "telno"){
//            telno.append(string)
//        }else if element.isEqual(to: "hospUrl"){
//            hospUrl.append(string)
//        }else if element.isEqual(to: "clCdNm"){
//            clCdNm.append(string)
//        }else if element.isEqual(to: "estbDd"){
//            estbDd.append(string)
//        }else if element.isEqual(to: "drTotCnt"){
//            drTotCnt.append(string)
//        }else if element.isEqual(to: "sdrCnt"){
//            sdrCnt.append(string)
//        }else if element.isEqual(to: "gdrCnt"){
//            gdrCnt.append(string)
//        }else if element.isEqual(to: "resdntCnt"){
//            resdntCnt.append(string)
//        }else if element.isEqual(to: "intnCnt"){
//            intnCnt.append(string)
//        }
        if element.isEqual(to: "kindCd"){
            kind.append(string)
        }else if element.isEqual(to: "sexCd"){
            sex.append(string)
        }else if element.isEqual(to: "colorCd"){
            color.append(string)
        }else if element.isEqual(to: "weight"){
            weight.append(string)
        }else if element.isEqual(to: "age"){
            age.append(string)
        }else if element.isEqual(to: "neuterYn"){
            neutralization.append(string)
        }else if element.isEqual(to: "specialMark"){
            characteristic.append(string)
        }else if element.isEqual(to: "careNm"){
            center.append(string)
        }else if element.isEqual(to: "careAddr"){
            addr.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item"){
//            if !yadmNm.isEqual(nil){
//                posts[0] = yadmNm as String
//            }
//            if !addr.isEqual(nil){
//                posts[1] = addr as String
//            }
//            if !telno.isEqual(nil){
//                posts[2] = telno as String
//            }
//            if !hospUrl.isEqual(nil){
//                posts[3] = hospUrl as String
//            }
//            if !clCdNm.isEqual(nil){
//                posts[4] = clCdNm as String
//            }
//            if !estbDd.isEqual(nil){
//                posts[5] = estbDd as String
//            }
//            if !drTotCnt.isEqual(nil){
//                posts[6] = drTotCnt as String
//            }
//            if !sdrCnt.isEqual(nil){
//                posts[7] = sdrCnt as String
//            }
//            if !gdrCnt.isEqual(nil){
//                posts[8] = gdrCnt as String
//            }
//            if !resdntCnt.isEqual(nil){
//                posts[9] = resdntCnt as String
//            }
//            if !intnCnt.isEqual(nil){
//                posts[10] = intnCnt as String
//            }
            
            if !kind.isEqual(nil){
                posts[0] = kind as String
            }
            if !sex.isEqual(nil){
                posts[1] = sex as String
            }
            if !color.isEqual(nil){
                posts[2] = color as String
            }
            if !weight.isEqual(nil){
                posts[3] = weight as String
            }
            if !age.isEqual(nil){
                posts[4] = age as String
            }
            if !neutralization.isEqual(nil){
                posts[5] = neutralization as String
            }
            if !characteristic.isEqual(nil){
                posts[6] = characteristic as String
            }
            if !center.isEqual(nil){
                posts[7] = center as String
            }
            if !addr.isEqual(nil){
                posts[8] = addr as String
            }
        }
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

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AnimalCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "segueToMapView" {
            if let mapViewController = segue.destination as? MapViewController{
                mapViewController.addressString = posts[8]
            }
        }
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
