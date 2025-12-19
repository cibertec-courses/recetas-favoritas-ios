//
//  FavoritosView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 18/12/25.
//

import SwiftUI

struct FavoritosView: View{
    @State private var favoritos : [RecetaFavorita] = []
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(favoritos){receta in
                    HStack{
                        AsyncImage(url: URL(string: receta.imagen)){ image in
                            image.resizable().frame(width: 50, height:50)
                        } placeholder: {
                            ProgressView()
                        }
                        
                        Text(receta.nombre)
                    }
                }
                .onDelete(perform: eliminar)
            }
            .navigationTitle("Favoritos")
            .task{
                cargar()
            }
        }
    }
    func cargar(){
        Task{
            do{
                favoritos = try await FirebaseService.shared.obtenerFavoritos()
            }catch{
                print("Error")
            }
        }
    }
    func eliminar(at offsets: IndexSet){
        Task{
            for i in offsets {
                try? await FirebaseService.shared.eliminarFavorito(id: favoritos[i].id)
            }
            cargar()
        }
    }
    
}
