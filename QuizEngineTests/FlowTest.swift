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
    func test_start_withNoQuestions_doseNotRouteToQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:[], router: router)
        
        sut.start()
        XCTAssert(router.routedQuestions.isEmpty)
    }
    
    
    func test_start_withOneQuestions_routesToCorrectQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1"], router: router)
        
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_withOneQuestions_routesToCorrectQuestion_2(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q2"], router: router)
        
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q2"])
    }
    
    func test_start_withTwoQuestions_routesToFirstQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"], router: router)
        
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1"])
    }
    
    func test_start_twice_withTwoQuestions_routesToFirstQuestionTwice(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"], router: router)

        sut.start()
        sut.start()
        XCTAssertEqual(router.routedQuestions, ["Q1","Q1"])
    }
    
    func test_startAndAnswerFirstQuestions_withTwoQuestions_routesToSecondQuestion(){
        let router = RouterSpy()
        let sut = Flow(questions:["Q1","Q2"], router: router)
        
        
        sut.start()
        router.answerCallback("A1")
        
        XCTAssertEqual(router.routedQuestions, ["Q1","Q2"])
    }
    
    class RouterSpy: Router {
        
        var routedQuestions: [String] = []
        var answerCallback: ((String)->Void) = {_ in}
        func routeTo(question: String, answerCallback: @escaping ((String) -> Void)){
            
            routedQuestions.append(question)
            self.answerCallback = answerCallback
        }
    }
}

