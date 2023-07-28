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
    
    public func editUserInfo(userName: String) async throws{
        try await Account.editUser(userName: userName)
    }
    
    public func editImage(imageData: Data) async throws{
        try await Account.uploadImage(data: imageData)
    }
    
    @MainActor
    public func fetchUserInfo() async throws{
        let data = try await Account.fetchUser()
        self.account = data
    }
    
    @MainActor
    public func fetchImage() async throws{
        let image = try await Account.fetchImage()
        self.image = image
    }
    
    public func logOut() async throws{
        try await Account.logoutUser()
    }
    
    public func deleteUser() async throws{
        try await Account.deleteUser()
    }
}
