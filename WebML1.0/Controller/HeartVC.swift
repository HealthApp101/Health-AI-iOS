//
//  HeartVC.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import CoreML

class HeartVC : UIViewController, UINavigationControllerDelegate{
    @IBOutlet var heartText: [UITextField]!
    override func viewDidLoad() {
           super.viewDidLoad()
       }
       
       func detect(){
           
           guard let output = try? HeartDisease.model.prediction(age: HeartDisease.Variables[0], sex: HeartDisease.Variables[1], cp: HeartDisease.Variables[2], trestbps: HeartDisease.Variables[3], chol: HeartDisease.Variables[4], fbs: HeartDisease.Variables[5], restecg: HeartDisease.Variables[6], thalach: HeartDisease.Variables[7], exang: HeartDisease.Variables[8], oldpeak: HeartDisease.Variables[9], slopes: HeartDisease.Variables[10], ca: HeartDisease.Variables[11], thal: HeartDisease.Variables[12]) else {
               fatalError("Input Failed")
           }
           
           let price = output.target
           self.navigationItem.title = "\(price)"
           print(price)
       }
    @IBAction func submitPressed(_ sender: UIButton) {
        var count = 0
                   for textfields in heartText{
                       HeartDisease.Variables.append(Double(textfields.text!) ?? HeartDisease.mean[count])
                       
                       count = count+1
                   }
                   detect()
                   for textfields in heartText {
                       textfields.text = " "
                   }
    }
}
