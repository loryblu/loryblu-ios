import SwiftUI

struct LocbookListTasksView: View {
    @State private var securityIsOn = true

    // TODO: Implementar funcionalidade e filtro
    let shiftsEXEMPLO = [
        ShiftItem(
            name: LBStrings.FrequencyRotine.morning,
            icon: LBIcon.sunSmall.rawValue,
            backgroundColor: LBColor.buttonBackgroundLight,
            letterColor: .black, isSelected: false),
        ShiftItem(
            name: LBStrings.FrequencyRotine.afternoon,
            icon: LBIcon.eviningSmall.rawValue,
            backgroundColor: LBColor.buttonBackgroundMedium,
            letterColor: .white, isSelected: true),
        ShiftItem(
            name: LBStrings.FrequencyRotine.night,
            icon: LBIcon.moonSmall.rawValue,
            backgroundColor: LBColor.buttonBackgroundDark,
            letterColor: .white, isSelected: false)
    ]

    struct Props {
        let onNewTask: ClosureType.VoidVoid?
    }

    var props: Props
    @State var viewmodel: TasksViewModel  = TasksViewModel()
    @State var day: LBFrequencyFilter.Week = .none

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                LBFrequencyFilter(day: day, viewmodel: viewmodel)

                LBShiftItemsComponent(shifts: shiftsEXEMPLO)
            }
            .padding(.init(top: 16, leading: 24, bottom: 0, trailing: 24))

            HStack(alignment: .center) {
                Toggle(isOn: $securityIsOn) {
                    Image(systemName: securityIsOn ? "lock.open" : "lock")
                }
                .frame(width: 52, height: 32)
                .toggleStyle(
                    SwitchToggleStyle(
                        tint: securityIsOn ? LBColor.buttonBackgroundDark : LBColor.placeholder)
                )
                .padding(.trailing, 6)
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.init(top: 8, leading: 0, bottom: 0, trailing: 32))

            ZStack {
                ListTasksView(viewmodel: viewmodel, securityIsOn: $securityIsOn)
                    .frame(maxHeight: .infinity)
                    .onAppear {
                        Task { await viewmodel.fetchTasks() }
                    }
                    .padding(.init(top: 0, leading: 8, bottom: 0, trailing: 8))

                HStack {
                    Spacer()
                    LBfloatingButton(
                        text: LBStrings.Locbook.button,
                        icon: LBIcon.plus
                    ) {
                        self.props.onNewTask?()
                    }
                }
                .frame(maxHeight: .infinity, alignment: .bottomTrailing)
                .padding(.init(top: 0, leading: 0, bottom: 33, trailing: 16))
            }
        }
        .locbookToolbar(title: LBStrings.Locbook.title, showCloseButton: false)
        .backgroundStyle(LBColor.background)
    }
}

struct ListTasksView: View {
    @ObservedObject var viewmodel: TasksViewModel
    @Binding var securityIsOn: Bool

    var body: some View {
        List {
            if !viewmodel.tasks.isEmpty {
                ForEach(viewmodel.tasks, id: \.uuid) { model in
                    CardTaskRegistered(
                        nameAction: model.actionType,
                        imageTask: model.image,
                        nameTask: model.locbookTask.categoryTitle ?? "",
                        backgroundCard: model.backgroundCard, isSecurity: .constant(securityIsOn))
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)
    }
}

struct LBFrequencyFilter: View {
    enum Week: Equatable {
        case sunday
        case monday
        case tuesday
        case wednesday
        case thurday
        case friday
        case satuday
        case none
    }

    @State var day: Week
    @ObservedObject var viewmodel: TasksViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)

            HStack(spacing: 20) {
                Button("D") {
                    day = .sunday
                    viewmodel.filterWeekDay(weekDays: [.sun])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .sunday ))

                Button("S") {
                    day = .monday
                    viewmodel.filterWeekDay(weekDays: [.mon])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .monday))

                Button("T") {
                    day = .tuesday
                    viewmodel.filterWeekDay(weekDays: [.tue])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .tuesday))

                Button("Q") {
                    day = .wednesday
                    viewmodel.filterWeekDay(weekDays: [.wed])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .wednesday))

                Button("Q") {
                    day = .thurday
                    viewmodel.filterWeekDay(weekDays: [.thu])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .thurday))

                Button("S") {
                    day = .friday
                    viewmodel.filterWeekDay(weekDays: [.fri])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .friday))

                Button("S") {
                    day = .satuday
                    viewmodel.filterWeekDay(weekDays: [.sat])
                }.buttonStyle(LBDaysButtonStyle(isSet: day == .satuday))
            }
        }
    }
}

extension LocbookListTasksView.Props: Hashable {
    static func == (lhs: LocbookListTasksView.Props, rhs: LocbookListTasksView.Props) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    LocbookListTasksView(props: .init(onNewTask: {}))
}
