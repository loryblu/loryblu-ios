import Foundation
import SwiftUI

 struct TaskModel {
     var uuid: UUID = UUID()
     var actionType: String
     var locbookTask: LocbookTask
     var image: String
     var backgroundCard: Color
}
