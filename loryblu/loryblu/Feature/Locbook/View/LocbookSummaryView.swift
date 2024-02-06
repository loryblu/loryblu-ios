//
//  LocbookSummaryView.swift
//  LoryBlu
//
//  Created by Rodrigo Cavalcante on 05/02/24.
//

import SwiftUI
struct DayOfWeekOption {
    var id:UUID = UUID()
    var name: String
    var isSelected:Bool
}
struct LocbookSummaryView: View {
    
    let frequencyDaysOfWeek: [DayOfWeekOption] = [
        DayOfWeekOption(name: "D", isSelected: false),
        DayOfWeekOption(name: "S", isSelected: false),
        DayOfWeekOption(name: "T", isSelected: false),
        DayOfWeekOption(name: "Q", isSelected: true),
        DayOfWeekOption(name: "Q", isSelected: false),
        DayOfWeekOption(name: "S", isSelected: false),
        DayOfWeekOption(name: "S", isSelected: false)

    ]
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
           
            LBIcon.progression4.image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity,minHeight: 50)
     
            Spacer()
            HStack {
                Image(LBIcon.brushTeeth.rawValue)
                    .resizable()
                    .padding(24)
                        .scaledToFill()
                        .frame(width: 200, height: 200, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .inset(by: 0)
                                .strokeBorder(LBColor.titlePrimary, lineWidth: 4)).background(LBColor.backgroundCards).cornerRadius(12)
            }.frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/).padding([.leading, .trailing], 24)
                        
            VStack(spacing:8) {
                HStack(alignment: .center, spacing: 8) {
                    Text("Categoria:")
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text).frame(alignment: .topLeading)
                    Spacer()
                    ZStack {
                        Text("LoryRotina").padding(8).frame(maxWidth: .infinity,alignment: .center).multilineTextAlignment(.center).frame(maxWidth:.infinity).padding(8).font(LBFont.body)
                    }.background(LBColor.background_darkBlue).cornerRadius(6).foregroundColor(.white)

                }.frame(maxWidth:.infinity)
                
              
            
                HStack(alignment: .center, spacing: 24) {
                    Text("Tarefa:")
                        .font(LBFont.head5)
                        .foregroundStyle(LBColor.text).frame(alignment: .topLeading)
                    Spacer()
                    ZStack {
                        Text("Video Game Liberado").padding(8).frame(maxWidth: .infinity,alignment: .center).multilineTextAlignment(.center).padding(8).font(LBFont.body)
                    }.background(LBColor.background_darkBlue).cornerRadius(6).frame(maxWidth:.infinity).foregroundColor(.white)

                }.frame(maxWidth:.infinity)
                
            }.padding(.bottom,10)
            
            Divider()
            
            Text("Turno:").font(LBFont.head5)
                .foregroundStyle(LBColor.text).frame(maxWidth:.infinity,alignment: .leading)
            
            LBShiftItemsComponent(shifts: [ShiftItem(name: "Manhã", icon: LBIcon.shift_morning.rawValue, isSelected: true),
                                           ShiftItem(name: "Tarde", icon: LBIcon.shift_morning.rawValue, isSelected: false),
                                           ShiftItem(name: "Noite", icon: LBIcon.shift_morning.rawValue, isSelected: false)])
        
            
            Text("Frequência:").font(LBFont.head5)
                .foregroundStyle(LBColor.text).frame(maxWidth:.infinity,alignment: .leading)
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(LBColor.backgroundCards)
                    .frame(height: 45)
                
                HStack(spacing: 20) {
                    ForEach(frequencyDaysOfWeek, id: \.id) { day in
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
            
            LBButton(title: "Cadastrar Tarefa") {
                //  props.onSubmit?()
            }
        }.padding(24)
    }
}

#Preview {
    NavigationStack {
        LocbookSummaryView().locbookToolbar(title: "LoryEstudioso", onClose: {} )
    }
}
