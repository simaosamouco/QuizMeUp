
//
//  ServiceHelper.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 07/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
import FirebaseDatabase

class ServiceHelper{
    static let shared = ServiceHelper()
    let ref = Database.database().reference()
    
    private var sessionManager: SessionManager
    let novoJson: JSON = []
    var todosJogosReturnar: TodosJogos!
    
    init(){
        self.sessionManager = SessionManager()
    }
    
    func getTenQuestions(cat: String = "",dif: String = "", completinHandler: @escaping (_: PerguntaResponse) -> Void){
        //let url = "https://opentdb.com/api.php?amount=10&type=multiple"
        //https://opentdb.com/api.php?amount=10&category=20&difficulty=easy&type=multiple&encode=base64
        //let url = "https://opentdb.com/api.php?amount=10&type=multiple&encode=base64"
        let url = "https://opentdb.com/api.php?amount=10&category=\(cat)&difficulty=\(dif)&type=multiple&encode=base64"
        self.sessionManager.request(url, method: .get, parameters: [:], headers: ["Accept":"application/json"]).responseString{
            response in
            if let resp = response.result.value
            {
                let novoJson = JSON(parseJSON: resp)
                
                let ch = PerguntaResponse(jsonRecebido: novoJson)
                completinHandler(ch)
            }
        }
    }
    
    func getJogos(completionHandler: @escaping (_: TodosJogos) -> Void){
        //var soparaverumacena: String = "só para ver uma cena"
        //print(soparaverumacena)
       
        ref.observeSingleEvent(of: .value, with: {
            (snapshot) in
          
            do{
                //let jsonData = try JSONSerialization.data(withJSONObject: snapshot.value as! NSDictionary, options: .prettyPrinted)
                let jsonData = try JSONSerialization.data(withJSONObject: snapshot.value as! NSDictionary, options: .prettyPrinted)

                //let decoded = try JSONSerialization.jsonObject(with: jsonData, options: [])
                let jsonText = String(data: jsonData, encoding: .ascii)
                
               // let tentativa = JSON(parseJSON: jsonText!)
                let todosJogo = TodosJogos(jsonRecebido: JSON(parseJSON: jsonText!))
                //self.todosJogosReturnar = todosJogo
                
                completionHandler(todosJogo)
                //print(todosJogo.results)
                
            }catch{}
        })
        
    }
    
}

