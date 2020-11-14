import UIKit

protocol MainStocksViewInput: class {
    func setAvaliableBalance(num: Int)
    func setStocksTotal(num: Int)
    func setPage(with page: StocksPage)
}

protocol MainStocksViewOutput: class {
    func didLoadView()
    func didIndexChanged(index: Int)
}

protocol MainStocksRouterInput: class {
    func showAllStocks() -> AllStocksViewController

    func showUserStocks() -> UserStocksViewController
}