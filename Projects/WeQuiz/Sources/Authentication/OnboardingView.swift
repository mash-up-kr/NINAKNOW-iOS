import SwiftUI

import DesignSystemKit

public struct OnboardingView: View {
    @EnvironmentObject var navigator: AuthenticationNavigator
    @State private var signedOutToastModel: WQToast.Model?
    
    private let authManager: AuthManager = .shared

    public init() {}
    
    public var body: some View {
        NavigationStack(path: $navigator.path) {
            VStack {
                Spacer()
                WeQuizAsset.Assets.authenticationOnboardingLogo.swiftUIImage
                Spacer()
                WQButton(
                    style: .single(
                        .init(
                            title: "시작하기",
                            action: {
                                navigator.path.append(.phoneNumber(.signUp))
                            }
                        )
                    )
                )
                HStack {
                    Text("이미 계정이 있나요?")
                        .font(.pretendard(.regular, size: ._14))
                        .foregroundColor(.designSystem(.g2))
                    Button("로그인") {
                        navigator.path.append(.phoneNumber(.signIn))
                    }
                    .font(.pretendard(.bold, size: ._14))
                    .foregroundColor(.designSystem(.p1))
                }
            }
            .background(
                WeQuizAsset.Assets.authenticationOnboardingBackground.swiftUIImage
            )
            .navigationDestination(for: AuthenticationScreen.self) { type in
                switch type {
                case .phoneNumber(let signType):
                    phoneNumberInputBuilder(signType)
                        .navigationBarBackButtonHidden()
                case let .verificationCodeInput(phoneNumber, signType):
                    verificationCodeInputBuilder(phoneNumber, signType)
                        .navigationBarBackButtonHidden()
                case let .userInformationInput(phoneNumber):
                    userInformationInputBuilder(phoneNumber)
                        .navigationBarBackButtonHidden()
                case .signUpFinsh(let nickname):
                    SignUpFinishView(navigator: navigator, nickname: nickname)
                        .navigationBarBackButtonHidden()
                }
            }
            .onAppear {
                if authManager.signedOut {
                    authManager.signedOut = false
                    DispatchQueue.main.async {
                        signedOutToastModel = .init(status: .success, text: "로그아웃 되었습니다")
                    }
                }
                
                if authManager.withdrawal {
                    authManager.withdrawal = false
                    DispatchQueue.main.async {
                        signedOutToastModel = .init(status: .success, text: "회원탈퇴 되었습니다")
                    }
                }
            }
            .toast(model: $signedOutToastModel)
        }
    }
    
    private func phoneNumberInputBuilder(_ signType: AuthenticationScreen.SignType) -> PhoneNumberInputView {
        let presenter = PhoneNumberInputPresenter(navigator: navigator)
        let interactor = PhoneNumberInputInteractor(
            presenter: presenter,
            authManager: authManager
        )
        return PhoneNumberInputView(
            interactor: interactor,
            presenter: presenter,
            signType
        )
    }
    
    private func verificationCodeInputBuilder(
        _ phoneNumber: String,
        _ signType: AuthenticationScreen.SignType
    ) -> VerificationCodeInputView {
        let presenter = VerificationCodeInputPresenter(navigator: navigator)
        let interactor = VerificationCodeInputInteractor(
            presenter: presenter,
            authManager: authManager,
            authenticationService: AuthenticationService()
        )
        return VerificationCodeInputView(
            interactor: interactor,
            presenter: presenter,
            phoneNumber: phoneNumber,
            signType
        )
    }
    
    private func userInformationInputBuilder(_ phoneNumber: String) -> UserInformationInputView {
        let presenter = UserInformationInputPresenter(navigator: navigator)
        let interactor = UserInformationInputInteractor(
            presenter: presenter,
            authManager: authManager,
            authenticationService: AuthenticationService()
        )
        return UserInformationInputView(
            interactor: interactor,
            presenter: presenter,
            phoneNumber: phoneNumber
        )
    }
}

struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
