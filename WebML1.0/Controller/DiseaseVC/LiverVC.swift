//
//  LiverVC.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit
import CoreML

class LiverVC : UIViewController{

    @IBOutlet var liverText: [UITextField]!
    
    var results : Int64 = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func detect(){
        
        guard let output = try? Liver.model.prediction(Age: Liver.Variables[0], Gender: Liver.Variables[1], Total_Bilirubin: Liver.Variables[2], Direct_Bilirubin: Liver.Variables[3], Alkaline_Phosphotase: Liver.Variables[4], Alamine_Aminotransferase: Liver.Variables[5], Aspartate_Aminotransferase: Liver.Variables[6], Total_Protiens: Liver.Variables[7], Albumin: Liver.Variables[8], Albumin_and_Globulin_Ratio: Liver.Variables[9]) else{
            fatalError()
        }
       
        let result = output.Dataset
        performSegue(withIdentifier: "results", sender: self)
        print(result)
        //self.navigationItem.title = "\(result)"
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let result = segue.destination as! ResultVC
        if results == 1 {
                   result.result = "Congrats!! Our algo has predicted you don't have Liver Disease"
               }
               else {
                   result.result = "Our algo has predicted you have Liver Disease"
          }
    }
    
    @IBAction func submitPressed(_ sender: UIButton) { var count = 0
               for textfields in liverText{
                   Liver.Variables.append(Double(textfields.text!) ?? Liver.mean[count])
                   
                   count = count+1
               }
              detect()
               for textfields in liverText {
                   textfields.text = " "
               }
    }
}
