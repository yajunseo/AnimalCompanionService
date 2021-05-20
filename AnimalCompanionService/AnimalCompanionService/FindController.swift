//
//  FindController.swift
//  AnimalCompanionService
//
//  Created by kpugame on 2021/05/19.
//

import UIKit
import Speech
class FindController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var sido : String = ""
    var sigungu : String = ""

    var url : String?
    @IBOutlet weak var pickerView1: UIPickerView!
    @IBOutlet weak var transcribeButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    @IBOutlet weak var myTextView: UITextView!
    @IBAction func startTranscribing(_ sender: Any) {
        transcribeButton.isEnabled = false
        stopButton.isEnabled = true
        try! startSession()
    }
    @IBAction func stopTranscribing(_ sender: Any) {
        if audioEngine.isRunning{
            audioEngine.stop()
            speechRecognitionRequest?.endAudio()
            transcribeButton.isEnabled = true
            stopButton.isEnabled = false
        }
        switch(self.myTextView.text){
        case "서울특별시" : self.pickerView1.selectRow(0, inComponent: 0, animated: true)
            sido = "6110000"
            break
        case "부산 광역시" : self.pickerView1.selectRow(1, inComponent: 0, animated: true)
            sido = "6260000"
            break
        case "대구 광역시" : self.pickerView1.selectRow(2, inComponent: 0, animated: true)
            sido = "6270000"
            break
        case "인천 광역시" : self.pickerView1.selectRow(3, inComponent: 0, animated: true)
            sido = "6280000"
            break
        case "광주 광역시" : self.pickerView1.selectRow(4, inComponent: 0, animated: true)
            sido = "6290000"
            break
        case "세종특별자치시" : self.pickerView1.selectRow(5, inComponent: 0, animated: true)
            sido = "5690000"
            break
        case "대전 광역시" : self.pickerView1.selectRow(6, inComponent: 0, animated: true)
            sido = "6300000"
            break
        case "울산 광역시" : self.pickerView1.selectRow(7, inComponent: 0, animated: true)
            sido = "6310000"
            break
        case "경기도" : self.pickerView1.selectRow(8, inComponent: 0, animated: true)
            sido = "6410000"
            break
        case "강원도" : self.pickerView1.selectRow(9, inComponent: 0, animated: true)
            sido = "6420000"
            break
        default: break
        }
    }
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ko-KR"))!
    
    //private let speechRecognizer = SFSpeechRecognizer()!
    private var speechRecognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    private var speechRecognitionTask: SFSpeechRecognitionTask?
    //AVAudioEngine 인스턴스를 사용하여 오디오를 오디오 버퍼로 스트리밍
    private let audioEngine = AVAudioEngine()
    
    //pickerView 데이터 배열
    var pickerDataSource1 = ["서울특별시", "부산 광역시", "대구 광역시", "인천 광역시", "광주 광역시", "세종특별자치시", "대전 광역시", "울산 광역시", "경기도", "강원도"]
    //6110000 6260000 6270000 6280000 6290000 5690000 6300000 6310000 6410000 6420000
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authorizeSR()
        
        // Do any additional setup after loading the view.
        //pickerView의 데이터소스와 델리게이트를 ViewController로 설정
        self.pickerView1.delegate = self;
        self.pickerView1.dataSource = self;
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

        return pickerDataSource1.count
    }
    //pickerView의 주어진 컴포넌트/row에 대한 데이터 = pickerDataSource 배열의 원소
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
        if pickerView.tag == 0{
            return pickerDataSource1[row]
        }
       
        return pickerDataSource1[row]
    }

//    //pickerView의 row 선택시 sgguCd 를 변경
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        //6110000 6260000 6270000 6280000 6290000 5690000 6300000 6310000 6410000 6420000
        if pickerView.tag == 0{
            if row == 0 {
                sido = "6110000"
            }else if row == 1 {
                sido = "6260000"
            }else if row == 2 {
                sido = "6270000"
            }else if row == 3 {
                sido = "6280000"
            }else if row == 4 {
                sido = "6290000"
            }else if row == 5 {
                sido = "5690000"
            }else if row == 6 {
                sido = "6300000"
            }else if row == 7 {
                sido = "6310000"
            }else if row == 8 {
                sido = "6410000"
            }else if row == 9 {
                sido = "6420000"
            }
            
        }
    }
    
    func authorizeSR(){
        SFSpeechRecognizer.requestAuthorization{authStatus in
            //이 핸들러에는 4 개의 값 (권한 부여, 거부, 제한 또는 결정되지 않음) 중 하나 일 수있는 상태 값이 전달됩니다.
            //그런 다음 switch 문을 사용하여 상태를 평가하고 기록 버튼을 활성화하거나 해당 버튼에 실패 원인을 표시합니다.
            OperationQueue.main.addOperation{
                switch authStatus{
                case .authorized:
                    self.transcribeButton.isEnabled = true
                    
                case .denied:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition access denied by user", for: .disabled)
                
                case .restricted:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition restricted on device", for: .disabled)
                    
                case .notDetermined:
                    self.transcribeButton.isEnabled = false
                    self.transcribeButton.setTitle("Speech recognition not authorized", for: .disabled)
                }
            }
        }
    }
    
    func startSession() throws{
        if let recognitionTask = speechRecognitionTask{
            speechRecognitionTask?.cancel()
            self.speechRecognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSession.Category.record)
        
        speechRecognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let recognitionRequest = speechRecognitionRequest else
            {fatalError("SFSpeechAudioBufferRecognitionRequest object cration failed")}
        
        let inputNode = audioEngine.inputNode
        
        recognitionRequest.shouldReportPartialResults = true
        
        speechRecognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in var finished = false
            
            if let result = result{
                self.myTextView.text =
                    result.bestTranscription.formattedString
                finished = result.isFinal
        }
            
            if error != nil || finished{
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.speechRecognitionRequest = nil
                self.speechRecognitionTask = nil
                
                self.transcribeButton.isEnabled = true
            }
        }
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) {
            (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            
            self.speechRecognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
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
