//
//  RegisterChildView.swift
//  LoryBlu
//
//  Created by Suh on 31/07/23.
//

import SwiftUI

struct RegisterChildView: View {
    @ObservedObject var viewModel: RegisterChildViewModel
    @State var agreePrivacy: Bool = false
    @State var presented: Bool = false
    @State var date: Date?
    var child: Register?

    var body: some View {
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

        }.padding(.top, -40)
    }

    var form: some View {
        VStack(spacing: 18) {
            VStack(spacing: 16) {
                LBTextField(
                    style: .common,
                    icon: LBIcon.user,
                    title: LBStrings.Register.name,
                    text: $viewModel.nameChild,
                    textFiledState: .active
                )

                LBTextField(
                    style: .date,
                    icon: LBIcon.cake,
                    title: LBStrings.Register.birthDay,
                    text: $viewModel.birthDay,
                    textFiledState: .active
                )

                HStack(spacing: 15) {
                    LBGenderButton(gender: .male, isActive: viewModel.gender == .male) {
                        viewModel.gender = .male
                    }

                    LBGenderButton(gender: .female, isActive: viewModel.gender == .female) {
                        viewModel.gender = .female
                    }
                }

                HStack {
                    Spacer()
                    LBToggle(isActived: $agreePrivacy)

                    Text(LBStrings.Register.agree)
                        .foregroundColor(LBColor.text)
                        .font(LBFont.caption)
                        .multilineTextAlignment(.trailing)
                }

                LBButton(
                    title: LBStrings.Register.buttonRegister,
                    style: !agreePrivacy ? .primaryOff : .primaryActivated
                ) {

                    if ValidateRules.validateName(viewModel.nameChild) && !self.viewModel.birthDay.isEmpty {
                        self.viewModel.saveRegister()
                    } else {
                    }

                }
                .disabled(!agreePrivacy)
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
