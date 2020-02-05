//
//  DiabetesResult.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class DiabetesResult : UIViewController{
    @IBOutlet weak var resultsLabel: UILabel!
    var result : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.text = result
    }

}
