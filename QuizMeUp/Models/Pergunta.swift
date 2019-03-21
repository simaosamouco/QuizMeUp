//
//  Pergunta.swift
//  QuizMeUp
//
//  Created by Simão Samouco on 07/03/2019.
//  Copyright © 2019 Simão Samouco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Pergunta: Codable{
    var category: String!
    var type: String!
    var difficulty: String!
    var question: String!
    var correctAnswer: String!
    var incorrectAnswers: [String] = []
    
    
  
     init(jsonRecebido: JSON) {
        //String(describing: Data(base64Encoded: jsonRecebido["category"].stringValue))
            self.category = jsonRecebido["category"].stringValue.fromBase64()
            self.type = jsonRecebido["type"].stringValue.fromBase64()
            self.difficulty = jsonRecebido["difficulty"].stringValue.fromBase64()
            self.question = jsonRecebido["question"].stringValue.fromBase64()
            self.correctAnswer = jsonRecebido["correct_answer"].stringValue.fromBase64()
            
            for incorrect in jsonRecebido["incorrect_answers"].arrayValue{
                incorrectAnswers.append(incorrect.stringValue.fromBase64()!)
            }
    }
    
     init(jsonFirebase: JSON) {
        //String(describing: Data(base64Encoded: jsonRecebido["category"].stringValue))
        self.category = jsonFirebase["category"].stringValue
        self.type = jsonFirebase["type"].stringValue
        self.difficulty = jsonFirebase["difficulty"].stringValue
        self.question = jsonFirebase["question"].stringValue
        self.correctAnswer = jsonFirebase["correctAnswer"].stringValue
        
        for incorrect in jsonFirebase["incorrectAnswers"].arrayValue{
            incorrectAnswers.append(incorrect.stringValue)
        }
    }
    
}

extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
