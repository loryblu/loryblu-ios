//
//  ChangePasswordView.swift
//  LoryBlu
//
//  Created by Suh on 22/01/25.
//

import Factory
import SwiftUI

struct ChangePasswordView: View {
    @ObservedObject var model: NewPasswordModel = NewPasswordModel()
    @EnvironmentObject var appData: AppData
    @FocusState private var focusedField: RegisterResponsibleViewModel.FocusedField?
    @StateObject var viewModel: RegisterResponsibleViewModel = RegisterResponsibleViewModel()
    @State private var oldPassword: String = String()
    @State private var isShow: Bool = true

    struct Props {
        var onClose: ClosureType.VoidVoid?
    }

    let props: Props

    var body: some View {
        VStack {
            LBIcon.logoName.image
                .frame(width: 187, height: 47)
                .padding(.top, 40)

            Text(LBStrings.SetPassword.reset)
                .font(LBFont.title)
                .padding(.top, 24)

            fields

            HStack {
                if model.isEqual == true {
                    Text(String())
                        .padding()
                } else {
                    Text(LBStrings.SetPassword.passwordMustbeEqual)
                        .font(LBFont.caption1)
                        .foregroundColor(LBColor.error)
                        .padding(.leading)
                    Spacer()
                }
            }.padding(.top, 4)

            Spacer()
            AlertSimpleView(
                text: LBStrings.SetPassword.logoutNewPassword,
                icon: .info,
                textColor: LBColor.titlePrimary,
                borderColor: LBColor.titlePrimary
            ).padding(.bottom, 10)

            LBButton(title: LBStrings.SetPassword.buttonReset) {
                model.showError()
                if model.isEqual {
                    Task {
                        await model.setPassword(
                            newPassword: model.confirmPassword,
                            token: appData.token
                        )
                        // TODO: Serviço de update senha and Modal de sucesso  ou falha.
                         props.onClose?()
                    }
                }
            }.padding(.bottom, 24)
        }
        .locbookToolbar(title: LBStrings.General.changePassword, showCloseButton: false)
        .backgroundStyle(LBColor.background)
        .padding(.horizontal, 24)
    }

    var fields: some View {
        VStack(spacing: 36) {
            LBTextField(
                style: .password,
                icon: .lock,
                title: LBStrings.General.oldPassword,
                text: $oldPassword,
                textFiledState: .active,
                action: nil
            )

            LBTextField(
                style: .password,
                icon: .lock,
                title: LBStrings.SetPassword.newPassword,
                text: $model.password,
                textFiledState: viewModel.errorField == .password ? .alert : .active,
                action: nil
            )
            .focused($focusedField, equals: .password)
            .onChange(of: viewModel.password) { _ in
                viewModel.clearError()
            }

            if let focusedField = self.focusedField, focusedField == .password {
                HStack {
                    PasswordRulesView(password: model.password)
                    Spacer()
                }
            }

            LBTextField(
                style: .password,
                icon: .lock,
                title: LBStrings.SetPassword.repeatPassword,
                text: $model.confirmPassword,
                textFiledState: viewModel.errorField == .confirmPassword ? .alert : .active,
                action: nil
            )
            .focused($focusedField, equals: .confirmPassword)
            .onChange(of: viewModel.password) { _ in
                viewModel.clearError()
            }
        }.padding(.top, 48)
    }
}

extension ChangePasswordView.Props: Hashable {
    static func == (lhs: ChangePasswordView.Props, rhs: ChangePasswordView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

@available(iOS 17.0, *)
#Preview {
    @Previewable @StateObject var appData: AppData = .init()
    ChangePasswordView(props: .init(onClose: {}))
        .environmentObject(appData)
}
