//
//  InputAnswerView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit
import QuizKit

public struct InputAnswerView: View {
    
    let index: Int
    @Binding var answer: AnswerModel
    
    var isCorrectAnswer: ((Bool) -> ())?
    
    public init(index: Int, answer: Binding<AnswerModel>, isCorrectAnswer: ((Bool) -> ())?) {
        self.index = index
        self._answer = answer
        self.isCorrectAnswer = isCorrectAnswer
    }
    
    public var body: some View {
        HStack {
            ZStack {
                Image(Icon.Checkmark.falseFill24)
                    .hidden(!$answer.isCorrect.wrappedValue)
                
                AlphabetCircleView(answerNumber: index)
                    .hidden($answer.isCorrect.wrappedValue)
            }
            .onTapGesture {
                $answer.isCorrect.wrappedValue.toggle()
                isCorrectAnswer?($answer.isCorrect.wrappedValue)
            }
            
            Spacer()

            TextField("", text: $answer.answer, prompt: Text("답변 입력")
                    .foregroundColor(
                        Color.designSystem(.g4)
                    )
                )
                .font(.pretendard(.medium, size: ._16))
                .foregroundColor(
                    $answer.isCorrect.wrappedValue ? Color.designSystem(.g2) : Color.designSystem(.g4)
                )
        }
        .padding(.all, 16)
        .background(
            $answer.isCorrect.wrappedValue ? Color.designSystem(.p1) : Color.designSystem(.g7)
        )
        .cornerRadius(16)
        
    }
}

struct InputAnswerView_Previews: PreviewProvider {
    static var previews: some View {
        InputAnswerView(index: 0, answer: .constant(AnswerModel.init(answer: "", isCorrect: false)), isCorrectAnswer: nil)
    }
}
