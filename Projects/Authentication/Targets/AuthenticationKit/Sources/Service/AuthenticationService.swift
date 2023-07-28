//
//  AuthenticationService.swift
//  Authentication
//
//  Created by AhnSangHoon on 2023/07/28.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

import CoreKit

public protocol AuthenticationServiceLogic {
    func join(_ model: JoinRequestModel, _ completion: @escaping ((Result<Void, AuthenticationAPIError>)) -> Void)
    @MainActor func user(_ id: String) async -> UserResponseModel?
}

public final class AuthenticationService {
    private let networking: NetworkingProtocol
    
    public init(networking: NetworkingProtocol = Networking()) {
        self.networking = networking
    }
}

extension AuthenticationService: AuthenticationServiceLogic {
    public func join(_ model: JoinRequestModel, _ completion: @escaping ((Result<Void, AuthenticationAPIError>)) -> Void) {
        networking.request(EmptyResponseModel.self, AuthenticationAPI.join(model)) { result in
            switch result {
            case .success:
                completion(.success(Void()))
            case .failure:
                completion(.failure(.fail))
            }
        }
    }
    
    public func user(_ id: String) async -> UserResponseModel? {
        switch await networking.request(UserResponseModel.self, AuthenticationAPI.user(id)) {
        case .success(let model):
            return model
        case .failure:
            return nil
        }
    }
}
