import SwiftUI

struct AppEntryPoint: View {
    @EnvironmentObject var appData: AppData

    var body: some View {
        NavigationStack {
            LoginView()
                .environmentObject(appData)
                .navigationDestination(isPresented: $appData.isTokenReceived) {
                    NewPasswordScreen(model: NewPasswordModel(), appData: appData)
                }
        }
        .onOpenURL { url in
            let deepLinkHandler = DeepLinkHandler()
            deepLinkHandler.handleDeepLink(with: url, appData: appData)
        }
    }
}


//recebo 
//{
//    "statucode": "error.404 "
//    "mensage": "Email existe."
//}
//
//enum TypeError: String {
//   case error404 = "Email já existe"
//   case error303 = "Email invalido"
//}
//
//enum TypeCode: String {
//    case e404 = "error.404"
//    case e303 = "error.303"
//}
//
//var typecode = TypeCode.self
//
//if typecode {
