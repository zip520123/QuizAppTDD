//
//  Flow.swift
//  QuizEngine
//
//  Created by zip520123 on 08/11/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
protocol Router {
    typealias AnswerCallback = (String) -> Void
    func routeTo(question: String, answerCallback: @escaping AnswerCallback)
}
class Flow {
    private let router: Router
    private let questions: [String]
    init(questions:[String], router: Router){
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question, answerCallback: routeNext(from: question))
        }
    }
    
    private func routeNext(from question:String) -> Router.AnswerCallback {
        return { [weak self] _ in
            guard let self = self else {return}
            if let currentQuestionIndex = self.questions.firstIndex(of: question) {
                if currentQuestionIndex + 1 < self.questions.count {
                    let nextQuestion = self.questions[currentQuestionIndex + 1]
                    self.router.routeTo(question: nextQuestion, answerCallback: self.routeNext(from: nextQuestion))
                    
                }
            }
            
            
        }
    }
}
