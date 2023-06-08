//
//  AddCompassionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/08.
//

import SwiftUI

struct AddCompassionView: View {
    @ObservedObject var calendarViewModel = CalendarViewModel()
    @State var selfkindness: String = ""
    @State var commonHumanity: String = ""
    @State var mindfullness: String = ""
    
    var body: some View {
        NavigationStack{
            CompassionView()
                .navigationTitle("Add Compassion")
                .toolbar {
                    ToolbarItem {
                        Button("save") {
                            print("Save")
                        }
                    }
                }
        }
    }
    
    @ViewBuilder
    func CompassionView() -> some View{
        VStack{
            HStack{
                Text("Selfkindness")
                    .font(.title2)
                Text("write kind words to yourself")
                    .foregroundColor(.gray)
                Spacer()
            }
            TextEditor(text: $selfkindness)
                .scrollContentBackground(Visibility.hidden)
                .padding()
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
            
            HStack{
                Text("commonHumanity")
                    .font(.title2)
                Text("View suffering as common to all human beings")
                    .foregroundColor(.gray)
                    .padding(.top)
                Spacer()
            }
            
            TextEditor(text: $commonHumanity)
                .scrollContentBackground(Visibility.hidden)
                .padding()
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
            
            HStack{
                Text("mindfullness")
                    .font(.title2)
                Text("Observe negative emotions")
                    .foregroundColor(.gray)
                Spacer()
            }
            
            TextEditor(text: $mindfullness)
                .scrollContentBackground(Visibility.hidden)
                .padding()
                .frame(height: 150)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
        }.padding()
    }
}

struct AddCompassionView_Previews: PreviewProvider {
    static var previews: some View {
        AddCompassionView()
    }
}
