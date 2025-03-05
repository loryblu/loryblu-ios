//
//  LBActionSheet.swift
//  LoryBlu
//
//  Created by Suh on 26/02/25.
//

import SwiftUI
import PhotosUI

struct CameraPickerView: View {
    @Binding var selectedImageData: Data?
    @Binding var isPresented: Bool

    @State private var imagePickerController: UIImagePickerController?

    var body: some View {
        ImagePicker(selectedImageData: $selectedImageData, isPresented: $isPresented)
    }
}

struct LBActionSheet: View {
    @Binding var isPresented: Bool
    @Binding var deletePhoto: Bool
    @State private var showCustomActionSheet = false
    @State private var selectedItem: PhotosPickerItem?
    @State private var selectedImageData: Data?
    @State private var isPhotoPickerPresented = false
    @State private var isCameraPickerPresented = false
    @State private var showActionSheet = false
    let image: String

    var body: some View {
        VStack {
            VStack(spacing: 24) {
                HStack {
                    Image(image)
                        .resizable()
                        .frame(width: 36, height: 36)
                        .foregroundColor(.blue)
                        .overlay(RoundedRectangle(cornerRadius: 2, style: .continuous))
                    Spacer()
                    Text("Editar foto de perfil")
                        .font(LBFont.titleTask)
                        .foregroundColor(LBColor.titlePrimary)
                    Spacer()
                    LBIcon.close2.image

                }
                .frame(maxWidth: .infinity)
                .padding(.top, 20)

                VStack(spacing: 0) {
                    Button(action: {
                        print("Tira foto")
                        isCameraPickerPresented.toggle()
                    }, label: {
                        HStack {
                            Text("Tirar foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.camera.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })

                    Divider()
                    Button(action: {
                        print("Escolher foto")
                        isPhotoPickerPresented.toggle()
                    }, label: {
                        HStack {
                            Text("Escolher foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.album.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })

                    Divider()
                    Button(action: {
                        deletePhoto.toggle()
                    }, label: {
                        HStack {
                            Text("Excluir foto")
                                .font(.headline)
                                .foregroundColor(LBColor.titlePrimary)
                            Spacer()
                            LBIcon.trashBlue.image
                                .frame(width: 32, height: 32)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                    })
                }
                .background(LBColor.blue100)
                .overlay(
                    RoundedRectangle(
                        cornerRadius: 8,
                        style: .continuous
                    ).stroke(LBColor.titlePrimary, lineWidth: 1)
                )

                .sheet(isPresented: $isPhotoPickerPresented) {
                    PhotosPicker(
                        selection: $selectedItem,
                        matching: .images,
                        photoLibrary: .shared()) {
                            Text("galeria")// Nenhum texto aqui, apenas abre o PhotoPicker
                        }
                        .onChange(of: selectedItem) { newItem in
                            Task {
                                if let selectedItem = newItem {
                                    if let data = try? await selectedItem.loadTransferable(type: Data.self) {
                                        selectedImageData = data
                                    }
                                }
                            }
                        }
                        .frame(height: 0)
                }

                .sheet(isPresented: $isCameraPickerPresented) {
                    CameraPickerView(
                        selectedImageData: $selectedImageData,
                        isPresented: $isCameraPickerPresented
                    )
                }
            }
            .background(LBColor.blue100)
            .padding()
            .frame(maxWidth: .infinity)
            .transition(.move(edge: .bottom))

        }
        .padding(.bottom, 0)
        .background(LBColor.blue100)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .onTapGesture {
            isPresented = false
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImageData: Data?
    @Binding var isPresented: Bool

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImageData = image.jpegData(compressionQuality: 0.8)
            }
            parent.isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .camera // Define como câmera
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
}

struct Exemple2: View {
    @State private var showCustomActionSheet = false
    @State private var deleteImage = false

    var body: some View {
        VStack {
            Text("Selecione uma ação")
                .padding()

            Button("Mostrar ActionSheet Personalizado") {
                showCustomActionSheet.toggle()
            }
            .padding()
        }
        .overlay(
            showCustomActionSheet ? AnyView(
                LBActionSheet(
                    isPresented: $showCustomActionSheet,
                    deletePhoto: $deleteImage,
                    image: LBIcon.parentsTree.rawValue
                )
            ) : AnyView(EmptyView())
        )
        .fullScreenCover(isPresented: $deleteImage) {
            LBAlertConfirmation(
                textInfo: "Você quer excluir a",
                highlightText: "Foto de Perfil",
                textButtonOne: "Cancelar",
                textButtonTwo: "Excluir",
                onClosed: { deleteImage = false },
                onCancel: { deleteImage = false }
            )
        }
    }
}

#Preview {
    Exemple2()
}
