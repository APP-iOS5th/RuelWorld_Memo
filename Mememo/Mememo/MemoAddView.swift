//
//  MemoAddView.swift
//  Mememo
//
//  Created by Chung Wussup on 4/22/24.
//

import SwiftUI

struct MemoAddView: View {
    
    let colors: [String]
    
    @Binding var isSheetShowing: Bool
    @Binding var memoText: String
    @Binding var memoColor: String
    
    
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
                    let newMemo = Memo(text: memoText, stringColor: memoColor)
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
                            
                            if Color(hex:color) == Color(hex:memoColor) {
                                Image(systemName: "checkmark.circle")
                            }
                            
                            Spacer()
                        }
                        .padding()
                        .frame(height: 50)
                        .foregroundStyle(.white)
                        .background(Color(hex:color))
                        .shadow(radius: color == memoColor ? 8 : 0 )
                    }
                }
                
                
            }
            
            Divider()
                .padding()
            
            TextField("메모를 입력하세요", text: $memoText, axis: .vertical)
                .padding()
                .fontWeight(.bold)
                .foregroundStyle(.black)
                .background(Color(hex:memoColor))
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
    MemoAddView(colors:["0000ff", "d9ff00", "ff80ed", "ae86bc", "808080"], isSheetShowing: .constant(true), memoText: .constant(""), memoColor: .constant("0000ff"))
}
