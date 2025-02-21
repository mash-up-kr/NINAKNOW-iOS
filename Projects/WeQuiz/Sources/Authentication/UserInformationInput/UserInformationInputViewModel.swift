//
//  UserInformationInputViewModel.swift
//  AuthenticationKit
//
//  Created by AhnSangHoon on 2023/07/23.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import Foundation

public struct UserInformationInputViewModel {
    public var toastModel: UserInformationInputModel.Response.Toast.`Type` = .none
    public var progress: Bool = false
    
    public static let `default`: UserInformationInputViewModel = .init()
}
