import SwiftUI

struct HomePage: View {
    @StateObject var apiService = APIService()
    @State private var showDatePicker = false  // To control the display of the full calendar

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color("DeepSpaceBlue"), Color.black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                Text("SpaceViewer")
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(Color("StarWhite"))
                    .shadow(color: Color.black.opacity(0.7), radius: 5, x: 0, y: 2)
                    .padding(.top, 20)
                
                // Display only the selected date
                Button(action: {
                    showDatePicker.toggle()
                }) {
                    Text("\(apiService.selectedDate, formatter: DateFormatter.shortDate)")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.black)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: .gray.opacity(0.3), radius: 10, x: 0, y: 10)
                }
                .padding(.horizontal, 20)
                .sheet(isPresented: $showDatePicker) {
                    DatePicker("", selection: $apiService.selectedDate, in: ...Date(), displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .accentColor(.black)
                        .onChange(of: apiService.selectedDate) { oldValue, newValue in
                                                    apiService.fetchAPOD(for: newValue)
                            showDatePicker = false
                                                }
                }

                if let apod = apiService.apod {
                    NavigationLink(destination: DetailsPage(apod: apod)) {
                        VStack {
                            AsyncImage(url: URL(string: apod.url)) { image in
                                image.resizable().scaledToFit()
                            } placeholder: {
                                ProgressView().progressViewStyle(CircularProgressViewStyle(tint: .white))
                            }
                            .cornerRadius(10)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color("StarWhite").opacity(0.7), lineWidth: 2)
                            )

                            VStack(spacing: 10) {
                                Text(apod.title)
                                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                                    .foregroundColor(Color("StarWhite"))
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.7)))
                                    .cornerRadius(10)

                                Text(apod.explanation)
                                    .lineLimit(3)
                                    .foregroundColor(Color("StarWhite"))
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.black.opacity(0.7)))
                                    .cornerRadius(10)
                            }
                        }
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.black, Color("DeepSpaceBlue").opacity(0.7)]), startPoint: .top, endPoint: .bottom))
                        .cornerRadius(20)
                        .shadow(color: .blue.opacity(0.6), radius: 15, x: 0, y: 10)
                        .padding(.bottom, 30)
                    }
                } else {
                    ProgressView().progressViewStyle(CircularProgressViewStyle(tint: Color("StarWhite")))
                }
            }
        }
        .onAppear {
            apiService.fetchAPOD(for: apiService.selectedDate)
        }
    }
}

extension DateFormatter {
    static var shortDate: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }
}
