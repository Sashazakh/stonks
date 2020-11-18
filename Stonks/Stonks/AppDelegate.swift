import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        guard let url = URL(string: "KMN") else { return true }
//        StockHistoryDataService.shared.createHistoryStock(name: "SELL", symbol: "dsds", price: 5000, type: .sold, imageUrl: url)

        self.window?.rootViewController = getInitalViewController(isAuthorized: AuthorizationService.shared.userIsAuthorized())

        self.window?.makeKeyAndVisible()
        return true
    }
}

extension AppDelegate {
    func getInitalViewController(isAuthorized: Bool) -> UIViewController {
        if isAuthorized {
            let tabBarVC = MainTabBar()

            tabBarVC.modalPresentationStyle = .fullScreen

            return tabBarVC
        } else {
            let context = LoginContext(isChecked: false)
            let container = LoginContainer.assemble(with: context)

            return container.viewController
        }
    }
}

extension AppDelegate {
    func reloadUserData() {
        AuthorizationService.shared.deAuthorize()

        let context = LoginContext(isChecked: false)
        let container = LoginContainer.assemble(with: context)

        self.window?.rootViewController = container.viewController
    }
}
