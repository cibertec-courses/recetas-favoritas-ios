//
//  PerfilView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 21/12/25.
//

import SwiftUI

struct PerfilView: View{
    @Binding  var estaLogueado: Bool
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 30){
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                
                if let email = AuthService.shared.usuarioActual?.email{
                    Text(email)
                        .font(.headline)
                }
                Spacer()
                Button{
                    cerrarSesion()
                }label: {
                    HStack {
                        Image(systemName: "rectangle.portait.and.arrow.right")
                        Text("Cerrar Sesion")
                    }
                    .frame(width: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                .padding()
                
            }
            .padding()
            .navigationTitle("Mi Perfil")
        }
        
        
    }
    func cerrarSesion(){
        
    }
    
}
