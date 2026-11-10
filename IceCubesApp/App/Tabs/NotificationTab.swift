import DesignSystem
import Env
import Models
import NetworkClient
import Notifications
import SwiftUI
import Timeline

@MainActor
struct NotificationsTab: View {
  @Environment(Theme.self) private var theme
  @Environment(MastodonClient.self) private var client
  @Environment(CurrentAccount.self) private var currentAccount
  @State private var routerPath = RouterPath()

  @Binding var selectedTab: AppTab

  let lockedType: Models.Notification.NotificationType?

  var body: some View {
    NavigationStack(path: $routerPath.path) {
      NotificationsListView(lockedType: lockedType)
        .rootTabScrollEdgeEffect()
        .withAppRouter()
        .withSheetDestinations(
          sheetDestinations: $routerPath.presentedSheet,
          routerPath: routerPath
        )
        .toolbar {
          if #available(iOS 26.0, *) {
            ToolbarSpacer(placement: .topBarTrailing)
          }
          ToolbarTab(routerPath: $routerPath)
        }
        .id(client.id)
    }
    .onAppear {
      routerPath.client = client
    }
    .withSafariRouter()
    .environment(routerPath)
    .onChange(of: client.id) {
      routerPath.path = []
    }
  }
}
