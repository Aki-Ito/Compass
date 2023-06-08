//
//  CalendarModel.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/08.
//

import Foundation
import FirebaseAuth
import FirebaseFirestoreSwift
class CalendarModel: Codable,Identifiable{
    @DocumentID public var id: String?
    var selfkindness: String = ""
    var commonHumanity: String = ""
    var mindfullness: String = ""
}

extension CalendarModel{
    static func addData(){
        
    }
    
    static func fetchData(){
        
    }
}
