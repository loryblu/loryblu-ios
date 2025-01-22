//
//  ChangePasswordView.swift
//  LoryBlu
//
//  Created by Suh on 22/01/25.
//

import Factory
import SwiftUI

struct ChangePasswordView: View {
    @StateObject var model: NewPasswordModel = NewPasswordModel()
    @FocusState private var focusedField: RegisterResponsibleViewModel.FocusedField?
    @State private var userPassword: String = String()
    @State private var isShow: Bool = true

    var body: some View {
        VStack {
            LBIcon.logoName.image
                .frame(width: 187, height: 47)
                .padding(.init(top: 40, leading: 0, bottom: 24, trailing: 0))

            Text(LBStrings.SetPassword.reset)
                .font(LBFont.title)
                .padding(.bottom, 48)

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: LBStrings.General.oldPassword,
                text: $userPassword,
                textFiledState: .active,
                action: nil
            ).padding(.bottom, 36)

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: LBStrings.SetPassword.newPassword,
                text: $userPassword,
                textFiledState: .active,
                action: nil
            )

            HStack {
                PasswordRulesView(password: model.password)
                Spacer()
            }.padding(.init(top: 4, leading: 0, bottom: 36, trailing: 0))

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: LBStrings.SetPassword.repeatPassword,
                text: $userPassword,
                textFiledState: .active,
                action: nil
            )

            Spacer()

            LBButton(title: LBStrings.SetPassword.buttonReset) {
                Task {
                   // TODO: Serviço de update senha
                }
            }.padding(.bottom, 24)
        }
        .padding(.horizontal, 24)
    }
}

extension ChangePasswordView {
    static func build() -> ChangePasswordView {
        ChangePasswordView()
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView()
    }
}
