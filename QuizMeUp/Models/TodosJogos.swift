//
//  TodosJogos.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 14/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class TodosJogos{
    var results: [Jogo] = []
    
    init(jsonRecebido: JSON){
        for jogo in jsonRecebido["jogos"].arrayValue{
            self.results.append(Jogo.init(jsonRecebido: jogo))
        }
    }
}
