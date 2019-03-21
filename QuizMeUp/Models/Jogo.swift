//
//  Jogo.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 13/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Jogo{
   // var player1: String!
    //var player2: String!
    
    //var score1: Int!
    //var score2: Int!
    var perguntas: [Pergunta] = []
    var arrayPlayers: [String] = []
    var scores: [Int] = []
    var perguntaas: PerguntaResponse!
    
    init(jsonRecebido: JSON){
        for player in jsonRecebido["players"].arrayValue{
            self.arrayPlayers.append(player.stringValue)
        }
        
        for pergunta in jsonRecebido["questions"].arrayValue{
            self.perguntas.append(Pergunta.init(jsonFirebase: pergunta))
        }
 
        //self.perguntaas = PerguntaResponse(jsonRecebido: JSON(jsonRecebido["questions"].arrayValue))  // ISTO NAO FUNCIONA
      
        
        for score in jsonRecebido["scores"].arrayValue{
            self.scores.append(score.intValue)
        }
        
    }
}
