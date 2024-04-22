//
//  ContentView.swift
//  Mememo
//
//  Created by Chung Wussup on 4/22/24.
//

import SwiftUI
import SwiftData


@Model
class Memo {
    var id: UUID
    var text: String
    //    var color: String
    var created: Date
    
    init(id: UUID = UUID(), text: String, /*color: String,*/ created: Date = Date()) {
        self.id = id
        self.text = text
        //        self.color = color
        self.created = created
    }
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
}


struct ContentView: View {
    @Query var memos: [Memo]
    
    @Environment(\.modelContext) var modelContext
    @State var isSheetShowing: Bool = false
    @State var memoText: String = ""
    @State var memoColor: Color = .blue
    
    let colors: [Color] = [.blue, .cyan, .purple, .yellow, .indigo]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memos) { memo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(memo.text)")
                                .font(.title)
                            Text("\(memo.createdString)")
                                .font(.body)
                                .padding(.top)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(.purple)
                    .shadow(radius: 3)
                    .padding()
                    .contextMenu {
                        ShareLink(item: memo.text)
                        Button {
                            removeMemo(memo)
                        } label:  {
                            Image(systemName: "trash.slash")
                            Text("삭제")
                        }
                        
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("MeMeMo")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        isSheetShowing = true
                    } label : {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $isSheetShowing) {
                MemoAddView(colors: colors, isSheetShowing: $isSheetShowing, memoText: $memoText, memoColor: $memoColor)
                
                    
            }
        }
        
        
    }
    
    func removeMemo(_ memo: Memo) {
        modelContext.delete(memo)
    }

}

#Preview {
    ContentView()
        .modelContainer(for: Memo.self)
}
