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
            case responsible(MenuResponsibleEditView.Props)
            case child
            case accessControl
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

    func pushResponsibleEditView(props: MenuResponsibleEditView.Props) {
        navigate(to: .responsible(props))
    }

    func pushChildEditView() {}

    func pushAccessControlView() {}

    func pushFinishScreen(props: DoneView.Props) {
        navigate(to: .finishView(props))
    }

    @ViewBuilder
    func buildView(page destination: Destination.Navigation) -> some View {
        switch destination {
        case .menu(let props):
            MenuView(props: props)
        case .responsible(let props):
            MenuResponsibleEditView(props: props)
        case .child:
            EmptyView()
        case .accessControl:
            EmptyView()
        case .finishView(let props):
            DoneView(props: props)
        }
    }

    private func navigate(to destination: Destination.Navigation) {
        self.path.append(destination)
    }
}
// swiftlint:enable nesting
