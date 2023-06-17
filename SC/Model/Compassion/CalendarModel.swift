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
    static let helper = DateFormatHelper.shared
    
    static func addData(selfkindness: String, commonHumanity:String, mindfullness: String,createdAt: Timestamp) async throws{
        do{
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let formatDate = helper.dateFormat(date: createdAt.dateValue())
            let compassionRef = db.collection("users").document(uid).collection("diaries").document(formatDate)
            let data = [
                "selfkindness": selfkindness,
                "commonHumanity": commonHumanity,
                "mindfullness": mindfullness,
                "createdAt": createdAt
            ] as [String : Any]
            try await compassionRef.setData(data, merge: true)
        }catch{
            throw error
        }
    }
    
    static func fetchData(createdAt: DateComponents) async throws -> CalendarModel?{
        do{
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {return nil}
            guard let createdAt = createdAt.date else {return nil}
            let compassionRef = db.collection("users").document(uid).collection("diaries").document(helper.dateFormat(date: createdAt))
            
            let fetchedData = try await compassionRef.getDocument()
            
            let mappedData = try fetchedData.data(as: CalendarModel.self)
            return mappedData
        }catch{
            throw error
        }
    }
}
