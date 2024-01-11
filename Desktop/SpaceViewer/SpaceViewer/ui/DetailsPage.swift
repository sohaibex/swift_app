import SwiftUI
import Photos

struct DetailsPage: View {
    let apod: APOD
    @State private var showShareSheet = false
    @State private var showSaveConfirmation = false

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: apod.url)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                    case .empty:
                        ProgressView()
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(Color("GalaxyGray"))
                            .cornerRadius(10)
                    @unknown default:
                        EmptyView()
                    }
                }
                .padding(.bottom, 20)

                Text(apod.title)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(Color("StarWhite"))
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2)

                Text(apod.explanation)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(Color("GalaxyGray"))
                    .shadow(color: Color.black.opacity(0.5), radius: 3, x: 0, y: 1)

                HStack {
                    Spacer()
                 
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 20)
        }
        .background(Color("DeepSpaceBlue").ignoresSafeArea())
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: HStack {
            Button(action: {
                showShareSheet = true
            }) {
                Image(systemName: "square.and.arrow.up")
                    .foregroundColor(Color("StarWhite"))
            }
            
            Button(action: {
                downloadAndSaveImage(urlString: apod.url)
            }) {
                Image(systemName: "square.and.arrow.down")
                    .foregroundColor(Color.blue)
            }
        })
        .sheet(isPresented: $showShareSheet, onDismiss: {
            showShareSheet = false
        }) {
            ShareSheet(activityItems: [URL(string: apod.url) ?? ""])
        }
        .alert(isPresented: $showSaveConfirmation) {
            Alert(title: Text("Saved"), message: Text("The image has been saved to your gallery."), dismissButton: .default(Text("OK")))
        }
    }

    private func downloadAndSaveImage(urlString: String) {
        guard let url = URL(string: urlString) else { return }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                DispatchQueue.main.async {
                    if let image = UIImage(data: data) {
                        saveImageToGallery(image: image)
                    }
                }
            }
        }.resume()
    }

    private func saveImageToGallery(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            if status == .authorized {
                UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                DispatchQueue.main.async {
                    self.showSaveConfirmation = true
                }
            } else {
                print("Permission to access photo library was denied.")
            }
        }
    }
}

