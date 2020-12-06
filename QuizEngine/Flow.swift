//
//  Flow.swift
//  QuizEngine
//
//  Created by zip520123 on 08/11/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
protocol Router {
    associatedtype Question: Hashable
    associatedtype Answer
    
    func routeTo(question: Question, answerCallback: @escaping (Answer) -> Void)
    func routeTo(result: [Question:Answer])
}
class Flow <Question, Answer, R: Router> where R.Question == Question, R.Answer == Answer {
    private let router: R
    private let questions: [Question]
    private var result: [Question: Answer] = [:]
    init(questions:[Question], router: R){
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
    
    private func routeNext(from question:Question) -> (Answer) -> Void {
        return { [weak self] in
            self?.routeNext(question, $0)
            
        }
    }
    
    private func routeNext(_ question: Question,_ answer: Answer) {
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
