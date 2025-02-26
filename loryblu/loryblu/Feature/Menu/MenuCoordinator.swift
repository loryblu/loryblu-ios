//
//  MenuCoordinator.swift
//  LoryBlu
//
//  Created by Suh on 16/12/24.
//

import SwiftUI

// swiftlint:disable nesting
@MainActor
class MenuCoordinator: ObservableObject {
    enum Destination {
        enum Navigation: Hashable {
            case menu(MenuView.Props)
            case responsible(ResponsibleEditView.Props)
            case changePassword(ChangePasswordView.Props)
            case child(ChildEditView.Props)
            case accessControl(AccessControlView.Props)
            case finishView(DoneView.Props)
        }
        enum FullScreen: Hashable {
            case finishView(DoneView.Props)
        }
    }

    @Published var path: [Destination.Navigation]

    init() {
        path = []
    }

    func popToRoot() {
        path.removeAll()
    }

    func popView(count: Int = 1) {
        if path.isEmpty == false {
            path.removeLast(count)
        }
    }

    func pushResponsibleEditView(props: ResponsibleEditView.Props) {
        navigate(to: .responsible(props))
    }

    func pushChangePasswordView(props: ChangePasswordView.Props) {
        navigate(to: .changePassword(props))
    }

    func pushChildEditView(props: ChildEditView.Props) {
        navigate(to: .child(props))
    }

    func pushAccessControlView(props: AccessControlView.Props) {
        navigate(to: .accessControl(props))
    }

    func pushFinishScreen(props: DoneView.Props) {
        navigate(to: .finishView(props))
    }

    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case .menu(let props):
            MenuView(props: props)
        case .responsible(let props):
            ResponsibleEditView(props: props)
        case .changePassword(let props):
            ChangePasswordView(props: props)
        case .child(let props):
            ChildEditView(props: props)
        case .accessControl(let props):
            AccessControlView(props: props)
        case .finishView(let props):
            DoneView(props: props)
        }
    }

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }
}
// swiftlint:enable nesting
