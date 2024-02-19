import SwiftUI

struct LocbookListTasksView: View {
    @State private var securityIsOn = true
    
    // TODO: Implementar funcionalidade e filtro
    let shiftsEXEMPLO = [
        ShiftItem(name: LBStrings.FrequencyRotine.morning, icon: LBIcon.sunSmall.rawValue,backgroundColor: LBColor.buttonBackgroundLight, letterColor: .black,isSelected: false),
        ShiftItem(name: LBStrings.FrequencyRotine.afternoon, icon: LBIcon.eviningSmall.rawValue, backgroundColor: LBColor.buttonBackgroundMedium,letterColor: .white, isSelected: true),
        ShiftItem(name: LBStrings.FrequencyRotine.night, icon: LBIcon.moonSmall.rawValue,backgroundColor: LBColor.buttonBackgroundDark, letterColor: .white,isSelected: false)]
    
    // TODO: Implementar navegação
    struct Props {
        let onNewTask: ClosureType.VoidVoid?
    }
    
    var props: Props
    
    @State var viewmodel: TasksViewModel  = TasksViewModel()
    @State var sunday: Bool = false
    @State var monday: Bool = false
    @State var tuesday: Bool = false
    @State var wednesday: Bool = false
    @State var thurday: Bool = false
    @State var friday: Bool = false
    @State var saturday: Bool = false

    var body: some View {
        VStack() {
            VStack(spacing: 16) {
                Button ("teste") {
                    let filterTask: [TaskModel] =  viewmodel.filterWeekDay(weekDays: "wed", listTask: viewmodel.tasks)
                    print(filterTask)
                }
                LBWeekDaysButton(  // TODO: implementar funcionalidade e filtro
                    sunday: $sunday,
                    monday: $monday,
                    tuesday: $tuesday,
                    wednesday: $wednesday,
                    thurday: $thurday,
                    friday: $friday,
                    satuday: $saturday
                )
                
                LBShiftItemsComponent(shifts: shiftsEXEMPLO)
            }
            .padding(.init(top: 16, leading: 24, bottom: 0, trailing: 24))
            
            HStack(alignment: .center){
                Toggle(isOn: $securityIsOn) {
                    Image(systemName: securityIsOn ? "lock" : "lock.open")
                }
                .frame(width: 52, height: 32)
                .toggleStyle(
                    SwitchToggleStyle(
                        tint: securityIsOn ? LBColor.buttonBackgroundDark : LBColor.placeholder)
                ).padding(.trailing, 6)
            }
            .frame(maxWidth: .infinity,alignment: .trailing)
            .padding(.init(top: 8, leading: 0, bottom: 0, trailing: 32))
            
            ZStack {
                ListTasksView(viewmodel: viewmodel,securityIsOn: $securityIsOn).frame(maxHeight:.infinity)
                    .onAppear { Task {
                        await viewmodel.fetchTasks()
                    }
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
                .frame(maxHeight:.infinity,alignment: .bottomTrailing)
                .padding(.init(top: 0, leading: 0, bottom: 33, trailing: 16))
            }
        }
        .locbookToolbar(title: LBStrings.Locbook.title, showCloseButton: false)
        .backgroundStyle(LBColor.background)
    }
}

struct ListTasksView : View {
    
    @ObservedObject var viewmodel:TasksViewModel
    @Binding var securityIsOn: Bool
    
    var body: some View {
        
        List {
            
            if(!viewmodel.tasks.isEmpty) {
                ForEach(viewmodel.tasks, id: \.uuid) { model in
                    CardTaskRegistered(nameAction: model.actionType, imageTask: model.image, nameTask: model.locbookTask.categoryTitle!, backgroundCard: LBColor.buttonBackgroundLight, isSecurity: .constant(true))
                }
                .listRowSeparator(.hidden)
            }
        }
        .listStyle(.plain)
        .scrollContentBackground(.hidden)
        .scrollIndicators(ScrollIndicatorVisibility.hidden)

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
