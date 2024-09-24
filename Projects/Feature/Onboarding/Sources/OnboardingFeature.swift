//
//  OnboardingFeature.swift
//  Onboarding
//
//  Created by 송하민 on 9/16/24.
//

import Foundation
import SwiftUI
import ComposableArchitecture
import AppFoundation
import Service

public enum SignInType {
  case apple
  case google
}

@Reducer
public struct OnboardingFeature {
  
  @ObservableState
  public struct State: Equatable {
    public var error: MercuryError?
    public init() { }
  }
  
  public enum Action {
    case signIn(SignInType)
    case setError(MercuryError)
    case trySignIn(SignInToken)
  }
  
  // MARK: - private property
  
  @Dependency(\.signInClient) private var signInClient
  
  
  // MARK: - life cycle
  
  public init() {
    
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .signIn(let signInType):
        switch signInType {
        case .apple:
          return .run { send in
            if let result = await signInClient.appleSignIn() {
              switch result {
              case .success(let signInToken):
                await send(.trySignIn(signInToken))
              case .failure(let error):
                await send(.setError(error))
              }
            }
          }
        case .google:
          return .run { send in
            if let result = await signInClient.googleSignIn() {
              switch result {
              case .success(let signInToken):
                print(signInToken)
                await send(.trySignIn(signInToken))
              case .failure(let error):
                await send(.setError(error))
              }
            }
          }
        }
      case .setError(let error):
        state.error = error
        return .none
      case .trySignIn(let token):
        
        return .none
      }
    }
  }
}
