//import SwiftUI
//import PhotosUI
//import UIKit
//
//struct ProfileEditorView: View {
//    @State private var showCustomActionSheet = false
//    @State private var selectedItem: PhotosPickerItem? // Item selecionado do PHPicker
//    @State private var selectedImageData: Data? // Dados da imagem selecionada
//    @State private var isPhotoPickerPresented = false // Controla a exibição do photo picker
//    @State private var isCameraPickerPresented = false // Controla a exibição do Camera picker
//    @State private var showActionSheet = false // Controla o ActionSheet (para escolher tirar foto ou selecionar)
//    @State private var deletePhoto = false
//
//    var body: some View {
//        VStack {
//            Text("Editar Foto de Perfil")
//                .font(.title)
//                .padding()
//
//            // Exibe a imagem selecionada ou um ícone de imagem caso não tenha sido selecionada
//            if let selectedImageData, let uiImage = UIImage(data: selectedImageData) {
//                Image(uiImage: uiImage)
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 150, height: 150)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.white, lineWidth: 4))
//                    .shadow(radius: 10)
//            } else {
//                Image(systemName: "person.circle.fill")
//                    .resizable()
//                    .scaledToFill()
//                    .frame(width: 150, height: 150)
//                    .foregroundColor(.gray)
//            }
//
//            // Exibe o botão para abrir o ActionSheet (Tirar Foto ou Buscar na Galeria)
//            Button("Alterar Foto de Perfil") {
//                showActionSheet.toggle()
//            }
//            .actionSheet(isPresented: $showActionSheet) {
//                ActionSheet(
//                    title: Text("Editar foto do perfil"),
//                    buttons: [
//                        .default(Text("Tirar foto")) {
//                            isCameraPickerPresented.toggle() // Abrir a câmera diretamente
//                        },
//                        .default(Text("Escolher foto")) {
//                            isPhotoPickerPresented.toggle() // Abrir a galeria diretamente
//                        },
//                        .default(Text("Excluir Foto")) {
//                            deletePhoto.toggle()
//                        },
//                        .cancel()
//                    ]
//                )
//            }
//
//            // Apresentando o PhotoPicker (Galeria de Fotos)
//            .fullScreenCover(isPresented: $isPhotoPickerPresented) {
//                PhotosPicker(
//                    selection: $selectedItem,
//                    matching: .images,
//                    photoLibrary: .shared()) {
//                        // Nenhum texto aqui, apenas abre o PhotoPicker
//                }
//                .onChange(of: selectedItem) { newItem in
//                    Task {
//                        if let selectedItem = newItem {
//                            if let data = try? await selectedItem.loadTransferable(type: Data.self) {
//                                selectedImageData = data
//                            }
//                        }
//                    }
//                }
//                .frame(height: 0)
//            }
//
//            // Apresentando a CameraPicker (Abrir diretamente a câmera)
//            .fullScreenCover(isPresented: $isCameraPickerPresented) {
//                CameraPickerView(selectedImageData: $selectedImageData, isPresented: $isCameraPickerPresented)
//            }
//
//            // Apresentando o alerta de confirmação para excluir a foto
//            if deletePhoto {
//                LBAlertConfirmation(
//                    textInfo: "Você quer excluir a",
//                    highlightText: "Foto de Perfil",
//                    textButtonOne: "Cancelar",
//                    textButtonTwo: "Excluir",
//                    onClosed: {
//                        deletePhoto = false // Fecha o alerta ao clicar em qualquer botão
//                    },
//                    onCancel: {
//                        deletePhoto = false // Fecha o alerta ao clicar no botão de cancelar
//                    })
//            }
//
//            Spacer()
//        }
//        .padding()
//    }
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//    @Binding var selectedImageData: Data?
//    @Binding var isPresented: Bool
//
//    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//        var parent: ImagePicker
//
//        init(parent: ImagePicker) {
//            self.parent = parent
//        }
//
//        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//            parent.isPresented = false
//        }
//
//        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//            if let image = info[.originalImage] as? UIImage {
//                parent.selectedImageData = image.jpegData(compressionQuality: 0.8)
//            }
//            parent.isPresented = false
//        }
//    }
//
//    func makeCoordinator() -> Coordinator {
//        return Coordinator(parent: self)
//    }
//
//    func makeUIViewController(context: Context) -> UIImagePickerController {
//        let imagePicker = UIImagePickerController()
//        imagePicker.delegate = context.coordinator
//        imagePicker.sourceType = .camera // Define como câmera
//        return imagePicker
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
//}
//
//struct ProfileEditorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileEditorView()
//    }
//}
