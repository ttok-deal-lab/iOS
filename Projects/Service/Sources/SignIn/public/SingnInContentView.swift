//
//  SingnInContentView.swift
//  Service
//
//  Created by 최수훈 on 9/25/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture

public struct SignInContentView: View {
    // MARK: - private property
        // SignInFeature
    @State private var idString = ""
    @State private var pwString = ""

    // MARK: - internal property
    
    // MARK: - life cycle
    
    public init() { }
    
    public var body: some View {
        VStack {
            TextField("Put ID", text: $idString)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
            SecureField("Put PW", text: $pwString)
                .padding()
                .background(Color(uiColor: .secondarySystemBackground))
        }
    }
}

