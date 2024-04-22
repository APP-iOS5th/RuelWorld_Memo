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
    var stringColor: String
    var created: Date
    
    var createdString: String {
        get {
            let dateFormatter: DateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            return dateFormatter.string(from: created)
        }
    }
    var color: Color {
        Color(hex: stringColor)
    }
    
    init(id: UUID = UUID(), text: String, stringColor: String, created: Date = Date()) {
        self.id = id
        self.text = text
        self.stringColor = stringColor
        self.created = created
    }
}


struct ContentView: View {
    @Query var memos: [Memo]
    @Environment(\.modelContext) var modelContext
    @State var isSheetShowing: Bool = false
    
    let colors: [String] = ["0000ff", "d9ff00", "ff80ed", "ae86bc", "808080"]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(memos) { memo in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(memo.text)")
                                .font(.title)
                                .foregroundStyle(.black)
                            Text("\(memo.createdString)")
                                .font(.body)
                                .padding(.top)
                                .foregroundStyle(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    .foregroundStyle(.white)
                    .background(memo.color)
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
                MemoAddView(colors: colors, isSheetShowing: $isSheetShowing)
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
