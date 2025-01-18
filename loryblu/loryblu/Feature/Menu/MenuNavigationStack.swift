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
                    .init(
                        showNextPage: {
                            pushResponsibleEdit(aappData: appData)
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

    private func pushResponsibleEdit(aappData: AppData) {
        coordinator.pushResponsibleEditView(
            props: MenuResponsibleEditView.Props(
                image: LBIcon.parentsTree2.image,
                isAvaliable: true
            )
        )
    }

    private func pushChildEdit() {
        print("%=== CHILD EDIT ===%")
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
