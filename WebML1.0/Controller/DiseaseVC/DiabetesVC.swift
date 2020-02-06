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
        if results == 0 {
            resultVC.result = "Congrats!! Our algo has predicted you don't have Diabetes"
        }
        else if results == 1 {
            resultVC.result = "Our algorithm has predicted that there is a high chance you might have Diabetes"
            resultVC.hospitalLabel = "Hospitals Near You"
            resultVC.url = [
            "https://duckduckgo.com/?q=diabetes+near+me&t=ffab&atb=v206-4__&ia=web&iaxm=maps&strict_bbox=1&bbox=28.667045396811837%2C77.01119088731559%2C28.557638615291594%2C77.18971871934684&iai=6849351653114250538", "https://duckduckgo.com/?q=diabetes+near+me&t=ffab&atb=v206-4__&ia=web&iaxm=maps&strict_bbox=1&bbox=28.667045396811837%2C77.01119088731559%2C28.557638615291594%2C77.18971871934684&iai=2146742508691932086" , "https://duckduckgo.com/?q=diabetes+near+me&t=ffab&atb=v206-4__&ia=web&iaxm=maps&strict_bbox=1&bbox=28.667045396811837%2C77.01119088731559%2C28.557638615291594%2C77.18971871934684&iai=5729504019425965219"]
            resultVC.hospName = [
            "Diabetes Solution,Mohan Garden", "Diabetes Clinic, Janakpuri", "Global Wellness Centre Total Diabetes Care, Dashrathpuri"]
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
