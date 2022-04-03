//
//  ModelItem.swift
//  CellReuseIssue
//
//  Created by Fabio on 3/4/22.
//

import Foundation

class ModelItem: NSObject {
    public let id: String
    public let username: String
    public let content: String
    public let createdAt: Date
    
    internal init(id: String, username: String, content: String, createdAt: Date) {
        self.id = id
        self.username = username
        self.content = content
        self.createdAt = createdAt
    }
}
