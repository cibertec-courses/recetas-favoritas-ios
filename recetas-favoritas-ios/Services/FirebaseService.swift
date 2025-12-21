//
//  FirebaseService.swift
//  recetas-favoritas-ios
//
//  Created by DamII on 14/12/25.
//

import Foundation
import FirebaseFirestore

class FirebaseService{
    static let shared =  FirebaseService()
    
    private let db = Firestore.firestore()
    
    private let collection = "favoritos"
    
    private init(){}
    
    
    func agregarFavorito ( receta: RecetaFavorita) async throws {
        let datos = [
            "idMeal": receta.idMeal,
            "nombre": receta.nombre,
            "imagen": receta.imagen,
            "categoria": receta.categoria,
            "pais": receta.pais,
            "instrucciones": receta.instrucciones,
            "fechaAgregada": Timestamp(date: receta.fechaAgregada)
        ] as [String: Any]
        
        try await db.collection(collection).addDocument(data: datos)
        
    }
    
    func obtenerFavoritos() async throws  -> [RecetaFavorita]{
        let snapshot = try await db.collection(collection).getDocuments()
        var favoritos: [RecetaFavorita] = []
        
        for doc in snapshot.documents {
            let data = doc.data()
            
            if let idMeal = data["idMeal"] as? String,
               let nombre = data["nombre"] as? String,
               let imagen = data["imagen"] as? String,
               let timestanp = data ["fechaAgregada"] as? Timestamp {
                let receta = RecetaFavorita(
                    id: doc.documentID,
                    idMeal: idMeal,
                    nombre: nombre,
                    imagen: imagen,
                    categoria: data["categroia"] as? String ?? "",
                    pais: data["pais"] as? String ?? "",
                    instrucciones: data["instrucciones"] as? String ?? "",
                    fechaAgregada: timestanp.dateValue()
                )
                favoritos.append(receta)
            }
            
        }
        return favoritos
    }
    
    func eliminarFavorito(id: String) async throws {
        try await db.collection(collection).document(id).delete()
    }

    func existeEnFavoritos(idMeal: String) async throws -> Bool {
        let snapshot = try await db.collection(collection)
            .whereField("idMeal", isEqualTo: idMeal)
            .getDocuments()
        
        return !snapshot.documents.isEmpty
    }
}
