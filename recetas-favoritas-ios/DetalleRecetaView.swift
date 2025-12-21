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
            ScrollView{
                VStack(alignment: .leading, spacing: 16){
                    ZStack(alignment: .topTrailing){
                        
                        AsyncImage(url: URL(string: receta.strMealThumb)){ image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(height: 250)
                        .clipped()
                        
                        Button{
                            dismiss()
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(.white)
                                .shadow(radius: 3)
                        }
                        .padding()
                    }
                    
                    Text(receta.strMeal)
                        .font(.title)
                        .bold()
                        .padding(.horizontal)
                    
                    HStack(spacing: 12){
                
                        if let categoria = receta.strCategory {
                            HStack{
                                Image(systemName: "tag")
                                Text (categoria)
                            }
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(16)
                            
                        }
                            
                        
                        
                        if let pais = receta.strArea{
                            HStack{
                                Image( systemName: "globe")
                                Text(pais)
                            }
                            .font(.caption)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .foregroundColor(.blue)
                            .cornerRadius(16)
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    if let instrucciones = receta.strInstructions {
                        VStack{
                            Text("Instrucciones")
                                .font(.headline)
                                .fontWeight(.bold)
                                
                               
                            
                            Text(instrucciones)
                                .font(.body)
                                .lineSpacing(4)
                                
                            }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(12)
                        .padding(.horizontal)
                        
                        Spacer(minLength: 20)
                        
                    }
                    
                }
            }
        }
    
    
}
