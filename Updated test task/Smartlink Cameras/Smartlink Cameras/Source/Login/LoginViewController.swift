//
//  LoginViewController.swift
//  Smartlink Cameras
//
//  Created by SecureNet Mobile Team on 1/10/20.
//  Copyright © 2020 SecureNet Technologies, LLC. All rights reserved.
//

import RxSwift
import UIKit

final class LoginViewController: RxViewController, ViewModelAttachingProtocol, KeyboardDismissableOnTap, MoveUpScreenWhenKeyboardAppears {
    // MARK: - Conformance to ViewModelAttachingProtocol
    var bindings: LoginViewModel.Bindings {
        LoginViewModel.Bindings(loginButtonTap: logInBtn.rx.tap.asObservable(),
                                loginNameChanged: loginTxtFld.rx.text.asObservable())
    }
    
    var viewModel: Attachable<LoginViewModel>!
    
    func configureReactiveBinding(viewModel: LoginViewModel) -> LoginViewModel {
        return viewModel
    }
    
    
    // MARK: - Logic variables
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - UI variables
    fileprivate var areConstraintsSet: Bool = false
    
//    fileprivate lazy var loginButton: UIButton = {
//        let button = UIButton(type: .custom)
//        button.setTitle(NSLocalizedString("Login", comment: "Login button text"), for: .normal)
//        button.setTitleColor(.gray, for: .normal)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()

    fileprivate lazy var backgroundImg: UIImageView = {
        let backgroundImage = UIImageView(image: UIImage(named: "loginBackground"))
        backgroundImage.contentMode = .scaleToFill
        return backgroundImage
    }()

    fileprivate lazy var paddingView1: UIView = {
        let padding = UIView()
        return padding
    }()

    #warning("Localisation is required")
    fileprivate lazy var loginTxtFld: UITextField = {
        let txtFld = UITextField()
        txtFld.placeholder = "Username"
        return txtFld
    }()
    
    #warning("Localisation is required")
    fileprivate lazy var passwordTxtFld: UITextField = {
        let txtFld = UITextField()
        txtFld.placeholder = "Password"
        return txtFld
    }()

    #warning("Localisation is required")
    fileprivate lazy var checkBox: Checkbox = {
        let checkBox = Checkbox()
        checkBox.text = "Remember Me"
        return checkBox
    }()

    #warning("Localisation is required")
    fileprivate lazy var forgotPasswordLbl: UILabel = {
        let forgotLbl = UILabel()
        forgotLbl.text = "Forgot password?"
        forgotLbl.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return forgotLbl
    }()

    fileprivate lazy var paddingView2: UIView = {
        let padding = UIView()
        padding.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return padding
    }()

    #warning("Localisation is required")
    fileprivate lazy var logInBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor(red: 0.2, green: 0.3569, blue: 0.4, alpha: 1.0)
        btn.setTitleColor(.black, for: .normal)
        btn.setTitleColor(.lightGray, for: .highlighted)
        btn.setTitle("Sign In", for: .normal)
        return btn
    }()

    #warning("Localisation is required")
    fileprivate lazy var bottomLbl: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.text = "Installing a DIY System? Get Started"
        return lbl
    }()
    
    
    // MARK: - Init
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if !areConstraintsSet {
            areConstraintsSet = true
            configureConstraints()
        }
    }

    override func setupViews() {
        hideKeyboardWhenTappedAround(bag: bag)
        setupMoveUp()
        configureAppearance()
        configureBackgroundStack()
    }

    override func setupRxBindings() {

    }

    deinit {
        
    }
}

fileprivate extension LoginViewController {
    func configureAppearance() {
        view.backgroundColor = .white
    }

    func configureBackgroundStack() {
        let backgroundStack = UIStackView()
        backgroundStack.axis = .vertical
        backgroundStack.spacing = 0
        backgroundStack.place(in: self.view)

        backgroundStack.addArrangedSubview(backgroundImg)
        backgroundStack.addArrangedSubview(configureBottomPart())
    }

    func configureBottomPart() -> UIStackView {
        let bottomStack = UIStackView()
        bottomStack.axis = .vertical
        bottomStack.spacing = Constants.innerElementsSpacing
        bottomStack.layoutMargins = UIEdgeInsets(top: 0, left: Constants.topBottomMinimalPadding, bottom: 0, right: Constants.topBottomMinimalPadding)
        bottomStack.isLayoutMarginsRelativeArrangement = true

        bottomStack.addArrangedSubview(paddingView1)
        bottomStack.addArrangedSubview(loginTxtFld)
        bottomStack.addArrangedSubview(passwordTxtFld)
        bottomStack.addArrangedSubview(configureCheckboxPanel())
        bottomStack.addArrangedSubview(paddingView2)
        bottomStack.addArrangedSubview(logInBtn)
        bottomStack.addArrangedSubview(bottomLbl)
        return bottomStack
    }

    func configureCheckboxPanel() -> UIStackView {
        let checkBoxPanel = UIStackView()
        checkBoxPanel.axis = .horizontal

        checkBoxPanel.addArrangedSubview(checkBox)
        checkBoxPanel.addArrangedSubview(forgotPasswordLbl)
        return checkBoxPanel
    }

    func configureConstraints() {
        NSLayoutConstraint.activate([
            backgroundImg.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.5),
            paddingView1.heightAnchor.constraint(equalToConstant: Constants.topBottomMinimalPadding),
            loginTxtFld.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            passwordTxtFld.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight),
            paddingView2.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.topBottomMinimalPadding),
            logInBtn.heightAnchor.constraint(equalToConstant: Constants.textFieldHeight)
        ])
    }
}
