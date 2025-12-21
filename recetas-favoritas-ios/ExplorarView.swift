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
    
    @State private var agregados: Set<String> = []
    
    @State private var recetaSeleccionada: Meal?
    
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
                cargarFavoritosExistentes()
            }
        }.fullScreenCover(item: $recetaSeleccionada){ receta in
            DetalleRecetaview(receta: receta)
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
                
                // Nombre de la receta
                Button{
                    recetaSeleccionada = receta
                } label: {
                    Text(receta.strMeal)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
              
                Spacer()
                
                Button {
                    agregarFavoritos(receta: receta)
                } label: {
                    Image(systemName: agregados.contains(receta.idMeal) ? "heart.fill" : "heart")
                        .foregroundColor(.red)
                    
                }
                .buttonStyle(.borderless)
                
                
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
    
    func agregarFavoritos(receta:Meal){
        
        if agregados.contains(receta.idMeal){
            return
        }
        
        agregados.insert(receta.id)
        
        Task{
            do{
                var categoria = ""
                var pais = ""
                var instrucciones = ""
                
                if let detalle = try await MealService.shared.obtenerRecetarPorId(id: receta.id){
                    categoria = detalle.strCategory ?? ""
                    pais = detalle.strArea ?? ""
                    instrucciones = detalle.strInstructions ?? ""
                }
                
                let favorita =  RecetaFavorita(
                    idMeal: receta.idMeal,
                    nombre: receta.strMeal,
                    imagen: receta.strMealThumb,
                    categoria: categoria,
                    pais: pais,
                    instrucciones: instrucciones
                    
                )
                try await FirebaseService.shared.agregarFavorito(receta: favorita)
            }catch{
                agregados.remove(receta.idMeal)
                print("Error al guardar: \(error)")
            }
        }
    }
    
    func cargarFavoritosExistentes(){
        Task{
            do {
                let favoritos = try await FirebaseService.shared.obtenerFavoritos()
                for fav in favoritos{
                    agregados.insert(fav.idMeal)
                }
                
                
            }catch{
                print("Error al cargar favoritos: \(error)")
            }
        }
    }
    
}
