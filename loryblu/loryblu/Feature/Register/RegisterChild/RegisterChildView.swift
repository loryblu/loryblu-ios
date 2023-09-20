//
//  RegisterChildView.swift
//  LoryBlu
//
//  Created by Suh on 31/07/23.
//

import SwiftUI

struct RegisterChildView: View {
    @ObservedObject var viewModel: RegisterChildViewModel
    @FocusState private var focusedField: RegisterChildViewModel.FocusedField?
    @State var presented: Bool = false
    @State var date: Date?
    var child: Register?
    @State var goToLogin: Bool = false

    var body: some View {
        NavigationStack {
            VStack {
                VStack {
                    Image(LBIcon.logo.rawValue).resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 187, height: 47)
                        .clipped()
                        .padding(.bottom, 40)

                    Text(LBStrings.Register.child)
                        .font(LBFont.head6)
                        .foregroundColor(LBColor.text)
                        .frame(width: 194, alignment: .topLeading)
                        .padding(.bottom, 32)
                }

                form

            }
            .navigationTitle(LBStrings.General.vazia)
            .padding(.top, -40)
            .navigationDestination(isPresented: $goToLogin) {
                LoginView()
                    .toolbarRole(.editor)
            }
        }

    }

    var form: some View {
        VStack(spacing: 18) {
            VStack(spacing: 16) {
                LBTextField(
                    style: .common,
                    icon: LBIcon.user,
                    title: LBStrings.Register.name,
                    text: $viewModel.nameChild,
                    textFiledState: viewModel.errorField == .nameChild ? .alert : .active
                )
                .focused($focusedField, equals: .nameChild)
                .onChange(of: viewModel.nameChild) { _ in
                    viewModel.clearError()
                }

                LBTextField(
                    style: .date,
                    icon: LBIcon.cake,
                    title: LBStrings.Register.birthDay,
                    text: $viewModel.birthDay,
                    textFiledState: viewModel.errorField == .birthDay ? .alert : .active
                )
                .focused($focusedField, equals: .birthDay)
                .onChange(of: viewModel.birthDay) { _ in
                    viewModel.clearError()
                }

                HStack(spacing: 15) {
                    LBGenderButton(gender: .male, isActive: viewModel.gender == .male) {
                        viewModel.gender = .male
                    }

                    LBGenderButton(gender: .female, isActive: viewModel.gender == .female) {
                        viewModel.gender = .female
                    }
                }
                .focused($focusedField, equals: .gender)
                .onChange(of: viewModel.gender) { _ in
                    viewModel.clearError()
                }

                HStack {
                    Spacer()
                    LBToggle(isActived: $viewModel.agreePrivacy)

                    Text(LBStrings.Register.agree)
                        .foregroundColor(LBColor.text)
                        .font(LBFont.caption)
                        .multilineTextAlignment(.trailing)
                }

                if viewModel.hasError {
                    HStack {
                        Spacer()
                        Text(viewModel.textError)
                            .foregroundColor(LBColor.error)
                            .font(LBFont.caption)
                            .multilineTextAlignment(.trailing)
                    }
                }

                LBButton(
                    title: LBStrings.Register.buttonRegister,
                    style: !viewModel.agreePrivacy ? .primaryOff : .primaryActivated
                ) {
                    self.viewModel.showError()
//                    self.viewModel.loadUser()
                    self.viewModel.saveRegister()

//                    if ValidateRules.validateName(viewModel.nameChild) && !self.viewModel.birthDay.isEmpty {
//                        self.viewModel.saveRegister()
//                    } else {
//                        // messege error
//                    }
//                    self.goToLogin = true
                }
                .disabled(!viewModel.agreePrivacy)
                .padding(.top, 40)

            }.padding([.leading, .trailing], 26)
        }
    }

}

struct RegisterChildView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterChildView(viewModel: RegisterChildViewModel(user: Register()))
    }
}
