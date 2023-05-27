//
//  AccountModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/05/27.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift
import FirebaseStorage
class Account: Codable,Identifiable{
    @DocumentID public var id: String?
    let userName: String
    let userUid: String
}

extension Account{
    static func saveUser(account: Account) async throws{
        do{
            let db = Firestore.firestore()
            let accountRef = db.collection("users")
            try accountRef.addDocument(from: account)
        }catch{
            throw error
        }
    }
    
    static func updateUser(data: Data) async throws{
        let user = Auth.auth().currentUser
        let storage = Storage.storage(url: "gs://selfcompass-de543.appspot.com")
        guard let uid = user?.uid else {return}
        
        let userRef =  storage.reference().child("users").child("\(uid).jpg")
        _ = try await userRef.putDataAsync(data)
    }
    
    static func fetchUser() async throws{
        do{
            
        }catch{
            throw error
        }
    }
    
    static func deleteUser() async throws{
        
    }
}
