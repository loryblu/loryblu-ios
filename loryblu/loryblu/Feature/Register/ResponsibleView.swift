//
//  ResponsibleView.swift
//  LoryBlu
//
//  Created by Suh on 22/07/23.
//

import SwiftUI

struct ResponsibleView: View {
    @State var name: String = ""
    @State var email: String = ""
    @State var password: String = ""
    @State var confirmPassword: String = ""
    @State var isHiddenPassword: Bool = false
    @State var isHiddenRepeat: Bool = false

    var body: some View {
        VStack {
            VStack {
                Image(LBIcon.logo.rawValue).resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 187, height: 47)
                    .clipped()
                    .padding(.bottom, 40)

                Text(LBStrings.Register.responsible)
                    .font(LBFont.head6)
                    .foregroundColor(LBColor.text)
                    .frame(width: 242, alignment: .topLeading)
                    .padding(.bottom, 32)
            }

            VStack(spacing: 16) {
                LBTextField(
                    style: .common,
                    icon: LBIcon.user,
                    title: LBStrings.Register.name,
                    text: $name,
                    isHidden: .constant(false),
                    textFiledState: .active
                )

                LBTextField(
                    style: .common,
                    icon: LBIcon.mail,
                    title: LBStrings.General.email,
                    text: $email,
                    isHidden: .constant(false),
                    textFiledState: .active
                )

                LBTextField(
                    style: .password,
                    icon: LBIcon.lock,
                    title: LBStrings.General.password,
                    text: $password,
                    isHidden: $isHiddenPassword,
                    textFiledState: .active
                )

                LBTextField(
                    style: .password,
                    icon: LBIcon.lock,
                    title: LBStrings.Register.confirmPassword,
                    text: $confirmPassword,
                    isHidden: $isHiddenRepeat,
                    textFiledState: .active
                )

                LBButton(title: LBStrings.General.next) {
                    print("Proxima Tela")
                }.padding(.top, 40)

            }.padding([.leading, .trailing], 24)

        }.padding(.top, -40)

    }
}

struct ResponsibleView_Previews: PreviewProvider {
    static var previews: some View {
        ResponsibleView(
            name: "",
            email: "",
            password: "",
            confirmPassword: "",
            isHiddenPassword: false,
            isHiddenRepeat: false
        )
    }
}
