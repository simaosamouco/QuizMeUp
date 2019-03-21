//
//  ScoreViewController.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 11/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    var scoreRecebido: Int!
    @IBOutlet weak var labelScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let score = scoreRecebido{
            labelScore.text = "\(score)"
        }
        
    }

    
    
    @IBAction func voltarInicioButton(_ sender: Any) {
       performSegue(withIdentifier: "voltarAoInicio", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
