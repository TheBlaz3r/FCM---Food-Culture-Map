//
//  CameraView.swift
//  ProgettoFinale
//
//  Created by Foundation 53 on 30/01/26.
//

import SwiftUI

struct CameraView: View {
    @State private var isShowingCamera = false
    @State private var capturedImage: UIImage? = nil
    @State private var classificationLabel: String = ""
    @State private var showPopup: Bool = false

    let classifier = ImageClassifier()

    var body: some View {
        ZStack {
            LinearGradient(
                colors: [.clear, .black.opacity(0.4)],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 20) {
                Spacer()
                if let image = capturedImage {
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(30)
                        .scaledToFit()
                        .frame(height: 300)
                        .padding(.horizontal)

                    Text(classificationLabel)
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .padding()
                } else {
                    Text("Take a photo and see what food it is")
                        .font(.title2)
                    //                        .foregroundColor(.gray)
                }

                Button(action: {
                    isShowingCamera = true
                }) {
                    HStack {
                        Image(systemName: "camera.viewfinder")
                        Text("Open Camera")
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                }
                Spacer()
            }
            .sheet(
                isPresented: $isShowingCamera,
                onDismiss: {
                    if let image = capturedImage {
                        classifier.classify(uiImage: image) { result in
                            DispatchQueue.main.async {
                                classificationLabel = result
                            }
                        }
                    }
                }
            ) {
                CameraPicker(capturedImage: $capturedImage)
            }
        }
    }
}

#Preview {
    CameraView()
}
