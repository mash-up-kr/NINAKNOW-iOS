//
//  SolveQuizUserNameInputView.swift
//  QuizUI
//
//  Created by AhnSangHoon on 2023/07/04.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizUserNameInputView: View {
    @State private var userNameInput: String = ""
    @State private var isUserNameValid: Bool = false
    
    public init() { }
    
    public var body: some View {
        VStack {
            VStack(spacing: .zero) {
                title()
                Spacer()
                    .frame(height: 42)
                nameInput()
                Spacer()
            }
            .padding(.horizontal, 20)
            VStack(spacing: 16) {
                tooltip()
                WQButton(style: .single(
                    .init(
                        title: "완료",
                        action: {
                            print("완료 버튼 눌림")
                        }
                    )
                ))
            }
        }
    }
    
    private func title() -> some View {
        HStack {
            Text("친구가 알 수 있게\n본인의 이름을 적어주세요")
                .font(.pretendard(.bold, size: ._24))
                .foregroundColor(.gray)
            Spacer()
        }
        .padding(.top, 76)
    }
    
    private func nameInput() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 4) {
                Text("이름")
                    .font(.pretendard(.medium, size: ._12))
                    .foregroundColor(.designSystem(.g2))
                Text("(필수)")
                    .font(.pretendard(.regular, size: ._12))
                    .foregroundColor(.designSystem(.alert))
            }
            WQInputField(style: .limitCharacter(
                .init(
                    input: $userNameInput,
                    isValid: $isUserNameValid,
                    placeholder: "이름 입력",
                    limit: 8,
                    condition: { input in
                        input < 8
                    })
            ))
        }
    }
    
    private func tooltip() -> some View {
        Text("1분만에 가입해서 친구한테 문제내기 🗯️️")
            .font(.pretendard(.bold, size: ._16))
            .foregroundColor(.designSystem(.g3))
            .padding(.horizontal, 21)
            .padding(.vertical, 7)
            .background(Color.designSystem(.g8))
            .cornerRadius(19)
            .onTapGesture {
                print("툴팁 터치")
            }
    }
}

struct SolveQuizUserNameInputView_Previews: PreviewProvider {
    static var previews: some View {
        SolveQuizUserNameInputView()
    }
}
