//
//  ContentView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var favoritos: [RecetaFavorita] = []
    
    @State private var estaLogueado = AuthService.shared.estaLogueado
    
    @State private var mensaje = ""
    
    var body: some View {
        if estaLogueado{
            
            TabView{
                ExplorarView()
                    .tabItem{
                        Image(systemName: "magnifyingglass")
                        Text("Explorar")
                    }
                
                FavoritosView()
                    .tabItem{
                        Image(systemName: "heart.fill")
                        Text("Favoritos")
                    }
                
                PerfilView (estaLogueado: $estaLogueado)
                    .tabItem{
                        Image(systemName:"person.fill")
                        Text("Perfil")
                    }
                
            }
        }else{
            LoginView(estaLogueado: $estaLogueado)
        }
    }
  
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
