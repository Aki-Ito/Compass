//
//  AddCompassionView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/08.
//

import SwiftUI

struct AddCompassionView: View {
    @ObservedObject var keyboard = KeyboardObserver()
    @ObservedObject var calendarViewModel: CalendarViewModel = .init()
    @State var selfkindness: String = ""
    @State var commonHumanity: String = ""
    @State var mindfullness: String = ""
    
    @State var textState: CompassionEnum = .selfkindness
    
    @State var editText: String = ""
    @State private var showingAlert = false
    @FocusState var focus: Bool
    let dateComponents: DateComponents
    
    var body: some View {
        NavigationStack{
            ZStack {
                //MARK: backgroundView
                LinearGradient(colors: [Color( "BG1"),Color("BG2")], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                CompassionView()
                    .padding()
                    .toolbar {
                        ToolbarItem {
                            Button("save") {
                                if textState == .selfkindness{
                                    selfkindness = editText
                                }else if textState == .commonHumanity{
                                    commonHumanity = editText
                                }else if textState == .mindfullness{
                                    mindfullness = editText
                                }
                                self.showingAlert = true
                            }
                            .alert(isPresented: $showingAlert) {
                                Alert(title: Text("Save?"),dismissButton: .default(Text("OK"),action: {
                                    Task{
                                        try await calendarViewModel.addDiary(selfkindness:selfkindness,commonHumanity:commonHumanity,mindfullness:mindfullness,date: dateComponents.date! )
                                        
                                    }
                                }))
                            }
                        }
                    }
            }
        }.onAppear{
            Task{
                let data = try await calendarViewModel.fetchDiary(createdAt: dateComponents)
                self.selfkindness = data?.selfkindness ?? ""
                self.commonHumanity = data?.commonHumanity ?? ""
                self.mindfullness = data?.mindfullness ?? ""
                
                self.editText = selfkindness
            }
        }
    }
    
    @ViewBuilder
    func CompassionView() -> some View{
        VStack{
            HStack {
                VStack {
                    Button {
                        if textState == .selfkindness{
                            selfkindness = editText
                        }else if textState == .commonHumanity{
                            commonHumanity = editText
                        }else if textState == .mindfullness{
                            mindfullness = editText
                        }
                        textState = .selfkindness
                        editText = selfkindness
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .opacity(0.5)
                                .background(
                                    Color.white.opacity(0.08)
                                        .blur(radius: 10)
                                )
                                .frame(width: 80, height: 80)
                                .shadow(color: Color("CirclePink1"),radius: textState == .selfkindness ? 10 : 0)
                            
                            Image("heart")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFit()
                            
                        }
                    }
                    
                    Text("selfkindness")
                        .font(.caption)
                }.padding()
                VStack {
                    Button {
                        if textState == .selfkindness{
                            selfkindness = editText
                        }else if textState == .commonHumanity{
                            commonHumanity = editText
                        }else if textState == .mindfullness{
                            mindfullness = editText
                        }
                        textState = .commonHumanity
                        editText = commonHumanity
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .opacity(0.5)
                                .background(
                                    Color.white.opacity(0.08)
                                        .blur(radius: 10)
                                )
                                .frame(width: 80, height: 80)
                                .shadow(color: Color("CirclePink1"),radius: textState == .commonHumanity ? 10 : 0)
                            
                            Image("circle")
                                .resizable()
                                .frame(width: 80, height: 80)
                                .scaledToFit()
                        }
                    }

                    Text("commonality")
                        .font(.caption)
                }.padding()
                
                VStack{
                    Button {
                        if textState == .selfkindness{
                            selfkindness = editText
                        }else if textState == .commonHumanity{
                            commonHumanity = editText
                        }else if textState == .mindfullness{
                            mindfullness = editText
                        }
                        textState = .mindfullness
                        editText = mindfullness
                    } label: {
                        ZStack{
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                                .opacity(0.5)
                                .background(
                                    Color.white.opacity(0.08)
                                        .blur(radius: 10)
                                )
                                .frame(width: 80, height: 80)
                                .shadow(color: Color("CirclePink1"), radius: textState == .mindfullness ? 10 : 0)
                            Image("mindfullness")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .scaledToFit()
                        }
                    }

                    Text("mindfulness")
                        .font(.caption)
                }.padding()
            }
            TextEditor(text: $editText)
                .scrollContentBackground(Visibility.hidden)
                .padding()
                .frame(height: 400)
                .background(RoundedRectangle(cornerRadius: 10).stroke(
                    Color("CirclePink1")
                ))
        }
    }
    
    //    @ViewBuilder
    //    func CompassionView() -> some View{
    //        VStack{
    //            HStack{
    //                Text("Selfkindness")
    //                    .font(.title2)
    //                Spacer()
    //            }
    //            TextEditor(text: $selfkindness)
    //                .scrollContentBackground(Visibility.hidden)
    //                .padding()
    //                .frame(height: 150)
    //                .background(RoundedRectangle(cornerRadius: 10).stroke(
    //                    Color("CirclePink1")
    //                ))
    //                .focused(self.$focus)
    //                .toolbar{
    //                    ToolbarItem(placement: .keyboard){
    //                        HStack{
    //                            Spacer()
    //                            Button("Close"){
    //                                self.focus = false
    //                            }
    //                            .foregroundColor(Color("CirclePink1"))
    //                        }
    //                    }
    //                }
    //
    //            HStack{
    //                Text("commonHumanity")
    //                    .font(.title3)
    //                Spacer()
    //            }
    //
    //            TextEditor(text: $commonHumanity)
    //                .scrollContentBackground(Visibility.hidden)
    //                .padding()
    //                .frame(height: 150)
    //                .background(RoundedRectangle(cornerRadius: 10).stroke(
    //                    Color("CirclePink1")
    //                ))
    //                .focused(self.$focus)
    //                .toolbar{
    //                    ToolbarItem(placement: .keyboard){
    //                        HStack{
    //                            Spacer()
    //                            Button("Close"){
    //                                self.focus = false
    //                            }
    //                            .foregroundColor(Color("CirclePink1"))
    //                        }
    //                    }
    //                }
    //
    //            HStack{
    //                Text("mindfullness")
    //                    .font(.title2)
    //                Spacer()
    //            }
    //
    //            TextEditor(text: $mindfullness)
    //                .scrollContentBackground(Visibility.hidden)
    //                .padding()
    //                .frame(height: 150)
    //                .background(RoundedRectangle(cornerRadius: 10).stroke(
    //                    Color("CirclePink1")
    //                ))
    //                .focused(self.$focus)
    //                .toolbar{
    //                    ToolbarItem(placement: .keyboard){
    //                        HStack{
    //                            Spacer()
    //                            Button("Close"){
    //                                self.focus = false
    //                            }
    //                            .foregroundColor(Color("CirclePink1"))
    //                        }
    //                    }
    //                }
    //        }.padding()
    //    }
}

struct AddCompassionView_Previews: PreviewProvider {
    static var previews: some View {
        AddCompassionView( dateComponents:  DateComponents(year: 2022, month: 7, day: 1, hour: 10, minute: 30))
    }
}
