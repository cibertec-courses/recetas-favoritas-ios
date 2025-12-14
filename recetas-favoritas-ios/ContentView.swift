//
//  ContentView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var favoritos: [RecetaFavorita] = []
    
    @State private var mensaje = ""
    
    var body: some View {
        TabView{
            ExplorarView()
                .tabItem{
                    Image(systemName: "magnifyingglass")
                    Text("Explorar")
                }
        }
    }
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
