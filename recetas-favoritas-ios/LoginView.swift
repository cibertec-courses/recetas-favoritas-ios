//
//  LoginView.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 21/12/25.
//

import SwiftUI

struct LoginView: View{
    @State private var email = ""
    @State private var password = ""
    
    @State private var mensaje =  ""
    @State private var cargando = false
    
    
    @Binding var estaLogueado : Bool
    
    var body: some View{
        NavigationStack{
            VStack(spacing: 20 ){
                Image(systemName: "fork.knife.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                
                Text("Recetas Favoritas")
                    .font(.title)
                    .bold()
                
                TextField("Email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Contrasena", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                if !mensaje.isEmpty{
                    Text(mensaje)
                        .foregroundColor(.red)
                        .font(.caption)
                }
                
                Button{
                    login()
                } label: {
                    if cargando {
                        ProgressView()
                    }else {
                        Text("Iniciar Sesion")
                            .frame(width: .infinity)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(cargando)
                
                Button{
                    registrar()
                }label: {
                    Text("Crear cuenta nueva")
                        .frame(width: .infinity)
                }
                .buttonStyle(.bordered)
                .disabled(cargando)
                Spacer()
            }
            .padding()
            .navigationTitle("Bievenido")
        }
    }
    
    func login(){
        guard !email.isEmpty, !password.isEmpty else{
            mensaje = "Completa todos los campos"
            return
        }
        cargando = true
        mensaje = ""
        
        Task{
            do{
                try await AuthService.shared.login(email: email, password: password)
            }catch{
                mensaje = "Error: \(error.localizedDescription)"
            }
            cargando = false
        }
        
        
    }
    
    func registrar(){
        guard !email.isEmpty, !password.isEmpty else{
            mensaje = "Completa todos los campos"
            return
        }
        
        cargando = true
        mensaje = ""
        
        Task{
            do{
                try await AuthService.shared.registrar(email: email, password: password)
                estaLogueado = true
            }catch{
                mensaje = "Error: \(error.localizedDescription)"
                
            }
            cargando = false
        }
        
    }
    
}
