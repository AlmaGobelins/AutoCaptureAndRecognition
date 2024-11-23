//
//  ContentView.swift
//  AutoPictureAndRecognition
//
//  Created by Mathieu DUBART on 22/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
        @StateObject var imageRecognitionManager = ImageRecognitionManager()
        @State var showDescription: Bool = false
        @State var textToShow: String?
        
        // Créer une instance de CustomCameraViewController
        private let cameraController = CustomCameraViewController()
        
        var body: some View {
            VStack {
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                } else {
                    Text("Aucune image prise")
                        .font(.headline)
                        .foregroundColor(.gray)
                }
                
                Text(imageRecognitionManager.imageDescription)
                
                Spacer()
                    .frame(height: 40)
                
                Button(action: {
                    let cameraController = CustomCameraViewController()
                    let cameraView = CameraView(image: $image)
                    let coordinator = CameraView.Coordinator(cameraView)
                    cameraController.delegate = coordinator
                    
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                       let window = windowScene.windows.first,
                       let rootViewController = window.rootViewController {
                        rootViewController.present(cameraController, animated: false)
                    }
                }) {
                    Text("Prendre une photo")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
            .onChange(of: self.image) {
                if let img = self.image {
                    imageRecognitionManager.recognizeObjectsIn(image: img)
                }
            }
        }
}

#Preview {
    ContentView()
}


