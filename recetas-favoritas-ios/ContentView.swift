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
        NavigationStack{
            VStack {
                if !mensaje.isEmpty {
                    Text(mensaje)
                        .foregroundColor(.green)
                        .padding()
                }
                
                List {
                    ForEach(favoritos) {receta in
                        Text(receta.nombre)
                    }
                    .onDelete(perform: eliminar)
                }
                
                HStack {
                    Button("Agregar"){
                        agregar()
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button("Cargar"){
                        cargar()
                    }
                    .buttonStyle(.bordered)
                }
                .padding()
            }
            .navigationTitle("Mis Favoritos")
        }
    }
    func agregar(){
        Task{
            do{
                let receta = RecetaFavorita(
                    idMeal: "99999",
                    nombre: "Pollo al horno",
                    imagen: "https://cdn0.recetasgratis.net/es/posts/3/0/6/pollo_al_horno_peruano_73603_600.webp"
                )
                try await FirebaseService.shared.agregarFavorito(receta: receta)
                
                mensaje = "Receta agregada"
                
                cargar()
                
            }catch{
                mensaje = "Error: \(error.localizedDescription)"
            }
        }
        
    }
    func cargar(){
        Task {
            do{
                favoritos = try await FirebaseService.shared.obtenerFavoritos()
            }catch{
                mensaje = "Error al cargar"
            }
        }
    }
    func eliminar(at offsets: IndexSet){
        Task{
            for index in offsets {
                let receta = favoritos[index]
                do{
                    try await FirebaseService.shared.eliminarFavorito(id: receta.id)
                    mensaje = "Receta eliminada"
                }catch{
                    mensaje = "Error al eliminar"
                }
            }
            cargar()
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
