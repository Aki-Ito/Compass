//
//  AccountViewModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/27.
//

import Foundation
class AccountViewModel: ObservableObject{
    func fetchUserInfo() async throws -> Account?{
        let data = try await Account.fetchUser()
        return data ?? nil
    }
    
    func fetchImage() async throws -> Data?{
        let image = try await Account.fetchImage()
        return image ?? nil
    }
}
