//
//  recetas_favoritas_iosApp.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import SwiftUI
import FirebaseCore

@main
struct recetas_favoritas_iosApp: App {
    
    init(){
        FirebaseApp.configure()
        print("Firebase Inicializado correctamente")
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
