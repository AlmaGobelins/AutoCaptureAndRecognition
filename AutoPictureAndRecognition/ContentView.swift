//
//  ContentView.swift
//  AutoPictureAndRecognition
//
//  Created by Mathieu DUBART on 22/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var image: UIImage?
    @State private var isCameraPresented: Bool = false
    
    @StateObject var imageRecognitionManager = ImageRecognitionManager()
    @State var showDescription: Bool = false
    @State var textToShow: String?

    
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
            
            /*if wsClient.receivedMessages.isEmpty {
                Text("No message received")
            } else {
                List{
                    ForEach(wsClient.receivedMessages) { message in
                        Text(message.content)
                    }
                }
            }*/
            
            Spacer()
                .frame(height: 40)
            
            Button(action: {
                isCameraPresented = true
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
        .sheet(isPresented: $isCameraPresented) {
            CameraView(image: $image)
        }
    }
}

#Preview {
    ContentView()
}


