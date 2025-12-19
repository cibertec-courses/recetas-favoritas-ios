//
//  DetalleRecetaView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 18/12/25.
//

import SwiftUI

struct DetalleRecetaview: View {
    
    let receta: Meal
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View{
        NavigationStack{
            ScrollView{
                VStack(spacing: 16){
                    AsyncImage(url: URL(string: receta.strMealThumb)){ image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(height: 250)
                    .clipped()
                    
                    Text(receta.strMeal)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                }
            }
        }
        .navigationTitle("Detalle")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar{
            ToolbarItem(placement: .navigation){
                Button("Cerrar"){
                    dismiss()
                }
            }
        }
    }
    
}
