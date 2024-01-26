// swiftlint: disable function_parameter_count

import SwiftUI
import Combine

class ChildData: ObservableObject {
    @Published var user: Register

    init(users: Register) {
        self.user = users
    }

    func addUser(
        name: String?,
        email: String?,
        password: String?,
        nameChild: String?,
        dateBirth: String?,
        gender: String?
    ) {
        let user = Register(
            name: name,
            email: email,
            password: password,
            nameChild: nameChild,
            dateBirth: dateBirth,
            gender: .female
        )

        self.user = user
//        users.append(user)
    }

}
// swiftlint: enable function_parameter_count
