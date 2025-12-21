//
//  FavoritosView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 18/12/25.
//

import SwiftUI

struct FavoritosView: View{
    @State private var favoritos : [RecetaFavorita] = []
    @State private var recetaSeleccionada : Meal?
    @State private var cargandoDetalle = false
    
    var body: some View{
        NavigationStack{
            List{
                ForEach(favoritos){receta in
                    Button {
                        recetaSeleccionada = Meal(
                            idMeal: receta.idMeal,
                            strMeal: receta.nombre,
                            strMealThumb: receta.imagen,
                            strCategory: receta.categoria,
                            strArea: receta.pais,
                            strInstructions: receta.instrucciones
                        )
                
                    } label: {
                        HStack{
                            AsyncImage(url: URL(string: receta.imagen)){ image in
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                
                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height:  50)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            
                            Text(receta.nombre)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if cargandoDetalle {
                                ProgressView()
                            }
                        }
                    }
                }
                .onDelete(perform: eliminar)
            }
            .navigationTitle("Favoritos")
            .task{
                cargar()
            }
            .sheet(item: $recetaSeleccionada){receta in
                DetalleRecetaview(receta: receta)
                                    
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
