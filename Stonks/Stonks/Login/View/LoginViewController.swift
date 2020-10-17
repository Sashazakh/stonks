import UIKit

class LoginViewController: UIViewController {
    var output: LoginViewOutput?

    @IBOutlet private weak var welcomeImageView: UIImageView!

    @IBOutlet private weak var nameTextField: UITextField!

    @IBOutlet private weak var surnameTextField: UITextField!

    @IBOutlet private weak var balanceTextField: UITextField!

    @IBOutlet private weak var checkBoxImageView: UIImageView!

    @IBOutlet private weak var checkBoxDescriptionLabel: UILabel!

    @IBOutlet private weak var registerButton: UIButton!

    private func setupNameTextField() {
        nameTextField.attributedPlaceholder = NSAttributedString(string: Constants.namePlaceholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.NameTextField.placeholderColor])

        nameTextField.clipsToBounds = Constants.NameTextField.clipsToBounds
        nameTextField.layer.cornerRadius = Constants.NameTextField.cornerRadius
        nameTextField.layer.borderWidth = Constants.NameTextField.borderWidth
        nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        nameTextField.backgroundColor = Constants.defaultStyleEntriesColor

        nameTextField.addTarget(self, action: #selector(didStartNameEditing), for: .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(didFinishNameEditing), for: .editingDidEnd)
    }

    private func setupSurnameTextField() {
        surnameTextField.attributedPlaceholder = NSAttributedString(string: Constants.surnamePlaceholderText,
                                                                 attributes: [NSAttributedString.Key.foregroundColor: Constants.SurnameTextField.placeholderColor])

        surnameTextField.clipsToBounds = Constants.SurnameTextField.clipsToBounds
        surnameTextField.layer.cornerRadius = Constants.SurnameTextField.cornerRadius
        surnameTextField.layer.borderWidth = Constants.SurnameTextField.borderWidth
        surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor

        surnameTextField.addTarget(self, action: #selector(didStartSurnameEditing), for: .editingDidBegin)
        surnameTextField.addTarget(self, action: #selector(didFinishSurnameEditing), for: .editingDidEnd)
    }

    private func setupBalanceTextField() {
        balanceTextField.attributedPlaceholder = NSAttributedString(string: Constants.balancePlaceholderText,
                                                                    attributes: [NSAttributedString.Key.foregroundColor: Constants.BalanceTextField.placeholderColor])

        balanceTextField.clipsToBounds = Constants.BalanceTextField.clipsToBounds
        balanceTextField.layer.cornerRadius = Constants.BalanceTextField.cornerRadius
        balanceTextField.layer.borderWidth = Constants.BalanceTextField.borderWidth
        balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor

        balanceTextField.addTarget(self, action: #selector(didStartBalanceEditing), for: .editingDidBegin)
        balanceTextField.addTarget(self, action: #selector(didFinishBalanceEditing), for: .editingDidEnd)
    }

    private func setupCheckBoxImageView() {
        let boxTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapCheckBox))

        boxTapRecognizer.numberOfTapsRequired = Constants.CheckBoxImageView.recognizerTapsRequired
        checkBoxImageView.addGestureRecognizer(boxTapRecognizer)
        checkBoxImageView.isUserInteractionEnabled = Constants.CheckBoxImageView.isUserInteractionEnabled
    }

    private func setupRegisterButton() {
        registerButton.layer.cornerRadius = Constants.RegisterButton.cornerRadius
        registerButton.layer.shadowOffset = Constants.RegisterButton.shadowOffset
        registerButton.layer.shadowRadius = Constants.RegisterButton.cornerRadius
        registerButton.layer.shadowColor = Constants.RegisterButton.shadowColor.cgColor
        registerButton.layer.shadowOpacity = Constants.RegisterButton.shadowOpacity

        registerButton.addTarget(self, action: #selector(didTapRegisterButton), for: .touchUpInside)
    }

    private func setupSubviews() {
        setupNameTextField()
        setupSurnameTextField()
        setupBalanceTextField()
        setupCheckBoxImageView()
        setupRegisterButton()
    }

    private func setupView() {
        let viewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapView))

        viewTapRecognizer.numberOfTapsRequired = Constants.TapRecognizer.tapsRequired
        view.addGestureRecognizer(viewTapRecognizer)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        output?.didLoadView()

        setupSubviews()
        setupView()
    }

    @objc private func didTapView() {
        output?.didTapView()
    }

    @objc private func didTapCheckBox() {
        output?.didTapCheckBox()
    }

    @objc private func didStartNameEditing() {
        output?.didStartNameEditing()
    }

    @objc private func didFinishNameEditing() {
        output?.didFinishNameEditing()
    }

    @objc private func didStartSurnameEditing() {
        output?.didStartSurnameEditing()
    }

    @objc private func didFinishSurnameEditing() {
        output?.didFinishSurnameEditing()
    }

    @objc private func didStartBalanceEditing() {
        output?.didStartBalanceEditing()
    }

    @objc private func didFinishBalanceEditing() {
        output?.didFinishBalanceEditing()
    }

    @IBAction private func didTapRegisterButton(_ sender: UIButton) {
        output?.didTapRegisterButton(name: nameTextField.text, surname: surnameTextField.text, balance: balanceTextField.text)
    }
}

extension LoginViewController: LoginViewInput {
    func setCheckBoxImage(isChecked: Bool) {
        let checkBoxImageName: String = isChecked ?
            Constants.checkBoxIsCheckedImageName : Constants.checkBoxNotCheckedImageName

        checkBoxImageView.image = UIImage(named: checkBoxImageName)
    }

