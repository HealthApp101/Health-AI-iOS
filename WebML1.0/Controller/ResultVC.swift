//
//  DiabetesResult.swift
//  WebML1.0
//
//  Created by Pushpinder Pal Singh on 05/02/20.
//  Copyright © 2020 Pushpinder Pal Singh. All rights reserved.
//

import UIKit

class ResultVC : UIViewController{
    @IBOutlet weak var resultsLabel: UILabel!
    var result : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        resultsLabel.lineBreakMode = .byWordWrapping
        resultsLabel.numberOfLines = 0
        resultsLabel.text = result
        resultsLabel.textColor = .white
    }

}
