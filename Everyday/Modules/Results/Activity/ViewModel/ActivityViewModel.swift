//
//  ActivityViewModel.swift
//  Everyday
//
//  Created by Alexander on 20.05.2024.
//

import SwiftUI
import Firebase
import FirebaseFirestore

class ActivityViewModel: ObservableObject {
    @Published var contributionData: Set<Date> = []
    
    private var db = Firestore.firestore()
    
    init() {
        fetchContributionData()
    }
    
    func fetchContributionData() {
        guard let userUID = Auth.auth().currentUser?.uid else {
            return
        }
        let collectionRef = db.collection("user")
        let documentRef = collectionRef.document(userUID)
        
        documentRef.getDocument { [weak self] (document, error) in
            if let error = error {
                print("Error fetching document: \(error)")
                return
            }
            
            guard let data = document?.data(), let history = data["history"] as? [[String: Any]] else {
                print("Document data was empty or malformed.")
                return
            }
            
            var dates = Set<Date>()
            for contribution in history {
                if let timestamp = contribution["date"] as? Timestamp {
                    let date = timestamp.dateValue()
                    dates.insert(Calendar.current.startOfDay(for: date))
                }
            }
            
            DispatchQueue.main.async {
                self?.contributionData = dates
            }
        }
    }
}
