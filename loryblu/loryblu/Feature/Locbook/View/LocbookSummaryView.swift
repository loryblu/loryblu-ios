//
//  LocbookSummaryView.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 05/02/24.
//

import SwiftUI

struct DayOfWeekOption {
    var name: String
    var isSelected:Bool
    var frequency: LocbookTask.Frequency
}
struct LocbookSummaryView: View {
    
    // MARK: - Defines
    
    struct Props {
        var task: LocbookTask
        let onSubmit: ClosureType.VoidVoid?
        var onClose : ClosureType.VoidVoid?
        
        var title: String {
            task.categoryTitle ?? ""
        }
        
        var shifts : [ShiftItem] {
            getShiftsUiModel(shift: task.shift)
        }
        
        var frequencyDaysOfWeek: [DayOfWeekOption] {
            getDaysOfWeekOptionsUiModel(frequency: task.frequency)
        }
        
        var taskImage: String {
            let imageLabel = getImageLabelByCategoryId(categoryId: task.categoryId!)
            return imageLabel.image
        }
        var taskName: String {
            let imageLabel = getImageLabelByCategoryId(categoryId: task.categoryId!)
            return imageLabel.name
        }
    }
    
    // MARK: - Properties
    
    let props: Props
    @State var formConfig = FormConfig()
    
    init(props: Props, formConfig: FormConfig = FormConfig()) {
        self.props = props
        print(props.task)
        self.formConfig = formConfig
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            
            LBIcon.progression4.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,minHeight: 50)
            
            Spacer()
            HStack {
                Image(props.taskImage)
                    .resizable()
                    .padding(24)
                    .scaledToFill()
                    .frame(width: 200, height: 200, alignment: .center)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .inset(by: 0)
                            .strokeBorder(LBColor.titlePrimary, lineWidth: 4)).background(LBColor.backgroundCards).cornerRadius(12)
            }.padding([.leading, .trailing], 24)
            
            VStack(spacing:8) {
                HStack(alignment: .center, spacing: 8) {
                    Text(LBStrings.SummaryLocbook.category)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text).frame(alignment: .topLeading)
                    Spacer()
                    ZStack {
                        Text(props.task.categoryTitle!).padding(8).frame(maxWidth: .infinity,alignment: .center).multilineTextAlignment(.center).frame(maxWidth:.infinity).padding(8).font(LBFont.body)
                    }.background(LBColor.background_darkBlue).cornerRadius(6).foregroundColor(.white)
                    
                }.frame(maxWidth:.infinity)
                
                
                
                HStack(alignment: .center, spacing: 24) {
                    Text(LBStrings.SummaryLocbook.task)
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text).frame(alignment: .topLeading)
                    Spacer()
                    ZStack {
                        Text(props.taskName).padding(8).frame(maxWidth: .infinity,alignment: .center).multilineTextAlignment(.center).padding(8).font(LBFont.body)
                    }.background(LBColor.background_darkBlue).cornerRadius(6).frame(maxWidth:.infinity).foregroundColor(.white)

                }.frame(maxWidth:.infinity)
                
            }.padding(.bottom,10)
            
            Divider()
            
            Text(LBStrings.SummaryLocbook.shift).font(LBFont.head5)
                .foregroundStyle(LBColor.text).frame(maxWidth:.infinity,alignment: .leading)
            
            LBShiftItemsComponent(shifts: props.shifts)
            
            
            Text(LBStrings.SummaryLocbook.frequency).font(LBFont.head5)
                .foregroundStyle(LBColor.text).frame(maxWidth:.infinity,alignment: .leading)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LBColor.backgroundCards)
                    .frame(height: 45)
                
                HStack(spacing: 20) {
                    ForEach(props.frequencyDaysOfWeek, id: \.frequency) { day in
                        ZStack {
                            Circle()
                                .frame(width: 30, height: 30)
                                .foregroundColor(day.isSelected ? LBColor.buttonGenderEnable : LBColor.backgroundCards)
                            Text(day.name)
                                .font(LBFont.head6)
                                .foregroundColor(day.isSelected ? LBColor.backgroundCards : LBColor.buttonGenderEnable)
                        }
                    }
                }
            }
            
            LBButton(title: LBStrings.SummaryLocbook.submitTask) {
                //  props.onSubmit?()
            }
        }.padding(24).locbookToolbar(title: LBStrings.SummaryLocbook.topbarTitle, onClose: { props.onClose?() })
    }
}

