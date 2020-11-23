import Foundation
import UIKit

class UserStocksViewController: UIViewController, UINavigationControllerDelegate {
    private var tableView = UITableView()

    var output: UserStocksViewOutput!
    private let refreshControl = UIRefreshControl()
    private let activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
        output?.didLoadView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "StockTableViewCell", bundle: nil), forCellReuseIdentifier: StockTableViewCell.reuseIdentifier)
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupActivityIndicatorView()
    }

    private func setupActivityIndicatorView() {
        activityIndicatorView.color = .black
        self.activityIndicatorView.center = CGPoint(x: UIScreen.main.bounds.size.width / 2, y: UIScreen.main.bounds.size.height / 2)
            activityIndicatorView.hidesWhenStopped = true

    }

    private func setupView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.separatorStyle = .none
    }

    @objc private func refreshData(_ sender: Any) {
        output?.refreshData()
    }

}

extension UserStocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.output?.numberOfItems() ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: StockTableViewCell.reuseIdentifier, for: indexPath) as? StockTableViewCell else {
            return UITableViewCell()
        }
        guard let viewModel = output?.stock(at: indexPath) else { return UITableViewCell() }
        cell.setData(data: viewModel)
        return cell

    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let symbol: String = output?.stock(at: indexPath)?.stockSymbol ?? "Unknown"
        output?.didTapOnStock(symbol: symbol)
    }

}

extension UserStocksViewController: UserStocksViewInput {
    func reloadTable() {
        self.tableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func startActivity() {
        activityIndicatorView.startAnimating()
    }
    func endActivity() {
        activityIndicatorView.stopAnimating()
    }
}
