//
//  SolveQuizIntroView.swift
//  QuizUI
//
//  Created by AhnSangHoon on 2023/07/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

public struct SolveQuizIntroView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    
    @ObservedObject var viewModel: SolveQuizIntroViewModel = .init()
    @State private var networkErrorMessageToastModel: WQToast.Model?
    
    private let quizId: Int
    
    init(quizId: Int) {
        self.quizId = quizId
    }
    
    public var body: some View {
        NavigationStack(path: $solveQuizNavigator.path) {
            ZStack(alignment: .topTrailing) {
                Image(Icon.Home.fillGray)
                    .tint(.white)
                    .padding(.top, 16)
                    .padding(.trailing, 20)
                    .onTapGesture {
                        mainNavigator.dismissQuiz()
                    }
                VStack {
                    VStack(spacing: .zero) {
                        quizNumber()
                        Spacer()
                            .frame(height: 32)
                        title()
                        Spacer()
                            .frame(height: 32)
                    }
                    .padding(.horizontal, 20)
                    thumbnail()
                    Spacer()
                    WQButton(style: .single(
                        .init(
                            title: "시험 응시하기",
                            action: {
                                solveQuizNavigator.path.append(
                                    .input(quizId, viewModel.makeQuizModel()))
                            }
                        )
                    ))
                }
            }
            .fullScreenCover(
                isPresented: $viewModel.showErrorPage,
                content: {
                    RemovedQuizView()
                }
            )
            .toast(model: $networkErrorMessageToastModel)
            .background(
                WeQuizAsset.Assets.quizSolveBackground.swiftUIImage
            )
            .task {
                viewModel.loadQuiz(id: quizId)
            }
            .navigationDestination(for: SolveQuizScreen.self) { screen in
                switch screen {
                case let .input(id, model):
                    SolveQuizUserNameInputView(quizId: id, solveQuizModel: model)
                case let .solve(id, model, solver):
                    SolveQuizView(quizId: id, .init(model), solver: solver).configureView()
                }
            }
        }
    }
    
    private func quizNumber() -> some View {
        ZStack(alignment: .leading) {
            Color.clear
                .frame(height: 32)
            HStack {
                Text("제 \(viewModel.quizModel.quiz.id)회")
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.g3))
                    .padding(.horizontal, 16)
                    .padding(.vertical, 6)
                    .background(Color.designSystem(.g7))
                    .cornerRadius(16)
            }
        }
        .padding(.top, 46)
    }
    
    private func title() -> some View {
        VStack(spacing: 10) {
            Text(viewModel.quizModel.quiz.title)
                .multilineTextAlignment(.center)
                .font(.pretendard(.medium, size: ._20))
                .foregroundColor(.designSystem(.g4))
            VStack(spacing: .zero) {
                Text(viewModel.quizModel.quiz.creator.name)
                    .font(.pretendard(.bold, size: ._34))
                    .foregroundColor(.designSystem(.g1))
                Text("영역")
                    .font(.pretendard(.bold, size: ._28))
                    .foregroundColor(.designSystem(.g4))
            }
        }
    }
    
    private func thumbnail() -> some View {
        WeQuizAsset.Assets.quizSolveThumbnail.swiftUIImage
            .fixedSize()
    }
}
