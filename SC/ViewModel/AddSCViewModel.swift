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
    
    @Published var solutionModel: SolutionModel
    
    init(solutionModel: SolutionModel){
        self.solutionModel = solutionModel
    }
    
    func addSolution() async throws{
        try await solutionModel.addSolution(solution: self.solutionModel)
    }
}
