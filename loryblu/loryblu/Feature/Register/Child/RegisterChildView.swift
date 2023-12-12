import SwiftUI
import WebKit

struct RegisterChildView: View {
    @StateObject var viewModel: RegisterChildViewModel
    @EnvironmentObject var coordinator: LoginNavigationStack.NavigationCoordinator
    
    @FocusState private var focusedField: RegisterChildViewModel.FocusedField?
    @State private var presented: Bool = false
    @State private var date: Date?
    var child: UserRegister?
    @State private var showDone: Bool = false
    @State private var isPresentWebView = false

    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                VStack {
                    Image(LBIcon.logoName.rawValue).resizable()
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
            .navigationTitle(LBStrings.General.empty)
            .padding(.top, -40)
            .fullScreenCover(isPresented: $viewModel.registerSuccess) {
                DoneView(message: LBStrings.Register.registerFinishedSuccess) {
                    coordinator.popToRoot()
                }
                .toolbarRole(.editor)
                .navigationBarBackButtonHidden(true)
            }
        .foregroundStyle(LBColor.background)
            if focusedField == .birthDay {
                GeometryReader { _ in
                    LBDatePicker { confirmDate in
                        viewModel.birthDate = confirmDate
                        focusedField = nil
                    } onCancel: {
                        focusedField = nil
                    }
                }
                .background(Color.black.opacity(0.50)
                    .edgesIgnoringSafeArea(.all)
                )

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

                LBDatePickerTextField(icon: .cake,
                                      title: LBStrings.Register.birthDay,
                                      date: $viewModel.birthDate,
                                      state: viewModel.errorField == .birthDay ? .alert : .active)
                .focused($focusedField, equals: .birthDay)
                .onChange(of: viewModel.birthDate) { _ in
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
                .padding(.top, 2)
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

                    NavigationLink {
                        WebView(url: URL(string: Server.politicURL)!)
                            .navigationTitle(LBStrings.Register.titleLink)

                    } label: {
                        Text(LBStrings.Register.linkAgree)
                            .foregroundColor(LBColor.text)
                            .font(LBFont.caption)
                            .underline()
                            .multilineTextAlignment(.trailing)
                    }

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
                     self.confirmRegister()
                }
                .disabled(!viewModel.agreePrivacy)
                .padding(.top, 43)

            }.padding([.leading, .trailing], 26)
        }
    }

    private func confirmRegister() {
        if viewModel.isValid {
            viewModel.saveRegister()
            showDone = true
        } else {
            showDone = false
            viewModel.showError()
        }
    }
}

struct RegisterChildView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterChildView(viewModel: RegisterChildViewModel(user: UserRegister()))
            .environmentObject(LoginNavigationStack.NavigationCoordinator())
    }
}
