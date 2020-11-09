//
//  Flow.swift
//  QuizEngine
//
//  Created by zip520123 on 08/11/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
protocol Router {
    func routeTo(question: String, answerCallback: @escaping ((String)->Void))
}
class Flow {
    private let router: Router
    let questions: [String]
    init(questions:[String], router: Router){
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question){[weak self] answer in
                guard let self = self else {return}
                let nextQuestionIndex = self.questions.firstIndex(of: question)! + 1
    
                self.router.routeTo(question: self.questions[nextQuestionIndex]) {_ in}
                
            }
        }
    }
}
