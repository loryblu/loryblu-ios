import Foundation
import Factory

class SummaryViewModel: ObservableObject {
    enum StatusTask {
        case none
        case success
        case fail
    }

    @Published var stateTask: StatusTask = .none
    @Injected(\.appData) var appData
    @Published var shifts: [ShiftItem] = []

    private var repository = Container.shared.taskRepository()

    @MainActor
    func saveTask(task: LocbookTask) async {
        let result = await repository.taskRegister(
            with: task,
            token: appData.token,
            childrenID: appData.childrenId
        )
        if result {
            print("request success")
            stateTask = .success
        } else {
            print("request fail")
            stateTask = .fail
        }
    }
    func iniShifts(shift: LocbookTask.Shift?) {
        self.shifts = getShiftsUiModel(shift: shift)
    }
    func onChangeShift(shiftSelected: String, changeTaskShift: (LocbookTask.Shift) -> Void) {
        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            let isSelected = shiftSelected == shift.name  ? true : false
            return ShiftItem(
                name: shift.name,
                icon: shift.icon,
                backgroundColor: shift.backgroundColor,
                letterColor: shift.letterColor,
                isSelected: isSelected
            )
        }
        let shift = switch shiftSelected {
        case LBStrings.FrequencyRotine.morning:
            LocbookTask.Shift.morning
        case LBStrings.FrequencyRotine.afternoon:
            LocbookTask.Shift.afternoon
        default:
            LocbookTask.Shift.night
        }
        changeTaskShift(shift)
    }
}
extension SummaryViewModel {
    private func getShiftsUiModel(shift: LocbookTask.Shift?) -> [ShiftItem] {
        let shiftName = switch shift {
        case .morning:
            LBStrings.FrequencyRotine.morning
        case .afternoon:
            LBStrings.FrequencyRotine.afternoon
        default:
            LBStrings.FrequencyRotine.night
        }

        var shifts = [
            ShiftItem(
                name: LBStrings.FrequencyRotine.morning,
                icon: LBIcon.sunSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundLight,
                letterColor: .black,
                isSelected: false
            ),
            ShiftItem(
                name: LBStrings.FrequencyRotine.afternoon,
                icon: LBIcon.eviningSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundMedium,
                letterColor: .white,
                isSelected: false
            ),
            ShiftItem(
                name: LBStrings.FrequencyRotine.night,
                icon: LBIcon.moonSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundDark,
                letterColor: .white,
                isSelected: false
            )
        ]

        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            var mutableShift = shift
            if shift.name == shiftName {
                mutableShift.isSelected = true
            }
            return mutableShift
        }

        return shifts
    }
}
