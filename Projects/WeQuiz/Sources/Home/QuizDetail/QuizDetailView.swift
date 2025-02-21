//
//  QuestionDetailView.swift
//  HomeUI
//
//  Created by 최원석 on 2023/05/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

protocol QuizDetailDisplayLogic {
    func displayQuizDetail(viewModel: QuizDetailResult.LoadQuizDetail.ViewModel)
    func deleteQuiz(viewModel: QuizDetailResult.DeleteQuiz.ViewModel)
}

struct QuizDetailView: View {
        
    var interactor: QuizDetailBusinessLogic?
    @ObservedObject var viewModel: QuizDetailDataStore
    
    @State private var isPresentRemoveModal: Bool = false
    @State private var removeSuccessToastModal: WQToast.Model?
    @State var isSharePresented = false
    @State private var activityItems: [Any] = []

    private let navigator: HomeNavigator
    
    
    public init(viewModel: QuizDetailDataStore, navigator: HomeNavigator) {
        self.viewModel = viewModel
        self.navigator = navigator
    }
    
    var body: some View {
        VStack {
            topBarView
            questionList
        }
        .background(Color.designSystem(.g9))
        .modal(
            .init(
                message: "선택한 문제를 삭제할까요?",
                doubleButtonStyleModel: .init(
                    titles: ("아니오", "삭제"),
                    leftAction: {
                        isPresentRemoveModal = false
                    },
                    rightAction: {
                        isPresentRemoveModal = false
                        removeSuccessToastModal = .init(status: .success, text: "문제를 삭제했어요")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            interactor?.deleteQuiz(request: QuizDetailResult.DeleteQuiz.Request(deleteRequest: QuizDeleteRequestModel(quizId: viewModel.quizInfo.id)))
                        }
                    }
                )
            ),
            isPresented: $isPresentRemoveModal
        )
        .toast(model: $removeSuccessToastModal)
        .progressView(isPresented: $viewModel.isPresentProgressView)
        .background(
            ActivityView(
                isPresented: $isSharePresented,
                activityItems: activityItems
            )
        )
    }
}

extension QuizDetailView {
    private var topBarView: some View {
        
        return WQTopBar(style: .navigationWithButtons(
            .init(
                title: "",
                bttons: [
                    .init(icon: Icon.Share.fillGray, action: {
                        quizLink(id: viewModel.quizInfo.id)
                    })
                    ,
                    .init(icon: Icon.TrashCan.fillGray, action: {
                        isPresentRemoveModal = true
                    })
                ], action: {
                    navigator.back()
                }
            )
        ))
    }
    
    private func quizLink(id: Int) {
        DynamicLinks.makeDynamicLink(type: .solve(id: id)) {
            guard let url = $0 else { return }
            activityItems = ["친구가 만든 찐친고사에 도전해보세요!\n\n\(url)"]
            isSharePresented = true
        }
    }
    
    private var questionList: some View {
        ScrollView {
            LazyVStack(spacing: 36) {
                ForEach(viewModel.quizInfo.questions) { question in
                    AnswerListContainer(question: question, questionsCount: viewModel.quizInfo.questions.count, questionId: question.id)
                }
                .background(Color.designSystem(.g9))
            }
            .padding(.horizontal, 20)
            .background(Color.designSystem(.g9))
        }
    }
}

extension QuizDetailView: QuizDetailDisplayLogic {
    func displayQuizDetail(viewModel: QuizDetailResult.LoadQuizDetail.ViewModel) {
        self.viewModel.quizInfo = viewModel.quizDetail
        self.viewModel.isPresentProgressView = false
    }
    
    func deleteQuiz(viewModel: QuizDetailResult.DeleteQuiz.ViewModel) {
        navigator.back()
    }
}
