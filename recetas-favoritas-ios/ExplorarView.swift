//
//  ExplorarView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import SwiftUI

struct ExplorarView: View {
    
    @State private var estado: ViewState = .loading
    
    @State private var recetas: [Meal] = []
    
    @State private var busquedad = ""
    
    var body: some View {
        NavigationStack{
            Group{
                switch estado {
                case .loading:
                    ProgressView("Cargando recetas...")
                case .success:
                    listaRecetas
                case .error(let mensaje):
                    VStack{
                        Image(systemName: "wifi.slash")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                        
                        Text(mensaje)
                            .foregroundColor(.red)
                        
                        Button("Reintentar"){
                            cargarRecetas()
                        }
                            .buttonStyle(.bordered)
                    }
                }
            }
            .navigationTitle("Explorar")
            .task {
                cargarRecetas()
            }
        }
    }
    
    var listaRecetas : some View{
        List(recetas){ receta in
            HStack(spacing: 12){
                AsyncImage(url: URL(string: receta.strMealThumb)){ image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 60, height: 60)
                .clipShape(RoundedRectangle(cornerRadius: 8))
                
                Text(receta.strMeal)
                    .font(.headline)
                
                
            }
            
        }
        .refreshable {
            cargarRecetas()
        }
    }
    func cargarRecetas(){
        Task {
            estado = .loading
            do{
                recetas = try await MealService.shared.buscarRecetas(nombre: "chicken")
                estado = .success
            }catch{
                estado = .error("Error: \(error.localizedDescription)")
            }
        }
    }
}
