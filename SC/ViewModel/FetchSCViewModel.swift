//
//  FetchSCViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/25.
//

import Foundation
import Combine
class FetchSCViewModel: ObservableObject{
    @Published var solutions: [SolutionModel] = []
    
    func fetchSolutions() async throws{
       let solutions = try await SolutionModel.fetchSolution()
        self.solutions = solutions
    }
}


