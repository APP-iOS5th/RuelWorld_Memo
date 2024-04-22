//
//  MemoAddView.swift
//  Mememo
//
//  Created by Chung Wussup on 4/22/24.
//

import SwiftUI

struct MemoAddView: View {
    
    let colors: [Color]
    
    @Binding var isSheetShowing: Bool
    @Binding var memoText: String
    @Binding var memoColor: Color
    
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        VStack {
            HStack {
                Button{
                    isSheetShowing = false
                } label: {
                    Text("취소")
                }
                
                Spacer()
                
                Button {
                    let newMemo = Memo(text: memoText)
                    addMemo(newMemo)
                    isSheetShowing = false
                } label: {
                    Text("완료")
                }
                .disabled(memoText.isEmpty)
            }
            
            HStack {
                ForEach(colors, id: \.self) { color in
                    Button {
                        memoColor = color
                    } label: {
                        HStack {
                            Spacer()
                            
                            if color == memoColor {
                                Image(systemName: "checkmark.circle")
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(color)
                        .shadow(radius: color == memoColor ? 8 : 0 )
                    }
                }
                
                
            }
            
            Divider()
                .padding()
            
            TextField("메모를 입력하세요", text: $memoText, axis: .vertical)
                .padding()
                .foregroundStyle(.white)
                .background(memoColor)
                .shadow(radius: 3)
            Spacer()
            
        }
        .padding()
        
    }
    
    func addMemo(_ memo: Memo) {
        modelContext.insert(memo)
    }
}

#Preview {
    MemoAddView(colors: [.blue, .cyan, .purple, .yellow, .indigo], isSheetShowing: .constant(true), memoText: .constant(""), memoColor: .constant(.blue))
}
