import UIKit

class MainTabBar: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTabBar()
        prepareViewControllers()
    }

    private func setupTabBar() {
        tabBar.tintColor = Constants.tintColor
        tabBar.unselectedItemTintColor = Constants.tintColor
    }

    private func prepareViewControllers() {
        viewControllers = [prepareLearnViewController(),
                           prepareMyStocksViewController(),
                           prepareNewsViewController(),
                           prepareMePortfoiolViewController()]
    }

    private func prepareLearnViewController() -> UINavigationController {
        let viewController = UIViewController()

        let tabBarItem = UITabBarItem(title: Constants.LearnBarItem.title,
                                      image: UIImage(named: Constants.LearnBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.LearnBarItem.tag)

        viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareMyStocksViewController() -> UINavigationController {
        let stockRaw = StockRaw(stockName: "Apple", stockSymbol: "AAPL", stockPrice: 432, imageUrl: "")
        let stock = Stock(with: stockRaw)

        let container = MyStocksContainer.assemble(with: MyStocksContext(testmodel: [stock]))
        let tabBarItem = UITabBarItem(title: Constants.MyStocksBarItem.title,
                                      image: UIImage(named: Constants.MyStocksBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.MyStocksBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareNewsViewController() -> UINavigationController {
        let viewController = UIViewController()

        let tabBarItem = UITabBarItem(title: Constants.NewsBarItem.title,
                                      image: UIImage(named: Constants.NewsBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.NewsBarItem.tag)

        viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }

    private func prepareMePortfoiolViewController() -> UINavigationController {
        let container = MeContainer.assemble(with: MeContext())
        let tabBarItem = UITabBarItem(title: Constants.MeBarItem.title,
                                      image: UIImage(named: Constants.MeBarItem.imageName)?.withRenderingMode(.alwaysOriginal),
                                      tag: Constants.MeBarItem.tag)

        container.viewController.tabBarItem = tabBarItem

        let navigationVC = UINavigationController(rootViewController: container.viewController)

        navigationVC.navigationBar.isHidden = true

        return navigationVC
    }
}

extension MainTabBar {
    private struct Constants {
        static let tintColor: UIColor = UIColor(red: 113 / 255,
                                                green: 101 / 255,
                                                blue: 227 / 255,
                                                alpha: 1)

        struct LearnBarItem {
            static let title: String = "Learn"
            static let imageName: String = "learn"
            static let tag: Int = 0
        }

        struct MyStocksBarItem {
            static let title: String = "Stocks"
            static let imageName: String = "stocks"
            static let tag: Int = 1
        }

        struct NewsBarItem {
            static let title: String = "News"
            static let imageName: String = "news"
            static let tag: Int = 2
        }

        struct MeBarItem {
            static let title: String = "Me"
            static let imageName: String = "me"
            static let tag: Int = 3
        }
    }
}