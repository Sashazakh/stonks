import UIKit

enum MeSettingsSections: Int, CaseIterable {
    case deposit = 0, changeName, reportError, resetData, about

    var info: String {
        switch self {
        case .about:
            return "About"
        case .deposit:
            return "Deposit"
        case .changeName:
            return "ChangeName"
        case .reportError:
            return "Report Error"
        case .resetData:
            return "Reset Data"
        }
    }
}

class MeSettingsViewController: UIViewController {
    private var tableView = UITableView()

    var presenter: MeSettingsOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupTableView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self

        let chartNib = UINib(nibName: SettingsTableViewCell.reuseIdentifier, bundle: nil)
        tableView.register(chartNib, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
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
}

extension MeSettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return MeSettingsSections.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MeSettingsViewController.Constants.numberOfRowsInSection
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else { return UITableViewCell() }
        guard let label = MeSettingsSections(rawValue: indexPath.section)?.info else { return UITableViewCell() }
        cell.configureCell(label: label)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: MeSettingsViewController.Constants.distanceBetweenCells))
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MeSettingsViewController.Constants.settingCellHeight
    }
}

extension MeSettingsViewController: MeSettingsInput {

}

extension MeSettingsViewController {
    struct Constants {
        static let numberOfRowsInSection: Int = 1
        static let settingCellHeight: CGFloat = 60
        static let distanceBetweenCells: CGFloat = 30
    }
}
