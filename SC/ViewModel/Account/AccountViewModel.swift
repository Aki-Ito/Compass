//
//  AccountViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/27.
//

import Foundation
class AccountViewModel: ObservableObject{
    @Published var account: Account?
    @Published var image: Data?
    
    @MainActor
    func fetchUserInfo() async throws{
        let data = try await Account.fetchUser()
        self.account = data
    }
    
    @MainActor
    func fetchImage() async throws{
        let image = try await Account.fetchImage()
        self.image = image
    }
}
