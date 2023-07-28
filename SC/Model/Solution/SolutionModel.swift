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

public struct SolutionModel:Codable, Hashable, Identifiable, Equatable{
    @DocumentID public var id: String?
    var problem: String
    var solution: String
    var importance: Int
    var createdAt: Timestamp
}

extension SolutionModel{
    static func addSolution(solution: SolutionModel) async throws{
        do{
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            guard let user = user else {
                return
            }
            //MARK: use test account
            let solutionRef = db.collection("users").document(user.uid).collection("solutions")
            try solutionRef.addDocument(from: solution)
        }catch{
            throw error
        }
    }
    
    static func editSolution(id: String, problem: String, solution: String, importance: Int) async throws{
        do{
            let user = Auth.auth().currentUser
            let db = Firestore.firestore()
            guard let user = user else {
                return
            }
            let solutionRef = db.collection("users").document(user.uid).collection("solutions").document(id)
            let data = [
                "problem":problem,
                "solution":solution,
                "importance":importance
            ] as [String : Any]
            try await solutionRef.setData(data, merge: true)
        }catch{
            throw error
        }
    }
    
    static func deleteSolution(id: String) async throws{
        let user = Auth.auth().currentUser
        let db = Firestore.firestore()
        guard let user = user else {
            return
        }
        //MARK: delete account
        let solutionRef = db.collection("users").document(user.uid).collection("solutions").document(id)
        try await solutionRef.delete()
    }
    
    
    //MARK: use test account
    static func fetchSolution() async throws -> [SolutionModel]{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            guard let user = user else {
                return []
            }
            let solutionRef = db.collection("users").document(user.uid).collection("solutions")
            
            let querySnapshot = try await solutionRef.order(by: "createdAt", descending: true).getDocuments()
            let solutions = try querySnapshot.documents.map {
                try $0.data(as: SolutionModel.self)
            }
            
            return solutions
        }catch{
            throw error
        }
    }
    
    static func fetchFeaturedSolution() async throws -> [SolutionModel]{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            guard let user = user else {
                return []
            }
            let solutionRef = db.collection("users").document(user.uid).collection("solutions")
            
            let querySnapshot = try await solutionRef.order(by: "createdAt", descending: true).getDocuments()
            let solutions = try querySnapshot.documents.map {
                try $0.data(as: SolutionModel.self)
            }
            
            let filterdSolution = solutions.filter({ solution in
                solution.importance > 5
            })
            
            return filterdSolution
        }catch{
            throw error
        }
    }
    
    static func searchData(text: String) async throws -> [SolutionModel]{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            guard let user = user else {
                return []
            }
            let solutionRef = db.collection("users").document(user.uid).collection("solutions")
            
            let querySnapshot = try await solutionRef.order(by: "createdAt", descending: true).getDocuments()
            let solutions = try querySnapshot.documents.map {
                try $0.data(as: SolutionModel.self)
            }
            
            let filteredSolution = solutions.filter { solution in
                solution.problem.contains(text) || solution.solution.contains(text)
            }
            
            return filteredSolution
        }catch{
            throw error
        }
    }
}
