import Foundation
import Factory

class SummaryViewModel: ObservableObject {
    enum StatusTask {
        case none
        case loading
        case success
        case fail
    }

    @Injected(\.appData) var appData
    @Published var stateTask: StatusTask = .none
    @Published var shifts: [ShiftItem] = []
    private var repository = Container.shared.taskRepository()

    @MainActor
    func saveTask(task: LocbookTask) async {
        stateTask = .loading
        let result = await repository.taskRegister(
            with: task,
            token: appData.token,
            childrenID: appData.childrenId
        )

        if result {
            stateTask = .success
        } else {
            stateTask = .fail
        }
    }

    @MainActor
    func saveEditedTask(task: LocbookTask, onDismiss:() -> Void) async {
        stateTask = .loading
        let result = await repository.taskEdit(
            with: task,
            token: appData.token,
            childrenID: appData.childrenId
        )

        if result {
            stateTask = .success
            onDismiss()
        } else {
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

        let shift: LocbookTask.Shift

        switch shiftSelected {
        case LBStrings.FrequencyRotine.morning:
            shift = LocbookTask.Shift.morning
        case LBStrings.FrequencyRotine.afternoon:
            shift = LocbookTask.Shift.afternoon
        default:
            shift = LocbookTask.Shift.night
        }

        changeTaskShift(shift)
    }
}

extension SummaryViewModel {
    private func getShiftsUiModel(shift: LocbookTask.Shift?) -> [ShiftItem] {
        let shiftName: String

        switch shift {
        case .morning:
            shiftName = LBStrings.FrequencyRotine.morning
        case .afternoon:
            shiftName = LBStrings.FrequencyRotine.afternoon
        default:
            shiftName = LBStrings.FrequencyRotine.night
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
