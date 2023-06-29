//
//  MultipleSelectionView.swift
//  QuizUI
//
//  Created by 박소현 on 2023/06/29.
//  Copyright © 2023 ommaya.io. All rights reserved.
//

import SwiftUI
import DesignSystemKit

public struct MultipleSelectionView: View {
    
    @State var isSelected: Bool = false
    
    public var body: some View {
        HStack(spacing: 8) {
            Image(isSelected ? Icon.Checkmark.trueFill20 : Icon.Checkmark.falseLine20)
            Text("중복 선택여부")
                .font(.pretendard(.semibold, size: ._16))
                .foregroundColor(.designSystem(.g2))
        }
        .frame(height: 20)
        .onTapGesture {
            isSelected.toggle()
        }
    }
}
 
struct MultipleSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionView()
    }
}