    func showAlert(with title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "ОК", style: .default, handler: nil))

        present(alert, animated: true)
    }

    func setNameTextField(isEditing: Bool) {
        if isEditing {
            nameTextField.backgroundColor = Constants.editingStyleEntriesColor
            nameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            nameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            nameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func setSurnameTextField(isEditing: Bool) {
        if isEditing {
            surnameTextField.backgroundColor = Constants.editingStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            surnameTextField.backgroundColor = Constants.defaultStyleEntriesColor
            surnameTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func setBalanceTextField(isEditing: Bool) {
        if isEditing {
            balanceTextField.backgroundColor = Constants.editingStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.editingStyleEntriesBorderColor.cgColor
        } else {
            balanceTextField.backgroundColor = Constants.defaultStyleEntriesColor
            balanceTextField.layer.borderColor = Constants.defaultStyleEntriesColor.cgColor
        }
    }

    func disableKeyboard() {
        view.endEditing(true)
    }
}

extension LoginViewController {
    private struct Constants {
        static let defaultStyleEntriesColor: UIColor = UIColor(red: 250 / 255,
                                                               green: 250 / 255,
                                                               blue: 250 / 255,
                                                               alpha: 1)

        static let editingStyleEntriesBorderColor: UIColor = UIColor(red: 113 / 255,
                                                                     green: 101 / 255,
                                                                     blue: 227 / 255,
                                                                     alpha: 1)

        static let editingStyleEntriesColor: UIColor = UIColor(red: 113 / 255,
                                                               green: 101 / 255,
                                                               blue: 227 / 255,
                                                               alpha: 0.2)

        struct NameTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct SurnameTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct BalanceTextField {
            static let clipsToBounds: Bool = true
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let placeholderColor: UIColor = .black
        }

        struct RegisterButton {
            static let cornerRadius: CGFloat = 10
            static let borderWidth: CGFloat = 1
            static let shadowOffset: CGSize = CGSize(width: 5, height: 5)
            static let shadowColor: UIColor = .gray
            static let shadowOpacity: Float = 1
        }

        struct CheckBoxImageView {
            static let recognizerTapsRequired: Int = 1

            static let isUserInteractionEnabled: Bool = true
        }

        static let namePlaceholderText = String(repeating: " ", count: 5) + "Name"
        static let surnamePlaceholderText = String(repeating: " ", count: 5) + "Surname"
        static let balancePlaceholderText = String(repeating: " ", count: 5) + "Start Balance"

        static let checkBoxIsCheckedImageName: String = "checkBoxChecked"
        static let checkBoxNotCheckedImageName: String = "checkBoxNotChecked"

        struct TapRecognizer {
            static let tapsRequired: Int = 1
        }
    }
}