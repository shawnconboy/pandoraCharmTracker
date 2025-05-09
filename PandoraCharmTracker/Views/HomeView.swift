import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            AllCharmsView()
                .tabItem {
                    Label("All Charms", systemImage: "sparkles")
                }

            ProfileView()
                .tabItem {
                    Label("My Profile", systemImage: "person.crop.circle")
                }
        }
        .onAppear {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor(Color.pandoraSoftPink)

            // Shadow for legibility
            let textShadow = NSShadow()
            textShadow.shadowColor = UIColor.black.withAlphaComponent(0.2)
            textShadow.shadowOffset = CGSize(width: 0.5, height: 0.5)
            textShadow.shadowBlurRadius = 1

            // Inactive state
            let normalAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(Color.pandoraPink.opacity(0.5)),
                .font: UIFont.systemFont(ofSize: 11),
                .shadow: textShadow
            ]

            // Active state
            let selectedAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(Color.pandoraPink),
                .font: UIFont.boldSystemFont(ofSize: 11),
                .shadow: textShadow
            ]

            appearance.stackedLayoutAppearance.normal.iconColor = UIColor(Color.pandoraPink.opacity(0.5))
            appearance.stackedLayoutAppearance.selected.iconColor = UIColor(Color.pandoraPink)

            appearance.stackedLayoutAppearance.normal.titleTextAttributes = normalAttributes
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = selectedAttributes

            UITabBar.appearance().standardAppearance = appearance
            if #available(iOS 15.0, *) {
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}
