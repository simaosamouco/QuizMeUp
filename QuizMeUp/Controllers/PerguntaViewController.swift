//
//  PerguntaViewController.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 07/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import UIKit
import PopupDialog
import FirebaseDatabase
import SwiftyJSON

class PerguntaViewController: UIViewController {
    
    

    @IBOutlet weak var labelPergunta: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var labelPerguntaNumero: UILabel!
    @IBOutlet weak var labelScore: UILabel!
    @IBOutlet weak var labelTimer: UILabel!
    
    var jsonPerguntas: PerguntaResponse!
    
    var jsonPerguntaAUsar: Pergunta!
    var numCerto: Int!
    var indexPergunta: Int!
    var indexPerguntaAux: Int = 1
    var perguntasCertas: Int = 0
    
    var segundos = 15
    var timer = Timer()
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var delegate: UpdatePerguntaPageViewProtocol!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ServiceHelper.shared.getTenQuestions(completinHandler: receiveInfo)
        let ref = Database.database().reference()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(PerguntaViewController.paraApagar), userInfo: nil, repeats: true)
        
        //ref.child("jogos/jignle").setValue(jsonPerguntaAUsar)
        //ref.child("jogos").child("01").child("category").setValue(["category": jsonPerguntaAUsar.category])
        //ref.child("jogos").child("01").child("type").setValue(["type": jsonPerguntaAUsar.type])
        
        
         /*USAR ESTE
        ref.child("jogos").child("01").setValue(["category": jsonPerguntaAUsar.category, "type": jsonPerguntaAUsar.type, "question": jsonPerguntaAUsar.question, "correctAnswer": jsonPerguntaAUsar.correctAnswer,
                                                 "incorrectAnswers": jsonPerguntaAUsar.incorrectAnswers, "difficulty":jsonPerguntaAUsar.difficulty])*/
 
        
        //ref.child("jogos/jogo1").child("players").child("1").setValue("idk2")
        //ref.child("jogos/jogo1").child("players").child("0").setValue("idk")
        //let pergAuxx = jsonPerguntaAUsar as! NSDictionary
        
        /*
        do{
            let jsonDataa = try JSONSerialization.data(withJSONObject: jsonPerguntaAUsar as! NSDictionary, options: .prettyPrinted)
            
            //let jsonEncoder = JSONEncoder()
            //let jsonData = try jsonEncoder.encode(jsonPerguntaAUsar)
            
            
            ref.child("jogos").child("20").setValue(jsonDataa)
        }catch{
            
        }
       */
        
        //ref.child("jogos").child("20").setValue([])
       
        porInformacoes()
    }

    @objc func paraApagar(){
        segundos -= 1
        if segundos == 0 {
            timer.invalidate()
             delegate = self.parent as! PageViewController
            
            animacaoTempo()
        }
        
        
        labelTimer.text = "\(segundos)"
    }
    func receiveInfo(jsonRec: PerguntaResponse)
    {
     jsonPerguntas = jsonRec
    porInformacoes()
    }
    
    func porInformacoes(){
        //print(jsonPerguntas.results[indexPergunta].question)
        //print(jsonPerguntas.results[indexPergunta].correctAnswer)
        labelPergunta.text = jsonPerguntaAUsar.question
        //let auxx = indexPergunta+1
        if let indexPer = indexPergunta{
            labelPerguntaNumero.text = "\(indexPer)/10"
        }
        //labelPerguntaNumero.text = "\(indexPergunta)"
        
            labelScore.text = "Score: \(perguntasCertas)"
        
        //labelScore.text = "Score : \(perguntasCertas)"
        
        print(jsonPerguntaAUsar.question)
        print(jsonPerguntaAUsar.correctAnswer)
        atribuirRespostaCertaButton()
    }
    
    
    func atribuirRespostaCertaButton(){
        var randomNumber = Int(arc4random_uniform(4))
        randomNumber += 1
        numCerto = randomNumber
        
        switch randomNumber {
        case 1:
            button1.setTitle(jsonPerguntaAUsar.correctAnswer, for: .normal)
            
            button2.setTitle(jsonPerguntaAUsar.incorrectAnswers[0], for: .normal)
            button3.setTitle(jsonPerguntaAUsar.incorrectAnswers[1], for: .normal)
            button4.setTitle(jsonPerguntaAUsar.incorrectAnswers[2], for: .normal)
        //button1.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
        case 2:
            button2.setTitle(jsonPerguntaAUsar.correctAnswer, for: .normal)
            
            button1.setTitle(jsonPerguntaAUsar.incorrectAnswers[0], for: .normal)
            button3.setTitle(jsonPerguntaAUsar.incorrectAnswers[1], for: .normal)
            button4.setTitle(jsonPerguntaAUsar.incorrectAnswers[2], for: .normal)
        //button2.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
        case 3:
            button3.setTitle(jsonPerguntaAUsar.correctAnswer, for: .normal)
            
            button1.setTitle(jsonPerguntaAUsar.incorrectAnswers[0], for: .normal)
            button2.setTitle(jsonPerguntaAUsar.incorrectAnswers[1], for: .normal)
            button4.setTitle(jsonPerguntaAUsar.incorrectAnswers[2], for: .normal)
        //button3.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
        case 4:
            button4.setTitle(jsonPerguntaAUsar.correctAnswer, for: .normal)
            
            button1.setTitle(jsonPerguntaAUsar.incorrectAnswers[0], for: .normal)
            button2.setTitle(jsonPerguntaAUsar.incorrectAnswers[1], for: .normal)
            button3.setTitle(jsonPerguntaAUsar.incorrectAnswers[2], for: .normal)
        //button4.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
        default:
            print("i dont get it lol")
        }
        
    }
    
    //############################# ACTIONS BUTTON "#########################
    
    @IBAction func button1(_ sender: Any) {
        indexPerguntaAux += 1
        delegate = self.parent as! PageViewController
        if button1.tag == numCerto{
                print("Responsta Certa")
            //perguntasCertas += 1
            perguntasCertas += (20 - (15-segundos))
                animacaoCerto()
                //delegate.updatePergunta(score: perguntasCertas)
            
        }else{
                print("Resposta Errada")
                animacaoErrado()
                //delegate.updatePergunta(score: perguntasCertas)
            
            
        }
        //porInformacoes()
    }
    @IBAction func button2(_ sender: Any) {
        indexPerguntaAux += 1
        delegate = self.parent as! PageViewController
        if button2.tag == numCerto{
                print("Responsta Certa")
            //perguntasCertas += 1
            perguntasCertas += (20 - (15-segundos))
                animacaoCerto()
                //delegate.updatePergunta(score: perguntasCertas)
            
        }else{
                print("Resposta Errada")
                animacaoErrado()
                //delegate.updatePergunta(score: perguntasCertas)
            
        }
        //porInformacoes()
    }
    @IBAction func button3(_ sender: Any) {
        indexPerguntaAux += 1
        delegate = self.parent as! PageViewController
        if button3.tag == numCerto{
                print("Responsta Certa")
            //perguntasCertas += 1
            perguntasCertas += (20 - (15-segundos))
                animacaoCerto()
                //delegate.updatePergunta(score: perguntasCertas)
            
        }else{
                print("Resposta Errada")
                animacaoErrado()
                //delegate.updatePergunta(score: perguntasCertas)
        }
        //porInformacoes()
    }
    @IBAction func button4(_ sender: Any) {
        indexPerguntaAux += 1
        delegate = self.parent as! PageViewController
        if button4.tag == numCerto{
                animacaoCerto()
                print("Responsta Certa")
                //perguntasCertas += 1
                perguntasCertas += (20 - (15-segundos))
                //delegate.updatePergunta(score: perguntasCertas)
            
        }else{
                print("Resposta Errada")
                animacaoErrado()
                //delegate.updatePergunta(score: perguntasCertas)
        }
        //porInformacoes()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func animacaoCerto(){
       let ex = PopupDialogDefaultView.appearance()
        let title = "CORRECT!"
        let message = "Your answer is correct! :D"
        let popup = PopupDialog(title: title, message: message)
        
        
        ex.titleColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.titleFont = UIFont(name: "HelveticaNeue-Light", size : 35)!
        ex.backgroundColor = UIColor(red:0, green:150/255, blue:0, alpha:1.00)
        ex.messageColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.messageFont = UIFont(name: "HelveticaNeue-Light", size : 28)!
        
        self.present(popup, animated: true, completion: {
            self.timer.invalidate()
            self.delegate.updatePergunta(score: self.perguntasCertas)
        })
        //sleep(4)
 
    }
    
    func animacaoErrado(){
        let ex = PopupDialogDefaultView.appearance()
        let title = "Wrong! :("
        var message = ""
        if let correta = jsonPerguntaAUsar.correctAnswer{
            message = "The right answer was: \n \(correta)"
        }
        //let message = "A resposta certa era: \n \(jsonPerguntaAUsar.correctAnswer)"
        let popup = PopupDialog(title: title, message: message)
        
        
        ex.titleColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.titleFont = UIFont(name: "HelveticaNeue-Light", size : 40)!
        ex.backgroundColor = UIColor(red:200/255, green:0/255, blue:0, alpha:1.00)
        ex.messageColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.messageFont = UIFont(name: "HelveticaNeue-Light", size : 28)!
        
        self.present(popup, animated: true, completion: {
            self.timer.invalidate()
            self.delegate.updatePergunta(score: self.perguntasCertas)
        })
        //sleep(4)
 
    }
    func animacaoTempo(){
        let ex = PopupDialogDefaultView.appearance()
        let title = "Time's up! :("
        var message = ""
        if let correta = jsonPerguntaAUsar.correctAnswer{
            message = "The right answer was: \n \(correta)"
        }
        //let message = "A resposta certa era: \n \(jsonPerguntaAUsar.correctAnswer)"
        let popup = PopupDialog(title: title, message: message)
        
        
        ex.titleColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.titleFont = UIFont(name: "HelveticaNeue-Light", size : 40)!
        ex.backgroundColor = UIColor(red:200/255, green:0/255, blue:0, alpha:1.00)
        ex.messageColor = UIColor(red:1, green:1, blue:1, alpha:1.00)
        ex.messageFont = UIFont(name: "HelveticaNeue-Light", size : 28)!
        
        self.present(popup, animated: true, completion: {
            self.delegate.updatePergunta(score: self.perguntasCertas)
        })
        //sleep(4)
        
    }
}















/*
 switch randomNumber {
 case 1:
 button1.setTitle(jsonPerguntas.results[indexPergunta].correctAnswer, for: .normal)
 
 button2.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[0], for: .normal)
 button3.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[1], for: .normal)
 button4.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[2], for: .normal)
 //button1.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
 case 2:
 button2.setTitle(jsonPerguntas.results[indexPergunta].correctAnswer, for: .normal)
 
 button1.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[0], for: .normal)
 button3.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[1], for: .normal)
 button4.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[2], for: .normal)
 //button2.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
 case 3:
 button3.setTitle(jsonPerguntas.results[indexPergunta].correctAnswer, for: .normal)
 
 button1.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[0], for: .normal)
 button2.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[1], for: .normal)
 button4.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[2], for: .normal)
 //button3.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
 case 4:
 button4.setTitle(jsonPerguntas.results[indexPergunta].correctAnswer, for: .normal)
 
 button1.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[0], for: .normal)
 button2.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[1], for: .normal)
 button3.setTitle(jsonPerguntas.results[indexPergunta].incorrectAnswers[2], for: .normal)
 //button4.titleLabel?.text = jsonPerguntas.results[1].correctAnswer
 default:
 print("i dont get it lol")
 }
 */
