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
import AuthenticationServices

class Account: Codable,Identifiable{
    @DocumentID public var id: String?
    var userName: String
    var userUid: String
    var appleIDToken: String
    var nonce: String
}

extension Account{
    static func saveUser(userName:String, userUid: String, appleIDToken: String,nonce: String) async throws{
        do{
            let db = Firestore.firestore()
            guard let uid = Auth.auth().currentUser?.uid else {return}
            let accountRef = db.collection("users").document(uid)
            let data = [
                "userName": userName,
                "userUid": userUid,
                "appleIDToken": appleIDToken,
                "nonce": nonce
            ] as [String : Any]
            try await accountRef.setData(data, merge: true)
        }catch{
            throw error
        }
    }
    
    static func uploadImage(data: Data) async throws{
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
    
    static func fetchUser() async throws -> Account?{
        do{
            let db = Firestore.firestore()
            let user = Auth.auth().currentUser
            //MARK: fetch from firestore
            guard let uid = user?.uid else {return nil}
            let accountRef = db.collection("users").document(uid)
            let documentSnapshot = try await accountRef.getDocument()
            let account = try documentSnapshot.data(as: Account.self)
            return account
        }catch{
            throw error
        }
    }
    
    static func fetchImage() async throws -> Data?{
        do{
            let storage = Storage.storage().reference(forURL: "gs://selfcompass-de543.appspot.com")
            //MARK: fetch from Storage
            let user = Auth.auth().currentUser
            guard let uid = user?.uid else {return nil}
            let userRef = storage.child("users").child(uid)
            let imageData = try await userRef.data(maxSize: 100)
            return imageData
        }catch{
            throw error
        }
    }
    
    static func deleteUser(password: String) async throws{
        do{
            let user = Auth.auth().currentUser
            guard let user = user else {return}
            let db = Firestore.firestore()
            let accountRef = db.collection("users").document(user.uid)
            let account = try await accountRef.getDocument()
            let convertedAccount = try account.data(as: Account.self)
            //MARK: reauthenticate
            let credential = OAuthProvider.credential(
              withProviderID: "apple.com",
              idToken: convertedAccount.appleIDToken,
              rawNonce: convertedAccount.nonce
            )
            try await user.reauthenticate(with: credential)
            //MARK: delete user
            
        }catch{
            throw error
        }
    }
    
    static func logoutUser() async throws{
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }
    }
}
