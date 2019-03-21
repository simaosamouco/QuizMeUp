//
//  PerguntaResponse.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 07/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class PerguntaResponse{
    var results: [Pergunta] = []
    
    init(jsonRecebido: JSON) {
        for question in jsonRecebido["results"].arrayValue{
            results.append(Pergunta.init(jsonRecebido: question))
        }
    }
}
