//
//  EditAccountView.swift
//  SC
//
//  Created by 伊藤明孝 on 2023/06/11.
//

import SwiftUI

struct EditAccountView: View {
    @State var showingImagePicker = false
    @State private var showingAlert = false
    @State private var showingLogoutAlert = false
    @State private var showingDeleteAlert = false
    @State private var isShowLogInView = false
    @State var showingIndicator = true
    
    @State private var image: UIImage?
    @State var text: String = ""
    
    @ObservedObject var viewModel = AccountViewModel()
    @ObservedObject private var signInWithAppleObject = SignInWithAppleRepository()
    
    var body: some View {
        NavigationStack{
            ZStack{
                SCBackgroundView()
                VStack {
                    HStack{
                        Button {
                            showingImagePicker = true
                        } label: {
                            if image == nil{
                                if viewModel.image != nil{
                                    Image(uiImage: UIImage(data: viewModel.image!)!)
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .background{
                                            Circle().stroke(
                                                Color("CirclePink1")
                                            )
                                        }.padding()
                                }else{
                                    Image("")
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: 60, height: 60)
                                        .clipShape(Circle())
                                        .background{
                                            Circle().stroke(
                                                Color("CirclePink1")
                                            )
                                        }.padding()
                                }
                            }else{
                                Image(uiImage: image!)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 60, height: 60)
                                    .clipShape(Circle())
                                    .background{
                                        Circle().stroke(
                                            Color("CirclePink1")
                                        )
                                    }
                            }
                        }
                        .sheet(isPresented: $showingImagePicker) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                        }
                        
                        
                        TextField("username", text: $text)
                            .frame(height: 50)
                            .background {
                                RoundedRectangle(cornerRadius: 15, style: .continuous)
                                    .fill(Color.white.opacity(0.2))
                            }
                            .padding()
                    }.padding()
                    
                    Form{
                        Text("logout")
                            .listRowBackground(Color.white.opacity(0.2))
                            .onTapGesture {
                                self.showingLogoutAlert = true
                            }
                            .alert(isPresented: $showingLogoutAlert) {
                                Alert(title: Text("logout?"),primaryButton:.cancel(Text("cancel").foregroundColor(Color("CirclePink1"))),secondaryButton: .destructive(Text("OK"),action: {
                                    //MARK: access viewModel
                                    self.isShowLogInView = true
                                }))
                            }
                            .fullScreenCover(isPresented: $isShowLogInView) {
                                SignInView()
                            }
                        
                        Text("delete account")
                            .foregroundColor(.red)
                            .listRowBackground(Color.white.opacity(0.2))
                            .onTapGesture {
                                self.showingDeleteAlert = true
                            }
                            .alert(isPresented: $showingDeleteAlert) {
                                Alert(title: Text("delete?"),message:Text("A pop-up will appear and you will be asked to log in. The user will then be deleted.") ,primaryButton:.cancel(Text("cancel").foregroundColor(Color("CirclePink1"))     ),secondaryButton: .destructive(Text("OK"),action: {
                                    //MARK: access viewModel
                                    Task{
                                        signInWithAppleObject.deleteCurrentUser()
                                    }
                                }))
                            }
                            .fullScreenCover(isPresented: $signInWithAppleObject.isShow) {
                                SignInView()
                            }
                    }
                    .background(.clear)
                    .scrollContentBackground(.hidden)
                }
                .navigationTitle("Account")
                .toolbar {
                    ToolbarItem {
                        Button("save") {
                            self.showingAlert = true
                        }
                        .alert(isPresented: $showingAlert) {
                            Alert(title: Text("Save?"),dismissButton: .default(Text("OK"),action: {
                                Task{
                                    try await viewModel.editUserInfo(userName: text)
                                    if image != nil{
                                        try await viewModel.editImage(imageData: image!.jpegData(compressionQuality: 0.2)!)
                                    }
                                }
                            }))
                        }
                    }
                }
                if showingIndicator {
                    ActivityIndicatorHelper()
                }
            }
        }
        .onAppear{
            Task{
                self.showingIndicator.toggle()
                do{
                    try await viewModel.fetchImage()
                    try await viewModel.fetchUserInfo()
                    self.text = viewModel.account?.userName ?? ""
                }catch{
                    print("error")
                }
                self.showingIndicator = false
            }
        }
        
        
        
        
    }
}

struct EditAccountView_Previews: PreviewProvider {
    static var previews: some View {
        EditAccountView()
    }
}
