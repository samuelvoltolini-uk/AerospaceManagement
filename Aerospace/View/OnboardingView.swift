import SwiftUI

struct OnboardingView: View {
    
    @State private var selection = 0
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        NavigationStack {
            VStack {
                TabView(selection: $selection) {
                    // First Onboarding Screen
                    OnboardingContentScreen(
                        imageName: "Integration",
                        title: "Inventory Integration",
                        description: "Seamlessly integrate your inventory into our platform. With just a few taps, you can input and manage all your stock details, ensuring that your inventory is always up-to-date and accurately represented."
                    )
                    .tag(0)
                    
                    // Second Onboarding Screen
                    OnboardingContentScreen(
                        imageName: "DataStorage",
                        title: "Secure Data Storage",
                        description: "Experience unparalleled data management with our secure storage solutions. Safely store all your vital inventory information in our encrypted database, accessible anytime for your convenience."
                    )
                    .tag(1)
                    
                    // Second Onboarding Screen
                    OnboardingContentScreen(
                        imageName: "Update",
                        title: "Efficient Updates Processing",
                        description: "Streamline the way you handle returns and exchanges. Our user-friendly interface simplifies these processes, making it easy to update your inventory and maintain high customer satisfaction."
                    )
                    .tag(2)
                    
                    // Third Onboarding Screen
                    OnboardingContentScreen(
                        imageName: "Search",
                        title: "Advanced Product Search",
                        description: "Locate products effortlessly with our sophisticated search tool. Quickly sift through your inventory database, finding exactly what you need in moments, thus saving time and enhancing productivity."
                    )
                    .tag(3)
                    
                    // Fourth Onboarding Screen
                    OnboardingContentScreen(
                        imageName: "Scan",
                        title: "Scan & Update Instantly",
                        description: "Keep your inventory data up-to-the-minute with our intuitive scanning feature. Instantly update stock levels or product details by scanning barcodes, ensuring your database reflects the most current information."
                    )
                    .tag(4)
                    
                    // Fith Onboarding Screen with Buttons
                    OnboardingContentScreen(
                        imageName: "Statistics",
                        title: "Insightful Statistics & Reports",
                        description: "Empower your decision-making with detailed statistics. Dive into inventory statuses, and inventory history, using these insights to optimize your operations and drive business growth."
                    )
                    .tag(5)
                    
                    
                    VStack {
                        
                        
                        
                        Image(colorScheme == .dark ? "LogoBlack" : "LogoWhite")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 400, height: 400)
                        
                        HStack {
                            NavigationLink(destination: LoginView()) {
                                Text("Login")
                                    .padding()
                                    .frame(maxWidth: 200)
                                    .foregroundColor(.white)
                                    .fontWeight(.semibold)
                                    .background(Color.accentColor)
                                    .cornerRadius(8)
                            }

                            NavigationLink(destination: SignupView()) {
                                Text("Sign Up")
                                    .padding()
                                    .frame(maxWidth: 200)
                                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                                    .background(colorScheme == .dark ? Color.white : Color.black)
                                    .fontWeight(.semibold)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.horizontal)
                        
                        Spacer()

                        Image(systemName: "person.3.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundStyle(Color.primary, Color.accentColor)
                        
                        Text("The entire dataset is processed locally on the device, and subsequently transmitted to the database in an encrypted format.")
                            .multilineTextAlignment(.center)
                            .font(.caption)
                            .foregroundStyle(Color.gray)
                            .padding(.horizontal, 20)
                    }
                    .tag(6)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: selection == 6 ? .never : .always))
                .overlay(
                    Group {
                        if selection < 6 {
                            skipButton
                        }
                    },
                    alignment: .bottom
                )
                .onAppear {
                    setupAppearance()
                }
                
                Spacer()
            }
        }
    }

    private var skipButton: some View {
        Button(action: {
            selection = 6
        }) {
            Image(systemName: "arrowshape.forward.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
                .padding()
        }
        .padding(.bottom, 70)
    }

    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .systemBlue
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemBlue.withAlphaComponent(0.3)
    }
}

struct OnboardingContentScreen: View {
    var imageName: String
    var title: String
    var description: String
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .padding(20)
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 10)
            Text(description)
                .font(.footnote)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
}
