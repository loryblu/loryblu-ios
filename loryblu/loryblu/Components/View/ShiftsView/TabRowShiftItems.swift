import SwiftUI

struct TabRowShiftItems: View {
    @ObservedObject var viewmodel: TasksViewModel
    var onSelect: (String) -> Void
    var body: some View {
        LBShiftItemsComponent(shifts: viewmodel.shifts, onClick: { shift in onSelect(shift) })
    }
}
