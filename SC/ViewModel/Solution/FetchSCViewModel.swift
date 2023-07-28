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
    
    @MainActor
   public func fetchSolutions() async throws{
        let solutions = try await SolutionModel.fetchSolution()
        self.solutions = solutions
    }
    
    @MainActor
   public func fetchFeaturedSolutions() async throws{
        let featuredSolutions = try await SolutionModel.fetchFeaturedSolution()
        self.solutions = featuredSolutions
    }
    
    @MainActor
   public func fetchExploredSolutions(text: String) async throws{
        if text.isEmpty{
            self.solutions = try await SolutionModel.fetchFeaturedSolution()
        }else{
            self.solutions = try await SolutionModel.searchData(text: text)
        }
    }
}


