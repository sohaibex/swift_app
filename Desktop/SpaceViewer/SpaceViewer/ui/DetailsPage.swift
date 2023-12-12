import SwiftUI

struct DetailsPage: View {
    let apod: APOD
    @State private var showShareSheet = false
    @State private var shareImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                AsyncImage(url: URL(string: apod.url)) { phase in
                    switch phase {
                    case .success(let image):
                        image.resizable()
                            .scaledToFit()
                            .cornerRadius(10)
                            .background(LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.7), Color.clear]), startPoint: .bottom, endPoint: .center))
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
            }
            .padding([.leading, .trailing], 20)
        }
        .background(Color("DeepSpaceBlue").ignoresSafeArea())
        .navigationBarTitle("Details", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            shareImage(url: apod.url)
        }) {
            Image(systemName: "square.and.arrow.up")
                .foregroundColor(Color("StarWhite"))
        })
    }
    func shareImage(url: String) {
        guard let imageURL = URL(string: url) else {
            print("Error: Invalid URL.")
            return
        }
        
        URLSession.shared.dataTask(with: imageURL) { data, response, error in
            if let error = error {
                print("Error downloading image: \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                print("Error: Invalid response from server.")
                return
            }
            
            guard let data = data, let image = UIImage(data: data) else {
                print("Error: Image data could not be loaded.")
                return
            }
            
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
                
                // Present the share sheet
                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                    windowScene.windows.first?.rootViewController?.present(activityViewController, animated: true, completion: nil)
                }
            }
        }.resume()
    }
}
