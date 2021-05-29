//
//  DetailAnimal.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/29.
//

import UIKit

class DetailAnimal: UIViewController, XMLParserDelegate {

    var url : String?
    var parser = XMLParser()
    let postsname : [String] = ["병원명", "주소", "전화번호", "홈페이지", "종별코드명", "개설일자", "의사총수", "전문의 인원수","일반의 인원수", "레지던트 인원수", "인턴 인원수"]
    var posts : [String] = ["","","","","","","","","","",""]
    var element = NSString()
    var yadmNm = NSMutableString()
    var addr = NSMutableString()
    var telno = NSMutableString()
    var hospUrl = NSMutableString()
    var clCdNm = NSMutableString()
    var estbDd = NSMutableString()
    var drTotCnt = NSMutableString()
    var sdrCnt = NSMutableString()
    var gdrCnt = NSMutableString()
    var resdntCnt = NSMutableString()
    var intnCnt = NSMutableString()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func beginParsing()
    {
        posts = []
        parser = XMLParser(contentsOf:(URL(string:url!))!)!
        parser.delegate = self
        parser.parse()
        detailTableView!.reloadData()
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?,qualifiedName qName: String?, attributes attributeDict: [String : String])
    {
        element = elementName as NSString
        if (elementName as NSString).isEqual(to: "item")
        {
            posts = ["","","","","","","","","","",""]
            
            yadmNm = NSMutableString()
            yadmNm = ""
            addr = NSMutableString()
            addr = ""
            
            telno = NSMutableString()
            telno = ""
            hospUrl = NSMutableString()
            hospUrl = ""
            clCdNm = NSMutableString()
            clCdNm = ""
            estbDd = NSMutableString()
            estbDd = ""
            drTotCnt = NSMutableString()
            drTotCnt = ""
            sdrCnt = NSMutableString()
            sdrCnt = ""
            gdrCnt = NSMutableString()
            gdrCnt = ""
            resdntCnt = NSMutableString()
            resdntCnt = ""
            intnCnt = NSMutableString()
            intnCnt = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if element.isEqual(to: "yadmNm"){
            yadmNm.append(string)
        }else if element.isEqual(to: "addr"){
            addr.append(string)
        }else if element.isEqual(to: "telno"){
            telno.append(string)
        }else if element.isEqual(to: "hospUrl"){
            hospUrl.append(string)
        }else if element.isEqual(to: "clCdNm"){
            clCdNm.append(string)
        }else if element.isEqual(to: "estbDd"){
            estbDd.append(string)
        }else if element.isEqual(to: "drTotCnt"){
            drTotCnt.append(string)
        }else if element.isEqual(to: "sdrCnt"){
            sdrCnt.append(string)
        }else if element.isEqual(to: "gdrCnt"){
            gdrCnt.append(string)
        }else if element.isEqual(to: "resdntCnt"){
            resdntCnt.append(string)
        }else if element.isEqual(to: "intnCnt"){
            intnCnt.append(string)
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if(elementName as NSString).isEqual(to: "item"){
            if !yadmNm.isEqual(nil){
                posts[0] = yadmNm as String
            }
            if !addr.isEqual(nil){
                posts[1] = addr as String
            }
            if !telno.isEqual(nil){
                posts[2] = telno as String
            }
            if !hospUrl.isEqual(nil){
                posts[3] = hospUrl as String
            }
            if !clCdNm.isEqual(nil){
                posts[4] = clCdNm as String
            }
            if !estbDd.isEqual(nil){
                posts[5] = estbDd as String
            }
            if !drTotCnt.isEqual(nil){
                posts[6] = drTotCnt as String
            }
            if !sdrCnt.isEqual(nil){
                posts[7] = sdrCnt as String
            }
            if !gdrCnt.isEqual(nil){
                posts[8] = gdrCnt as String
            }
            if !resdntCnt.isEqual(nil){
                posts[9] = resdntCnt as String
            }
            if !intnCnt.isEqual(nil){
                posts[10] = intnCnt as String
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "HospitalCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = postsname[indexPath.row]
        cell.detailTextLabel?.text = posts[indexPath.row]
        return cell
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
