//
//  AppCoordinatorView.swift
//  MercuryApp
//
//  Created by 송하민 on 8/30/24.
//

import Map
import SwiftUI
import Foundation
import AppFoundation
import ComposableArchitecture

struct AppFeatureView: View {

  @Perception.Bindable var store: StoreOf<AppFeature>
  
  var body: some View {
    WithPerceptionTracking {
      NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
        Button {
          store.send(.navigateToMap)
        } label: {
          Text("goto map")
        }
      } destination: { store in
        SwitchStore(store) { state in
          switch state {
          case .map:
            CaseLet(/AppFeature.Path.State.map, action: AppFeature.Path.Action.map) { store in
              WithPerceptionTracking {
                MapContentView(store: store)
              }
            }
          }
        }
      }
    }
  }
}
