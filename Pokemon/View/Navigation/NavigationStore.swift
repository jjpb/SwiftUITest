//
//  NavigationStore.swift
//  Pokemon
//
//  Created by Jonathan Punongbayan on 8/17/26.
//

import SwiftUI

enum NavigationRoute: Hashable {
    case details(PokemonModel)
}

@Observable
class NavigationStore {
    var path: [NavigationRoute] = []
    
    func append(_ route: NavigationRoute) {
        path.append(route)
    }
    
    func navigateBack() {
        if !path.isEmpty {
            path.removeLast()
        }
    }
}