extension LocbookSummaryView {
    
    struct FormConfig {
        var sunday: Bool = false
        var monday: Bool = false
        var tuesday: Bool = false
        var wednesday: Bool = false
        var thurday: Bool = false
        var friday: Bool = false
        var satuday: Bool = false
        var morningSet: Bool = true
        var afternoonSet: Bool = false
        var nightSet: Bool = false
        var period: Period = .morning
    }
}
extension LocbookSummaryView.Props {
    func getShiftsUiModel(shift:LocbookTask.Shift?) -> [ShiftItem] {
        let shiftName = switch shift {
        case .morning:
            LBStrings.FrequencyRotine.morning
        case .afternoon:
            LBStrings.FrequencyRotine.afternoon
        default :
            LBStrings.FrequencyRotine.night
        }
        
        var shifts = [
            
            ShiftItem(
                name: LBStrings.FrequencyRotine.morning, 
                icon:LBIcon.sunSmall.rawValue,
                backgroundColor:LBColor.buttonBackgroundLight,
                letterColor: .black,isSelected: false),
            
            ShiftItem(
                name: LBStrings.FrequencyRotine.afternoon,
                icon: LBIcon.eviningSmall.rawValue,
                backgroundColor: LBColor.buttonBackgroundMedium,
                letterColor: .white,
                isSelected: false),
            
            ShiftItem(name: LBStrings.FrequencyRotine.night,
                      icon: LBIcon.moonSmall.rawValue,
                      backgroundColor: LBColor.buttonBackgroundDark,
                      letterColor: .white,
                      isSelected: false)
        
        ]
        
        shifts = shifts.map { (shift: ShiftItem) -> ShiftItem in
            var mutableShift = shift
            if(shift.name == shiftName) {
                mutableShift.isSelected = true
            }
            return mutableShift
        }
        
        return shifts
    }
    
    func getDaysOfWeekOptionsUiModel(frequency:[LocbookTask.Frequency]?) -> [DayOfWeekOption] {
        
        var dayOfWeekOptions = [
            DayOfWeekOption(name: "D",isSelected: false, frequency: .sun),
            DayOfWeekOption(name: "S", isSelected: false,frequency: .mon),
            DayOfWeekOption(name: "T", isSelected: false, frequency: .tue),
            DayOfWeekOption(name: "Q", isSelected: false, frequency: .wed),
            DayOfWeekOption(name: "Q", isSelected: false, frequency: .thu),
            DayOfWeekOption(name: "S", isSelected: false, frequency: .fri),
            DayOfWeekOption(name: "S", isSelected: false, frequency: .sat)
        ]
        
        frequency?.forEach { frequency in
            dayOfWeekOptions = dayOfWeekOptions.map { (dayOfWeek: DayOfWeekOption) -> DayOfWeekOption in
                var mutableDayOfWeek = dayOfWeek
                if(dayOfWeek.frequency == frequency) {
                    mutableDayOfWeek.isSelected = true
                }
                return mutableDayOfWeek
            }
        }
        
        return dayOfWeekOptions
    }
    
    func getImageLabelByCategoryId(categoryId: String) -> ImageLabel {
            let list:[ImageLabel] = LocbookListTasks.rotine + LocbookListTasks.study
            let index = list.firstIndex { item in item.categoryID == categoryId }!
            return list[index]
    }
}
extension LocbookSummaryView.Props: Hashable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(String(describing: Self.self))
    }
}

#Preview {
    NavigationStack {
        LocbookSummaryView(props: .init(task: LocbookTask(categoryTitle: "Title of the task"), onSubmit: { })).locbookToolbar(title: "LoryEstudioso", onClose: {} )
    }
}
