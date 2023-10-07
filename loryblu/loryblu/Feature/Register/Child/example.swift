// import SwiftUI
//
// struct ContentView2: View {
//    @State private var name = ""
//    @State private var dateBirth = ""
//    @State private var gender = ""
//
//    @EnvironmentObject var childData: ChildData
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Nome", text: $name)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                TextField("Data de Nascimento", text: $dateBirth)
//                    .keyboardType(.numberPad)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                TextField("Sexo", text: $gender)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//
////                Button(action: {
////                    childData.addChild(name: name, dateBirth: dateBirth, gender: gender)
////                    name = ""
////                    dateBirth = ""
////                    gender = ""
////                    }
////                       };) {
////                    Text("Save")
////                        .padding()
////                        .background(Color.blue)
////                        .foregroundColor(.white)
////                        .cornerRadius(10)
////                }
////                .disabled(name.isEmpty || dateBirth.isEmpty || gender.isEmpty)
//
//                List(childData.users) { user in
//                    Text("\(user.name), \(user.dateBirth), \(user.gender)")
//                }
//                .listStyle(PlainListStyle())
//            }
//            .padding()
//            .navigationTitle("User Data")
//        }
//    }
// }
//
// struct ContentView2_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//            .environmentObject(ChildData())
//    }
// }
