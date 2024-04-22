//
//  ContentView.swift
//  Memo1
//
//  Created by 황민경 on 4/22/24.
//
import Foundation
import SwiftUI
import SwiftData

@Model
class Memo: Identifiable {
    var id: UUID = UUID()
    var text: String
    var color: Color
    var created: Date
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
    
    init(id: UUID = UUID(), text: String, color: Color, created: Date) {
        self.id = id
        self.text = text
        self.color = color
        self.created = created
    }
}



struct ContentView: View {
    @Query var memos: [Memo]
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
    }
    func addMemo (_text: String, color: Color){
        let memo: Memo = Memo(text: text, color: color, created: Date())
        memos.insert(memo, at: 0)
    }
    func removeMemo(_ targetMemo: Memo) {
        if let index = memos.firstIndex(where: {$0.id == targetMemo.id}) {
            memos.remove(at: index)
        }
    }
}

#Preview {
    ContentView()
}
