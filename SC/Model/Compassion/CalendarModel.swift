//
//  CalendarModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/08.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct CalendarModel: Codable,Identifiable{
    @DocumentID public var id: String?
    var selfkindness: String
    var commonHumanity: String
    var mindfullness: String
    var createdAt: Timestamp?
}

extension CalendarModel{
    static func addData(data: CalendarModel) async throws{
        do{
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let compassionRef = db.collection("users").document(uid).collection("diaries")
            try compassionRef.addDocument(from: data)
        }catch{
            throw error
        }
    }
    
    static func fetchData(createdAt: DateComponents) async throws -> [CalendarModel]?{
        do{
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {return nil}
            guard let createdAt = createdAt.date else {return nil}
            let compassionRef = db.collection("users").document(uid).collection("diaries")
            
            let fetchedData = try await compassionRef.whereField("createdAt", isEqualTo: Timestamp(date: createdAt)).getDocuments()
            let mappedData = try fetchedData.documents.map{
                try $0.data(as: CalendarModel.self)
            }
            
            return mappedData
        }catch{
            throw error
        }
    }
}
