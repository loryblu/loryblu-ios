//
//  RegisterChildView.swift
//  LoryBlu
//
//  Created by Suh on 31/07/23.
//

import SwiftUI

struct RegisterChildView: View {
    @State var name: String = ""
    @State var birthDay: String = ""
    @State var agreePrivacy: Bool = false
    @State var gender: LBGenderButton.Gender?

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
            LBTextField(
                style: .common,
                icon: LBIcon.user,
                title: LBStrings.Register.name,
                text: $name,
                textFiledState: .active
            )

            LBTextField(
                style: .common,
                icon: LBIcon.cake,
                title: LBStrings.Register.birthDay,
                text: $birthDay,
                textFiledState: .active
            )

            HStack(spacing: 15) {
                LBGenderButton(gender: .male, isActive: gender == .male) {
                    gender = .male
                }

                LBGenderButton(gender: .female, isActive: gender == .female) {
                    gender = .female
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

            LBButton(title: LBStrings.Register.buttonRegister, style: .primaryOff) {
                // self.viewModel.showError()
                print("Cadastro Concluido")
            }
            .padding(.top, 40)

        }.padding([.leading, .trailing], 26)
    }

}

struct RegisterChildView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterChildView()
    }
}
