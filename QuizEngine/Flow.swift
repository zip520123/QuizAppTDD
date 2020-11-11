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
    func routeTo(result: [String:String])
}
class Flow {
    private let router: Router
    private let questions: [String]
    private var result: [String: String] = [:]
    init(questions:[String], router: Router){
        self.router = router
        self.questions = questions
    }
    
    func start() {
        if let question = questions.first {
            router.routeTo(question: question, answerCallback: routeNext(from: question))
        } else {
            router.routeTo(result: [:])
        }
        
    }
    
    private func routeNext(from question:String) -> Router.AnswerCallback {
        return { [weak self] in
            self?.routeNext(question, $0)
            
        }
    }
    
    private func routeNext(_ question: String,_ answer: String) {
        if let currentQuestionIndex = questions.firstIndex(of: question) {
            result[question] = answer
            let nextIndex = currentQuestionIndex + 1
            if nextIndex < questions.count {
                let nextQuestion = questions[nextIndex]
                router.routeTo(question: nextQuestion, answerCallback: routeNext(from: nextQuestion))
                
            } else {
                router.routeTo(result: result)
            }
            
        }
    }
}
