//
//  PaginaInicialViewController.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 11/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import UIKit
import iOSDropDown
import FirebaseDatabase
class PaginaInicialViewController: UIViewController {

    @IBOutlet weak var categoriaDD: DropDown!
    @IBOutlet weak var difficultyDD: DropDown!
    var indexAux: Int = 0
    var catAenviar: String!
    var enviarDif: String!
    //var tentPer: Pergunta!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoriaDD.optionArray = ["General Knowledge", "Sports", "Geography", "Video Games", "It doesn't matter lol"]
        //categoriaDD.optionIds = [9, 21, 22, 15, 0]
        difficultyDD.optionArray = ["Easy", "Medium", "Hard"]
        
        let ref = Database.database().reference()
        
        //ServiceHelper.shared.getJogo()
        
        
        //var tentPer: Pergunta
        /*
        tentPer.category = "jingle bells"
        tentPer.correctAnswer = "their meet"
        tentPer.incorrectAnswers = ["oh", "mah", "gawd"]
        tentPer.difficulty = "extremely easy"
        tentPer.question = "whats ur favourite thing about koalas ?"
        tentPer.type = "the one with the black out"
        */
        //ref.child("jogos/jogo4").setValue("estou-me a passar")
       // ref.child("jogos").childByAutoId().setValue(tentPer)
        
        /*
        ref.child("jogos/id").observeSingleEvent(of: .value){
            (snapshot) in
            let jogoId = snapshot.value as? Int
            print("O ID do jogo é :\(jogoId)")
        }
        */
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        if categoriaDD.selectedIndex != nil{
            indexAux = categoriaDD.selectedIndex!
            if indexAux == 0{
                print("General Knowledge")
                catAenviar = "9"
                verificarDif()
                performSegue(withIdentifier: "initialToQuestion", sender: self)
            }else if indexAux == 1{
                catAenviar = "21"
                print("Sports")
                verificarDif()
                performSegue(withIdentifier: "initialToQuestion", sender: self)
            }else if indexAux == 2{
                catAenviar = "22"
                print("Geography")
                verificarDif()
                performSegue(withIdentifier: "initialToQuestion", sender: self)
            }else if indexAux == 3{
                catAenviar = "15"
                print("Video Games")
                verificarDif()
                performSegue(withIdentifier: "initialToQuestion", sender: self)
            }else if indexAux == 4{
                catAenviar = ""
                print("It doesn't matter lol")
                verificarDif()
                performSegue(withIdentifier: "initialToQuestion", sender: self)
            }
            //print(indexAux)
        }else {
            print("You must choose an option...")
        }
        
        
        
        //var categoriaEscolhida = categoriaDD
        //print(categoriaEscolhida)
    }
    
    func verificarDif(){
        
        if difficultyDD.selectedIndex == 0 {
            enviarDif = "easy"
            return
        }else if difficultyDD.selectedIndex == 1{
            enviarDif = "medium"
            return
        }else if difficultyDD.selectedIndex == 2{
            enviarDif = "hard"
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "initialToQuestion" {
            //let index = sender as! IndexPath
            //let indexPath = tableView.index
            let enviar = catAenviar
            
            let controller = segue.destination as? PageViewController
            controller?.catRecebia = enviar
            controller?.difRecebida = enviarDif
        }
    }
    
    
    
}
