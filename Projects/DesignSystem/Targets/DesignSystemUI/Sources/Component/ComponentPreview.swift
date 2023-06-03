//
//  ComponentPreview.swift
//  DesignSystemUI
//
//  Created by AhnSangHoon on 2023/06/03.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI

import DesignSystemKit

struct ComponentPreview: View {
    var body: some View {
        ScrollView {
            WQButtonPreview()
        }
        .navigationTitle("Component")
        .padding()
    }
}
