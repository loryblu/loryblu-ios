import SwiftUI

struct LocbookListTasksView: View {
    @State private var securityIsOn = true

    struct Props {
        let onNewTask: ClosureType.VoidVoid?
    }

    var props: Props
    @StateObject var viewmodel: TasksViewModel  = TasksViewModel()
    @State var day: LBFrequencyFilter.Week = .none

    var body: some View {
        VStack {
            VStack(spacing: 16) {
                LBFrequencyFilter(viewmodel: viewmodel)

                TabRowShiftItems(
                    viewmodel: viewmodel,
                    onSelect: { shift in viewmodel.filterByShifts(shiftSelected: shift) }
                )
            }
            .padding(.init(top: 16, leading: 24, bottom: 0, trailing: 24))
            if !viewmodel.tasks.isEmpty {
                HStack(alignment: .center) {
                    Toggle(isOn: $securityIsOn) {}
                    .toggleStyle(SymbolToggleStyle())
                    .padding(.trailing, 6)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.init(top: 8, leading: 0, bottom: 0, trailing: 32))
            }
            ZStack {
                ListTasksView(viewmodel: viewmodel, securityIsOn: $securityIsOn)
                    .frame(maxHeight: .infinity, alignment: .top)
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
        if viewmodel.tasks.isEmpty {
            VStack(alignment: .center) {
                LBIcon.dailyList.image
                    .resizable()
                    .scaledToFit()
                    .padding(24)
                    .frame(alignment: .top)
                Text(LBStrings.Locbook.infoText)
                    .font(LBFont.titleTask)
                    .foregroundStyle(LBColor.text)
                    .padding(.top, 8)
            }
            .padding(.bottom, 80)
        } else {
            List {
                ForEach(viewmodel.tasks, id: \.uuid) { model in
                    CardTaskRegistered(
                        nameAction: model.actionType,
                        imageTask: model.image,
                        nameTask: model.locbookTask.categoryTitle ?? "",
                        backgroundCard: model.backgroundCard, isSecurity: .constant(securityIsOn))
                }
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .scrollIndicators(ScrollIndicatorVisibility.hidden)
        }
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

    @ObservedObject var viewmodel: TasksViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(LBColor.backgroundCards)
                .frame(height: 45)

            HStack(spacing: 20) {
                Button("D") {
                    viewmodel.filterWeekDay(weekDays: [.sun])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .sun ))

                Button("S") {
                    viewmodel.filterWeekDay(weekDays: [.mon])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .mon))

                Button("T") {
                    viewmodel.filterWeekDay(weekDays: [.tue])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .tue))

                Button("Q") {
                    viewmodel.filterWeekDay(weekDays: [.wed])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .wed))

                Button("Q") {
                    viewmodel.filterWeekDay(weekDays: [.thu])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .thu))

                Button("S") {
                    viewmodel.filterWeekDay(weekDays: [.fri])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .fri))

                Button("S") {
                    viewmodel.filterWeekDay(weekDays: [.sat])
                }.buttonStyle(LBDaysButtonStyle(isSet: viewmodel.currentSelectedDay == .sat))
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
