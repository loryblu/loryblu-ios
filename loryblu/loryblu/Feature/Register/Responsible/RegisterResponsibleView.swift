import SwiftUI

struct RegisterResponsibleView: View {
    @StateObject var viewModel: RegisterResponsibleViewModel = RegisterResponsibleViewModel()
    @FocusState private var focusedField: RegisterResponsibleViewModel.FocusedField?
    @State var isHiddenPassword: Bool = false
    @State var isHiddenRepeat: Bool = false
    @State var showNext: Bool = false
    @Binding var path: NavigationPath

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
            form
        }
        .navigationDestination(isPresented: $showNext) {
            RegisterChildView(viewModel: viewModel.makeRegisterChildViewModel(), path: $path)
                .toolbarRole(.editor)
        }
        .navigationTitle(LBStrings.General.empty)
        .padding(.bottom, 40)
        .onChange(of: viewModel.errorField) { newValue in
            if newValue != .none {
                focusedField = newValue
            }
        }
    }

    var form: some View {
        VStack(spacing: 16) {
            LBTextField(
                style: .common,
                icon: LBIcon.user,
                title: LBStrings.Register.name,
                text: $viewModel.name,
                textFiledState: viewModel.errorField == .name ? .alert : .active
            )
            .focused($focusedField, equals: .name)
            .onChange(of: viewModel.name) { _ in
                viewModel.clearError()
            }

            LBTextField(
                style: .common,
                icon: LBIcon.mail,
                title: LBStrings.General.email,
                text: $viewModel.email,
                textFiledState: viewModel.errorField == .email ? .alert : .active
            )
            .focused($focusedField, equals: .email)
            .onChange(of: viewModel.email) { _ in
                viewModel.clearError()
            }

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: LBStrings.General.password,
                text: $viewModel.password,
                textFiledState: viewModel.errorField == .password ? .alert : .active
            )
            .focused($focusedField, equals: .password)
            .onChange(of: viewModel.password) { _ in
                viewModel.clearError()
            }

            if let focusedField = self.focusedField, focusedField == .password {
                HStack {
                    PasswordRulesView(password: viewModel.password)
                    Spacer()
                }
            }

            LBTextField(
                style: .password,
                icon: LBIcon.lock,
                title: LBStrings.Register.confirmPassword,
                text: $viewModel.confirmPassword,
                textFiledState: viewModel.errorField == .confirmPassword ? .alert : .active
            )
            .focused($focusedField, equals: .confirmPassword)
            .onChange(of: viewModel.confirmPassword) { _ in
                viewModel.clearError()
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

            LBButton(title: LBStrings.General.next) {
                self.viewModel.showError()
                self.showContinueRegister()

            }
            .padding(.top, 45)
        }.padding([.leading, .trailing], 24)
    }

    private func showContinueRegister() {
        if self.viewModel.showNextScreen() {
            self.showNext = true
        } else {
            self.showNext = false
        }
    }

}

struct ResponsibleView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterResponsibleView(
            viewModel: RegisterResponsibleViewModel(), path: .constant(NavigationPath())
        )
    }
}