//
//  ViewController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/13.
//

import UIKit

class ViewController: UIViewController, XMLParserDelegate, UITableViewDataSource {
    @IBOutlet weak var tbData: UITableView!

    @IBAction func dogTab(_ sender: Any) {
        selectKind = "개"
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    @IBAction func catTab(_ sender: Any) {
        selectKind = "고양이"
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    @IBAction func defaultTab(_ sender: Any) {
        selectKind = "기타"
        parser.delegate = self
        parser.parse()
        tbData!.reloadData()
    }
    
    var selectKind : String = "개"
    //xml파일을 다운로드 및 파싱하는 오브젝트
    var parser = XMLParser()
    //feed 데이터를 저장하는 mutable array
    var posts = NSMutableArray()
    //title과 date 같은 feed 데이터를 저장하는 mutable dictionary
    var elements = NSMutableDictionary()
    var element = NSString()
    //저장 문자열 변수
    var kind = NSMutableString()
    var local = NSMutableString()
    
    var imageurl = NSMutableString()

    var url : String = "http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?ServiceKey=14LZYq3Lnyj3IOVhgRlTNzGTD8cON64czIilWCGmI8%2BHRGck4fpCi%2F3v54yCMngqYnXUPy13i2jE7lvBYS4ZKQ%3D%3D"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beginParsing()
        // Do any additional setup after loading the view.
    }

    //parse오브젝트 초기화하고 XMLparserDelegate로 설정하고 XML 파싱시작
    func beginParsing()
    {
        posts = []
        //공공데이터포털국회의원정보
        
        parser = XMLParser(contentsOf:(URL(string:"http://openapi.animal.go.kr/openapi/service/rest/abandonmentPublicSrvc/abandonmentPublic?upr_cd=6110000&ServiceKey=14LZYq3Lnyj3IOVhgRlTNzGTD8cON64czIilWCGmI8%2BHRGck4fpCi%2F3v54yCMngqYnXUPy13i2jE7lvBYS4ZKQ%3D%3D"))!)!
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
        }
    }
    
    //title과 pubDate을 발견하면 title1과 date에 완성한다.
    func parser(_ parser: XMLParser, foundCharacters string: String)
    {
        //국회의원 이름
        if element.isEqual(to: "kindCd"){
//            if(selectKind == "개"){
//                if (string == "개"){
//                    kind.append(string)
//                }
//            }else if(selectKind == "고양이"){
//                if (string == "고양이"){
//                    kind.append(string)
//                }
//            }else if(selectKind == "기타"){
//                if (string != "개" && string != "고양이"){
//                    kind.append(string)
//                }
//            }
            kind.append(string)
        } else if element.isEqual(to: "orgNm"){
            local.append(string)
            //국회의원 이미지url
        } else if element.isEqual(to: "popfile"){
            imageurl.append(string)
        }
        //if element.isEqual(to: "title"){
        //   title1.append(string)
        //} else if element.isEqual(to: "pubDate"){
        //    date.append(string)
        //}
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
            //국회의원 사진 url
            if !imageurl.isEqual(nil){
                elements.setObject(imageurl, forKey: "imageurl" as NSCopying)
            }
            
            posts.add(elements)
        }
    }
    
    //row의 개수는 posts 배열 원소의 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return posts.count
    }
    
    //테이블뷰 셀의 내용은 title과 subtitle 을 posts 배열의 원소(dictionary)에서 title과 date 에 해당하는 value 로 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
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
        if segue.identifier == "segueToFindView" {
            if let navController = segue.destination as? UINavigationController{
                if let findController = navController.topViewController as? FindController{
                    //animalInfromationViewController.url = url + sgguCd
                    findController.url = url
                }
            }
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        if segue.identifier == "ssegueToInformationView" {
//            if let navController = segue.destination as? UINavigationController{
//                if let animalInfromationViewController = navController.topViewController as? AnimalInfromationViewController{
//                    //animalInfromationViewController.url = url + sgguCd
//                    animalInfromationViewController.url = url
//                }
//            }
//        }
//    }
}

