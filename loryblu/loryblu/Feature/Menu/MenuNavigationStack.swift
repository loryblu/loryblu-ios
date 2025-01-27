//
//  MenuNavigationStack.swift
//  LoryBlu
//
//  Created by Suh on 16/12/24.
//

import SwiftUI

struct MenuNavigationStack: View {
    @EnvironmentObject var appData: AppData

    typealias NavigationCoordinator = MenuCoordinator

    struct Props {
        let onFinish: ClosureType.VoidVoid?
        let onDismiss: ClosureType.VoidVoid?
    }

    @ObservedObject var coordinator: NavigationCoordinator
    @Environment(\.dismiss) private var dismiss

    private let props: Props

    init(props: Props) {
        coordinator = .init()
        self.props = props
    }

    var body: some View {
        NavigationStack(path: $coordinator.path) {
            coordinator.buildView(
                page: .menu(
                    .init(showResponsibleEdit: {
                        pushResponsibleEdit(appData: appData)
                    }, showChildEdit: {
                        pushChildEdit(appData: appData)
                    }, showAccessControl: {
                        //
                    })
                )
            )
            .navigationDestination(
                for: MenuCoordinator.Destination.Navigation.self
            ) { destination in
                coordinator.buildView(page: destination)
                    .environmentObject(coordinator)
            }
        }
    }

    private func pushResponsibleEdit(appData: AppData) {
        coordinator.pushResponsibleEditView(
            props: ResponsibleEditView.Props(
                image: LBIcon.parentsTree2.image,
                isAvaliable: true,
                onClose: { dismiss() }, onNextView: {
                    pushChangePassword(aappData: appData)
                }
            )
        )
    }

    private func pushChangePassword(aappData: AppData) {
        coordinator.pushChangePasswordView(
            props: ChangePasswordView.Props(onClose: { dismiss()})
        )
    }

    private func pushChildEdit(appData: AppData) {
        coordinator.pushChildEditView(
            props: ChildEditView.Props(
                image: LBIcon.childTree.image,
                isAvaliable: true,
                onClose: { dismiss() }
            )
        )
    }

    private func pushFinishView(message: String) {
        coordinator.pushFinishScreen(
            props: .init(
                message: message,
                onClose: {
                    coordinator.popToRoot()
                }
            )
        )
    }
}

struct MenuNavigationStack_Previews: PreviewProvider {
    static var previews: some View {
        MenuNavigationStack(
            props: .init(onFinish: nil, onDismiss: nil)
        )
            .environmentObject(AppData())
    }
}
