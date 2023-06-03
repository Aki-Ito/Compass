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
        do{
            let user = Auth.auth().currentUser
            let storage = Storage.storage().reference(forURL: "gs://selfcompass-de543.appspot.com")
            guard let uid = user?.uid else {return}
            
            let userRef =  storage.child("users").child("\(uid).jpg")
            _ = try await userRef.putDataAsync(data)
        }catch{
            throw error
        }
    }
    
    static func fetchUser() async throws{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            let storage = Storage.storage().reference(forURL: "gs://selfcompass-de543.appspot.com")
            
            //MARK: fetch from firestore
            guard let uid = user?.uid else {return}
            let accountRef = db.collection("users").document(uid)
            let documentSnapshot = try await accountRef.getDocument()
            let account = try documentSnapshot.data(as: Account.self)
            
            //MARK: fetch from Storage
            let userRef = storage.child("users").child(uid)
            let imageData = try await userRef.data(maxSize: 100)
        }catch{
            throw error
        }
    }
    
    static func deleteUser(password: String) async throws{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            guard let user = user else {return}
            guard let email = user.email else {return}
            let password = password
            //MARK: reauthenticate
            var credential : AuthCredential = EmailAuthProvider.credential(withEmail: email, password: password)
            try await user.reauthenticate(with: credential)
            //MARK: delete user
            try await user.delete()
        }catch{
            throw error
        }
    }
}
