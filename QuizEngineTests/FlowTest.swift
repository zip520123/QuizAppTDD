//
//  FlowTest.swift
//  QuizEngineTests
//
//  Created by zip520123 on 08/11/2020.
//  Copyright © 2020 zip520123. All rights reserved.
//

import Foundation
import XCTest
@testable import QuizEngine
class FlowTest: XCTestCase {
    let router = RouterSpy()
    func test_start_withNoQuestions_doseNotRouteToQuestion(){
        makeSUT(questions: []).start()
        XCTAssert(router.routedQuestions.isEmpty)
    }
    
    
    func test_start_withOneQuestions_routesToCorrectQuestion(){
        makeSUT(questions: ["Q1"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion_2(){
        
        makeSUT(questions:["Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion(){
        
        makeSUT(questions:["Q1","Q2"]).start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_twice_withTwoQuestions_routesToFirstQuestionTwice(){
        let sut = makeSUT(questions:["Q1","Q2"])
        
        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstAndSecendQuestion_withThreeQuestions_routesToSecondAndThirdQuestion(){
        let sut = makeSUT(questions:["Q1","Q2", "Q3"])
        
        sut.start()
        router.answerCallback("A1")
        router.answerCallback("A2")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2","Q3"])
    }
    
    func test_startAndAnswerFirstQuestion_withOneQuestion_doesnotRouteToAntherQuestion(){
        let sut = makeSUT(questions:["Q1"])
        
        sut.start()
        router.answerCallback("A1")
        
        
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    //MARK: helpers
    func makeSUT(questions:[String]) -> Flow {
        return Flow(questions: questions, router: router)
    }
    
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var answerCallback: Router.AnswerCallback = {_ in}
        func routeTo(question: String, answerCallback: @escaping Router.AnswerCallback){
            
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}

