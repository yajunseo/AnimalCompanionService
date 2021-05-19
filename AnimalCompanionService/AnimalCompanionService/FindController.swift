//
//  FindController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/19.
//

import UIKit

class FindController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    var url : String?
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var pickerView2: UIPickerView!
    @IBOutlet weak var pickerView3: UIPickerView!
    @IBOutlet weak var pickerView4: UIPickerView!
    
    //pickerView 데이터 배열
    var pickerDataSource1 = ["광진구", "구로구", "동대문구", "종로구"]
    var pickerDataSource2 = ["aaaa", "bbbb", "cccc", "dddd"]
    var pickerDataSource3 = ["eeee", "ffff", "gggg", "hhhh"]
    var pickerDataSource4 = ["iiii", "jjjj", "kkkk", "llll"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //authorizeSR()
        // Do any additional setup after loading the view.
        //pickerView의 데이터소스와 델리게이트를 ViewController로 설정
        self.pickerView1.delegate = self;
        self.pickerView1.dataSource = self;
        self.pickerView2.delegate = self;
        self.pickerView2.dataSource = self;
        self.pickerView3.delegate = self;
        self.pickerView3.dataSource = self;
        self.pickerView4.delegate = self;
        self.pickerView4.dataSource = self;
    }
    
    //pickerView의 컴포넌트 개수 = 1
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    //pickerView의 각 컴포넌트에 대한 row의 개수 = pickerDataSource 배열 원소 개수
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0{
            return pickerDataSource1.count
        }
        if pickerView.tag == 1{
            return pickerDataSource2.count
        }
        if pickerView.tag == 2{
            return pickerDataSource3.count
        }
        if pickerView.tag == 3{
            return pickerDataSource4.count
        }
        return pickerDataSource1.count
    }
    //pickerView의 주어진 컴포넌트/row에 대한 데이터 = pickerDataSource 배열의 원소
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if pickerView.tag == 0{
            return pickerDataSource1[row]
        }
        if pickerView.tag == 1{
            return pickerDataSource2[row]
        }
        if pickerView.tag == 2{
            return pickerDataSource3[row]
        }
        if pickerView.tag == 3{
            return pickerDataSource4[row]
        }
        return pickerDataSource1[row]
    }

//    //pickerView의 row 선택시 sgguCd 를 변경
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
//        if row == 0 {
//            sgguCd = "110023"   //광진구 시구코드
//        }else if row == 1 {
//            sgguCd = "110005"   //구로구 시구코드
//        }else if row == 2 {
//            sgguCd = "110007"   //동대문구 시구코드
//        }else {
//            sgguCd = "110016"   //종로구 시구코드
//        }
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
