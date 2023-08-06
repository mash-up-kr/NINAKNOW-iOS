import SwiftUI

import DesignSystemKit

protocol HomeDisplayLogic {
    func displayMyInfo(viewModel: HomeResult.LoadMyInfo.ViewModel)
    func displayFriendRank(viewModel: HomeResult.LoadRanking.ViewModel)
    func displayQuizGroup(viewModel: HomeResult.LoadQuizGroup.ViewModel)
}

public struct HomeView: View {
    public init() { }
    
    var interactor: HomeBusinessLogic?
    
    @ObservedObject var viewModel: HomeDataStore = HomeDataStore(myInfo: MyInfoResponseModel(id: 0, image: "", nickname: "", contents: ""), quizs: [], friendsRank: [])
    @EnvironmentObject var navigator: HomeNavigator
    
    public var body: some View {
        NavigationStack(path: $navigator.path,  root: {
            VStack {
                self.topBarView
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 0) {
                        self.profileView
                        self.makeQuestionButton
                        self.friendRankView
                        self.myQuestionView
                    }
                    
                }
                .task {
                    interactor?.getQuizGroup(request: HomeResult.LoadQuizGroup.Request(quizGroupRequest: QuizGroupRequestModel(size: 15, cursor: nil)))
                }
                .navigationDestination(for: Screen.self) { type in
                    switch type {
                    case .friendRankView:
                        friendRankBuilder()
                    case .quizDetail(let quizId):
                        questionDetailBuilder(quizId: quizId)
                    case .quizGroupView:
                        questionGroupBuilder()
                    case .makeQuiz:
                        makeQuizBuilder()
                    case .quizCompletion(let quizId):
                        quizCompletionBuilder(quizId: quizId)
                    }
                }
            }
            .background(
                Color.designSystem(.g9)
            )
            .overlay(
                myQuestionBlankView
                    .padding([.leading, .trailing], 20)
                    .padding(.top, 26)
                , alignment: .center
            )
        })
    }
    
    
    private func friendRankBuilder() -> some View {
        FriendRankView(navigator: navigator, viewModel: FriendRankDataStore(result: viewModel.friendsRank))
            .configureView()
            .navigationBarBackButtonHidden()
    }
    
    private func questionGroupBuilder() -> some View {
        QuizGroupView(naivgator: navigator, viewModel: QuizGroupDataStore(quizs: viewModel.quizs))
            .configureView()
            .navigationBarBackButtonHidden()
    }
    
    private func questionDetailBuilder(quizId: Int) -> some View {
        QuizDetailView(viewModel: QuizDetailDataStore(quizInfo: QuizDetailViewModel(quizId: 0, quizTitle: "", questions: [])), navigator: navigator)
            .configureView(quizId: quizId)
            .navigationBarBackButtonHidden()
    }
    
    private func makeQuizBuilder() -> some View {
        MakeQuizView(navigator: navigator)
            .configureView()
            .navigationBarBackButtonHidden()
    }
    
    private func quizCompletionBuilder(quizId: Int) -> some View {
        QuizCompletionView(quizId: quizId, navigator: navigator)
            .navigationBarBackButtonHidden()
    }
}

extension HomeView {
    private var topBarView: some View {
        WQTopBar(style: .logo(.init(iconImage: WeQuizAsset.Assets.homeLogo.swiftUIImage)))
    }
    
    private var profileView: some View {
        let image = viewModel.myInfo.image != nil ? viewModel.myInfo.image : "profileImage"
        let nickname = viewModel.myInfo.nickname
        let contents = viewModel.myInfo.description
        
        return HStack {
            if let image = image {
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 85, height: 85)
            }
            
            VStack(alignment: .leading) {
                Text(nickname)
                    .font(.pretendard(.bold, size: ._18))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g2)
                    )
                    .padding(.bottom, 8)
                
                Text(contents)
                    .font(.pretendard(.medium, size: ._14))
                    .multilineTextAlignment(.leading)
                    .foregroundColor(
                        .designSystem(.g4)
                    )
            }
            .padding(.leading, 20)
            
            Spacer()
        }
        .padding([.leading, .trailing], 20)
        .padding([.top, .bottom], 11)
    }
    
    private var makeQuestionButton: some View {
        WQButton(
            style: .single(
                .init(
                    title: "문제만들기 💬",
                    action: {
                        navigator.path.append(.makeQuiz)
                    }
                )
            )
        )
    }
    
    private var friendRankBlankView: some View {
        let contents = "아직 랭킹이 없어요"
        
        return VStack {
            Text(contents)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.regular, size: ._14))
        }
    }
    
    private var friendRankList: some View {
        VStack(spacing: 12) {
            CustomHeader(title: "친구 랭킹")
                .onTapGesture {
                    navigator.path.append(.friendRankView)
                }
                .padding(.bottom, 12)
            
            ForEach($viewModel.friendsRank.prefix(3)) { friend in
                FriendRankRow(friend: friend)
            }
        }
    }
    
    @ViewBuilder
    private var myQuestionBlankView: some View {
        let image = "doc.plaintext"
        let contents = "아직 생성된 문제가 없어요"
        
        if viewModel.friendsRank.isEmpty && viewModel.quizs.isEmpty {
            VStack {
                Image(systemName: image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
                    .padding(.bottom, 12)
                Text(contents)
                    .foregroundColor(.designSystem(.g2))
                    .font(.pretendard(.regular, size: ._14))
            }
        } else {
            EmptyView()
        }
    }
    
    private var myQuestionList: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                CustomHeader(title: "내가 낸 시험지")
                    .onTapGesture {
                        navigator.path.append(.quizGroupView)
                    }
                    .padding(.bottom, 12)
                
                ForEach($viewModel.quizs.prefix(3)) { quiz in
                    ZStack {
                        QuizGroupRow(quiz: quiz)
                    }
                    .onTapGesture {
                        navigator.path.append(.quizDetail(quizId: quiz.id))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private var friendRankView: some View {
        if !$viewModel.friendsRank.isEmpty {
            friendRankList
                .padding([.leading, .trailing], 20)
                .padding(.top, 9)
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var myQuestionView: some View {
        if !$viewModel.quizs.isEmpty {
            myQuestionList
                .padding([.leading, .trailing], 20)
                .padding(.top, 26)
        } else {
            EmptyView()
        }
    }
}

struct CustomHeader: View {
    var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.designSystem(.g2))
                .font(.pretendard(.bold, size: ._20))
            Spacer()
            Image(Icon.Chevron.rightBig)
        }
        .buttonStyle(.plain)
    }
}

extension HomeView: HomeDisplayLogic {
    func displayMyInfo(viewModel: HomeResult.LoadMyInfo.ViewModel) {
        self.viewModel.myInfo = viewModel.myInfo
    }
    
    func displayFriendRank(viewModel: HomeResult.LoadRanking.ViewModel) {
        self.viewModel.friendsRank = viewModel.rank
    }
    
    func displayQuizGroup(viewModel: HomeResult.LoadQuizGroup.ViewModel) {
        self.viewModel.quizs = viewModel.quizs
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HomeNavigator.shared)
    }
}
