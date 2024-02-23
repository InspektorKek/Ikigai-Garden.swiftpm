import SwiftUI

struct MenuView: View {
    @AppStorage(AppConstants.isOnboardingShownKey) private var isOnboardingShown: Bool = false
    @State private var showARMeditationView: Bool = false
    @State private var onOnboardingFinished: Bool = false
    
    var body: some View {
        ZStack {
            if isOnboardingShown || onOnboardingFinished {
                // Menu
                Button("Start AR Meditation") {
                    showARMeditationView = true
                }
                .onAppear {
                    MusicPlayer.shared.startBackgroundMusic(withFileName: "background_music_main", loopingType: .infinite)
                }
                .fullScreenCover(isPresented: $showARMeditationView) {
                    ARMeditationView()
                }
            } else {
                // Onboarding
                Button("Finish onboarding") {
                    isOnboardingShown = true
                    withAnimation(.easeInOut) {
                        onOnboardingFinished.toggle()
                    }
                }
            }
        }
    }
}

#Preview {
    MenuView()
}
