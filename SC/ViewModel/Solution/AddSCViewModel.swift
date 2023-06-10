//
//  AddSCViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/24.
//

import Foundation
import Combine
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class AddSCViewModel: ObservableObject{
    
    func addSolution(problem: String, solution: String, createAt: Date, importance: Int) async throws{
        let createAtTimeStamp: Timestamp = Timestamp(date: createAt)
        let contents = SolutionModel(problem: problem, solution: solution, importance: importance, createdAt: createAtTimeStamp)
        try await SolutionModel.addSolution(solution: contents)
    }
    
    func editSolution(problem: String, solution: String, importance: Int, id: String) async throws{
        try await SolutionModel.editSolution(id: id, problem: problem, solution: solution, importance: importance)
    }
    
}
