//
//  DiabetesVC.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import CoreML

class DiabetesVC : UIViewController{
    
    @IBOutlet var diabetesText: [UITextField]!
    
    var results : Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func detect(){
        
        guard let output = try? Diabetes.model.prediction(Pregnancies: Diabetes.Variables[0], Glucose: Diabetes.Variables[1], BloodPressure: Diabetes.Variables[2], SkinThickness: Diabetes.Variables[3], Insulin: Diabetes.Variables[4], BMI: Diabetes.Variables[5], DiabetesPedigreeFunction: Diabetes.Variables[6], Age: Diabetes.Variables[7])
            else{
                fatalError("Input")
        }
        results = output.Outcome
//        self.navigationItem.title = "\(results)"
        print(results)
        print(output)
       performSegue(withIdentifier: "result", sender: self)
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultVC = segue.destination as! ResultVC
        if results == 1 {
            resultVC.result = "Congrats!! Our algo has predicted you don't have Diabetes"
        }
        else {
            resultVC.result = "Our algo has predicted you have Diabetes"
   }
       // resultVC.result="\(results)"
    }
    @IBAction func submitPressed(_ sender: UIButton) {
        var count = 0
                  for textfields in diabetesText{
                      Diabetes.Variables.append(Double(textfields.text!) ?? Diabetes.mean[count])
                    
                      count = count+1
                  }
                 detect()
                  for textfields in diabetesText {
                      textfields.text = " "
                  }

    }
    
}
