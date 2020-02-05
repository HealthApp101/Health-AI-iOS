//
//  Sepsis.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 04/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import CoreML

class SepsisVC : UIViewController {
    
    @IBOutlet var sepsisText: [UITextField]!
    var results : Int64 = 0
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func detect(){
           guard let output = try? Sepsis.model.prediction(HR: Sepsis.Variables[0], O2Sat: Sepsis.Variables[1], SBP: Sepsis.Variables[2], MAP: Sepsis.Variables[3], DBP: Sepsis.Variables[4], Resp: Sepsis.Variables[5], Age: Sepsis.Variables[6], Gender: Sepsis.Variables[7], Unit1: Sepsis.Variables[8], Unit2: Sepsis.Variables[9], HospAdmTime: Sepsis.Variables[10], ICULOS: Sepsis.Variables[11]) else{
               fatalError("Input")
           }
            results = output.SepsisLabel
//           self.navigationItem.title = "\(result)"
           performSegue(withIdentifier: "sepsisResult", sender: self)
           print(results)
       }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let result = segue.destination as! SepsisResult
        if results == 1 {
                   result.result = "Congrats!! Our algo has predicted you don't have Sepsis"
               }
               else {
                   result.result = "Our algo has predicted you have Sepsis"
          }
    }
    @IBAction func submitPressed(_ sender: UIButton) {
        var count = 0
        for textfields in sepsisText{
            Sepsis.Variables.append(Double(textfields.text!) ?? Sepsis.mean[count])
            
            count = count+1
        }
        detect()
        for textfields in sepsisText {
            textfields.text = " "
        }
    }
}
