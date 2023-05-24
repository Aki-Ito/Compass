//
//  SolutionModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

public struct SolutionModel:Codable, Identifiable{
    @DocumentID public var id: String?
    var problem: String
    var solution: String
    var importance: Int
    var createdAt: Timestamp
}

extension SolutionModel{
    static func addSolution(solution: SolutionModel) async throws{
        do{
            //            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            //            guard let user = user else {
            //                return
            //            }
            //MARK: use test account
            let solutionRef = db.collection("users").document("BqfIaUDFrmTW5otiSOA9USKgplK2").collection("solutions")
            try solutionRef.addDocument(from: solution)
        }catch{
            throw error
        }
    }
}
