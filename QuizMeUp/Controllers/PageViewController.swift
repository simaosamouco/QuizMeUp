//
//  PageViewController.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 08/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import UIKit
import SwiftyJSON
import FirebaseDatabase

class PageViewController: UIPageViewController , UpdatePerguntaPageViewProtocol{

    
    
    var jsonPerguntasPage: PerguntaResponse!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var numPerguntasRecebidas: Int!
    var indexPerguntaAMostrar: Int = 0
    var scoreAenviar: Int!
    var catRecebia: String!
    var difRecebida: String!
    //var arrayPerguntas: [Pergunta] = []
    var jogoUsar: Jogo!
    var perguntasDoJogo: [Pergunta] = []
    let ref = Database.database().reference()
    var indexFirebase: Int!
    var procuraCria: Int!
    var jogoCriarIndex: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //ServiceHelper.shared.getTenQuestions(cat: catRecebia, dif: difRecebida,completinHandler: receiveInfo)
       
        
        
        
        ServiceHelper.shared.getJogos(completionHandler: self.receiveInfoGame)
       
        
    }
    
    
    
    /*func updatePergunta(score: Int) -> UIViewController? {
     indexPerguntaAMostrar += 9
     if indexPerguntaAMostrar >= 10{
     mostrarCoise()
     return nil
     }
     orderedViewControllers[indexPerguntaAMostrar].perguntasCertas = score
     
     self.setViewControllers([orderedViewControllers[indexPerguntaAMostrar]],
     direction: .forward,
     animated: true,
     completion: nil)
     
     return orderedViewControllers[indexPerguntaAMostrar]
     }*/
    func updatePergunta(score: Int) {
        scoreAenviar = score
        indexPerguntaAMostrar += 1
        if procuraCria == 1{
            if indexPerguntaAMostrar >= jsonPerguntasPage.results.count{
                self.ref.child("jogos").child("\(jogoCriarIndex)").child("scores").updateChildValues(["0": score])
                
                //self.ref.child("jogos").child("\(Int(indexFirebase))").child("scores").updateChildValues(["1": score])
                mostrarCoise()
                return
            }
        }else if procuraCria == 0{
            if indexPerguntaAMostrar >= jogoUsar.perguntas.count{
                print(indexFirebase)
                self.ref.child("jogos").child("\(Int(indexFirebase))").child("scores").updateChildValues(["1": score])
                
                //self.ref.child("jogos").child("\(Int(indexFirebase))").child("scores").updateChildValues(["1": score])
                mostrarCoise()
                return
            }
        }
        
        orderedViewControllers[indexPerguntaAMostrar].perguntasCertas = score
        
        self.setViewControllers([orderedViewControllers[indexPerguntaAMostrar]],
                                direction: .forward,
                                animated: true,
                                completion: nil)
    }
    func mostrarCoise(){
        performSegue(withIdentifier: "mostraScore", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mostraScore" {
            
            //let index = sender as! IndexPath
            //let indexPath = tableView.index
            let enviar = scoreAenviar
            let controller = segue.destination as? ScoreViewController
            controller?.scoreRecebido = enviar
            
        }else if segue.identifier == "segueMenu"{
            print("JINGLE BELLS")
        }
    }
    
    func receiveInfoGame(todosJogos: TodosJogos){
        //print("O jogador coise barolelos:  \(jogoRecebido.arrayPlayers[0])")
        //jogoGame.arrayPlayers.filter{name in name == "simao"}.count == 0
       procuraCria = 0
        
        for (index, jogoGame) in todosJogos.results.enumerated(){
            if (jogoGame.arrayPlayers.count == 1 && jogoGame.arrayPlayers.first?.lowercased() != "simao") {
                if(jogoGame.perguntas[0].category == catRecebia && jogoGame.perguntas[0].difficulty == difRecebida){
                    print(jogoGame.perguntas[0].question)
                    jogoUsar = jogoGame
                    
                    if let aux = Optional(index) {
                        indexFirebase = Int(aux)
                    }
                    print(indexFirebase)
                    self.ref.child("jogos").child("\(index)").child("players").updateChildValues(["1": "Simao"])
                    
                    break
                }
            }
            jogoCriarIndex += 1
            //aqui chamar a função ? maybe
        }
    
        
        if(jogoCriarIndex >= todosJogos.results.count){
            
            self.chamaPerguntas()
            return
            
        }
        
        print("já saiu do coise")
        for perguntaGame in jogoUsar.perguntas{
            perguntasDoJogo.append(perguntaGame)
            print(perguntaGame.question)
        }
        
        jsonPerguntasPage = PerguntaResponse(jsonRecebido: JSON(todosJogos.results[0].perguntas))
        numPerguntasRecebidas = todosJogos.results[0].perguntas.count
    
        DispatchQueue.main.async {
            for index in 0...self.perguntasDoJogo.count - 1 {
                let vc = self.newVc(viewController: "PerguntaViewControllerID") as! PerguntaViewController
                //vc.childPage = index
                vc.jsonPerguntaAUsar = self.perguntasDoJogo[index]
                //vc.jsonPerguntaAUsar = self.arrayPerguntas[0]
                
                //vc.jsonPerguntaAUsar = jsonPerguntasPage.
                
                //vc.indexPergunta = index + 1
                vc.indexPergunta = index + 1
                self.orderedViewControllers.append(vc)
            }
            
            if let firstViewController = self.orderedViewControllers.first {
                self.setViewControllers([firstViewController],
                                        direction: .forward,
                                        animated: true,
                                        completion: nil)
            }
        }
    }
    
    func chamaPerguntas(){
        ServiceHelper.shared.getTenQuestions(cat: catRecebia, dif: difRecebida,completinHandler: receiveInfo)
    }
    
    func receiveInfo(jsonRec: PerguntaResponse)
    {
        procuraCria = 1
        jsonPerguntasPage = jsonRec
        
        
        numPerguntasRecebidas = jsonRec.results.count
        self.ref.child("jogos").child("\(jogoCriarIndex)").child("players").updateChildValues(["0": "Simao"])
        DispatchQueue.main.async {
            
            for index in 0...jsonRec.results.count - 1 {
                let vc = self.newVc(viewController: "PerguntaViewControllerID") as! PerguntaViewController
                //vc.childPage = index
                vc.jsonPerguntaAUsar = self.jsonPerguntasPage.results[index]
                vc.indexPergunta = index + 1
                //self.ref.child("jogos").child("10").child("questions").setValue(["category": self.jsonPerguntasPage.results[index].category, "type": self.jsonPerguntasPage.results[index].type, "question": self.jsonPerguntasPage.results[index].question, "correctAnswer": self.jsonPerguntasPage.results[index].correctAnswer,"incorrectAnswers": self.jsonPerguntasPage.results[index].incorrectAnswers, "difficulty":self.jsonPerguntasPage.results[index].difficulty])
                self.ref.child("jogos").child("\(self.jogoCriarIndex)").child("questions").child("\(index)").updateChildValues(["category": self.jsonPerguntasPage.results[index].category, "type": self.jsonPerguntasPage.results[index].type, "question": self.jsonPerguntasPage.results[index].question, "correctAnswer": self.jsonPerguntasPage.results[index].correctAnswer,"incorrectAnswers": self.jsonPerguntasPage.results[index].incorrectAnswers, "difficulty":self.jsonPerguntasPage.results[index].difficulty])
                
                self.orderedViewControllers.append(vc)
            }
            
            if let firstViewController = self.orderedViewControllers.first {
                self.setViewControllers([firstViewController],
                                        direction: .forward,
                                        animated: true,
                                        completion: nil)
            }
        }
    }
    
    func chamarAPI(){
        ServiceHelper.shared.getTenQuestions(cat: catRecebia, dif: difRecebida,completinHandler: receiveInfo)
    }
    
    lazy var orderedViewControllers: [PerguntaViewController] = {
        return []
    }()
    
    
    func newVc(viewController: String) -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: viewController) as! PerguntaViewController
        return vc
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
