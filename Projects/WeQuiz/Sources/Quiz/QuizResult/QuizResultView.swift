//
//  QuizResultView.swift
//  Quiz
//
//  Created by 박소현 on 2023/07/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

protocol QuizResultDisplayLogic {
    func displayRanking(viewModel: QuizResult.LoadRanking.ViewModel)
}

public struct QuizResultView: View {
    @EnvironmentObject var mainNavigator: MainNavigator
    @EnvironmentObject var solveQuizNavigator: SolveQuizNavigator
    var interactor: QuizResultBusinessLogic?
    
    @ObservedObject var model: QuizResultDataStore
    @State private var isSharePresented = false
    @State private var activityItem: [Any] = []
    
    public init(quizId: Int,_ quizResult: QuizResultModel) {
        self.model = QuizResultDataStore()
        self.model.quizId = quizId
        self.model.result = quizResult
    }
    
    public var body: some View {
        ZStack(alignment: .topTrailing) {
            ScrollView(.vertical) {
                VStack {
                    VStack(alignment: .center, spacing: 20) {
                        if let result = model.result {
                            socreView(result.myScore)
                            descriptionView(me: result.myNickname, friend: result.friendNickname, description: result.scoreDescription)
                        }
                    }

                    Image(model.result?.resultImage ?? "quizResult_5")
                        .resizable()
                        .aspectRatio(1.0, contentMode: .fit)

                    rankingView()
                        .hidden(model.result?.ranking == nil)
                }
            }
            .padding(.top, 58)
            .padding(.bottom, 128)
            .disabled(model.result?.ranking == nil)

            VStack {
                topBar()

                Spacer()

                VStack(spacing: 22) {
                    tooltip()
                        .padding(.vertical, 7)
                        .padding(.horizontal, 21)
                        .frame(height: 38)
                        .background(Color.designSystem(.g8))
                        .cornerRadius(19)

                    WQButton(style: .double(WQButton.Style.DobuleButtonStyleModel(
                        titles: (leftTitle: "다시 풀기", rightTitle: "결과 공유하기"),
                        leftAction: {
                            solveQuizNavigator.popToroot()
                        },
                        rightAction: {
                            guard let quizId = model.quizId else { return }
                            resultLink(id: quizId)
                        }
                    )))
                    .background(
                        ActivityView(
                            isPresented: $isSharePresented,
                            activityItems: activityItem
                        )
                    )
                }
            }
        }
        .background(Color.designSystem(.g9))
        .task {
            if let quizId = model.quizId {
                interactor?.requestRanking(request: .init(quizId: quizId))
            }
        }
    }
}

extension QuizResultView: QuizResultDisplayLogic {
    func displayRanking(viewModel: QuizResult.LoadRanking.ViewModel) {
        self.model.result?.ranking = viewModel.rank
    }
}

extension QuizResultView {
    private func socreView(_ score: Int) -> some View {
        HStack(alignment: .center, spacing: 6) {
            // TODO: - size 68로 수정
            Text("\(score)")
                .foregroundStyle(DesignSystemKit.Gradient.gradientS1.linearGradient)
                .font(.pretendard(.bold, size: ._48))
                .frame(height: 54)
            Text("점")
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._18))
                .frame(height: 26)
        }
    }

    private func descriptionView(me: String, friend: String, description: String) -> some View {
        VStack(alignment: .center, spacing: 0) {
            Text("\(me) & \(friend)")
                .foregroundColor(Color.designSystem(.g4))
                .font(.pretendard(.regular, size: ._18))
                .frame(height: 26)

            Text(description)
                .foregroundColor(Color.designSystem(.g1))
                .font(.pretendard(.bold, size: ._28))
                .frame(height: 38)
        }
    }

    private func tooltip() -> some View {
        Text("1분만에 가입해서 친구한테 문제내기 🗯️")
            .foregroundColor(Color.designSystem(.g3))
            .font(.pretendard(.bold, size: ._16))
            .frame(height: 24)
    }

    private func rankingView() -> some View {
        VStack {
            Rectangle()
                .fill(Color.designSystem(.g7))
                .frame(height: 8)

            if let ranking = model.result?.ranking {
                ForEach(ranking, id: \.rank) { user in
                    QuizResultRankView(user)
                }
                .padding(.horizontal, 20)
            }
        }
    }

    private func topBar() -> some View {
        HStack {
            Spacer()

            Image(Icon.Home.fillGray)
                .resizable()
                .frame(width: 24, height: 24)
                .padding(.trailing, 20)
                .onTapGesture {
                    solveQuizNavigator.popToroot()
                    mainNavigator.dismissQuiz()
                }
        }
        .frame(height: 56)
        .background(Color.designSystem(.g9))
    }
    
    private func resultLink(id: Int) {
        DynamicLinks.makeDynamicLink(type: .result(id: id)) {
            guard let url = $0 else { return }
            activityItem = [url]
            isSharePresented = true
        }
    }
}
