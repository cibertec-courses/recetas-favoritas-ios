//
//  AuthService.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 21/12/25.
//

import Foundation
import FirebaseAuth


class AuthService{
    static let shared = AuthService()
    private init(){
        
    }
    
    var usuarioActual: User? {
        return Auth.auth().currentUser
    }
    
    var estaLogueado : Bool{
        return usuarioActual != nil
    }
    
    func registrar(email:String, password: String) async throws{
        try await Auth.auth().createUser(withEmail: email, password: password)
        
    }
    
    func login(email: String, password: String) async throws {
        try await Auth.auth().signIn(withEmail: email, password: password)
    }
    
    func logout() throws {
        try Auth.auth().signOut()
    }
    
    
}
