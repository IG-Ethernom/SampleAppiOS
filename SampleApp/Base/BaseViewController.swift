//
//  BaseViewController.swift
//  EthernomCore
//
//  Created by Puttheavy tep on 10/12/22.
//

import UIKit

class BaseViewController: UIViewController {
    var mCoreInternet: CoreInternet?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground //.init(hexString: .colorBackground)
        navigationController?.navigationBar.tintColor = UIColor.black
        
        enableSwap()
        hideLoading()
    }
    
    func enableSwap() {
        // enable swap
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
    }
    
    func setupBackNavigation() {
        let button = UIButton()
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func handleBackButton() {
        view.endEditing(true)
        navigationController?.popViewController(animated: true)
    }
    
    func setupDefaultNavigation(title: String, tint: UIColor? = .white){
        let backButton = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: self, action:  #selector(handleBackButton))
        navigationItem.leftBarButtonItem = backButton
        navigationItem.title = title
        
        navigationItem.leftBarButtonItem?.tintColor = tint
        navigationItem.rightBarButtonItem?.tintColor = tint
        
    }
    
    func setNavBarAppearance(tintColor: UIColor, barColor: UIColor) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = barColor
      //  appearance.titleTextAttributes = [.foregroundColor: tintColor]
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().isTranslucent = false
      //  UINavigationBar.appearance().tintColor = tintColor
        
      //  navigationItem.leftBarButtonItem?.tintColor = .white
       // navigationItem.rightBarButtonItem?.tintColor = .white
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    func setupCustomNavigationBar(title: String) {
        view.addSubview(defaultNavigation)
        defaultNavigation.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, size: CGSize(width: 0, height: Int(navBarHeight)))
        if !title.isEmpty {
            defaultNavigation.titleLabel.text = title
        }
    }
    
    lazy var defaultNavigation: NavigationView = {
        let nav = NavigationView()
        nav.translatesAutoresizingMaskIntoConstraints = false
        nav.backButton.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        return nav
    }()
    
    func presentToViewController(controller: UIViewController) {
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        nav.hidesBottomBarWhenPushed = true
        nav.isModalInPresentation = true
        navigationController?.present(nav, animated: true)
    }
    
    func pushToViewController(controller: UIViewController) {
        let viewController = controller
        viewController.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func dismissViewController(completion: (() -> Void)?) {
        dismiss(animated: true, completion: completion)
    }
    
    func pushBackController() {
        navigationController?.popViewController(animated: true)
    }
    
    func popBackToController(controller: UIViewController) {
        navigationController?.popToViewController(controller, animated: true)
    }
    
    func setToRootView(viewController: UIViewController) {
        if let mWindow = UIWindow.key {
            mWindow.rootViewController = viewController
            // A mask of options indicating how you want to perform the animations.
            let options: UIView.AnimationOptions = .transitionCrossDissolve
            
            // The duration of the transition animation, measured in seconds.
            let duration: TimeInterval = 0.3
            
            // Creates a transition animation.
            // Though `animations` is optional, the documentation tells us that it must not be nil. ¯\_(ツ)_/¯
            UIView.transition(with: mWindow, duration: duration, options: options, animations: {})
        }
    }
    
    func configureSearchController(searchController: UISearchController) {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        
        // Sets this view controller as presenting view controller for the search interface
        definesPresentationContext = true
        
        searchController.loadViewIfNeeded()
        
        searchController.searchBar.placeholder = "Search here ..."
        searchController.searchBar.sizeToFit()
        
        searchController.searchBar.searchTextField.font = UIFont.NunitoFont_Regular(13)
        searchController.searchBar.searchTextField.backgroundColor = .white
        
        //Adiciona a barra do Controlador de Busca a barra do navegador
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
}


// MARK: - HELPER FUNCTION
extension BaseViewController {
    func handleInternetConnection(completed: @escaping (() -> Void)) -> Bool{
        if Network.isConnectedToNetwork() {
            return true
        }else {
            UIAlertController.showConfirmationAlert(title: LanguageString.error.LOCALIZE_STRING, message: LanguageString.INTERNET.LOCALIZE_STRING, action: .ok, {
                completed()
            }, in: self)
            return false
        }
        
    }
    
    // ========= LOADING ============
    func showLoading(message: String) {
        Indicator.sharedInstance.showIndicator(message: "\(message)...")
    }
    
    func hideLoading() {
        Indicator.sharedInstance.hideIndicator()
    }
    
    // ====== ALERT MESSAGE ============
    func showDefaultMessageAlert(title: String? = LanguageString.error.LOCALIZE_STRING, message: String) {
        DispatchQueue.main.async {
            self.hideLoading()
            UIAlertController.showConfirmationAlert(title: title!, message: message, action: .ok, {}, in: self)
        }
    }
    
    func showExitMessageAlert(title: String? = LanguageString.error.LOCALIZE_STRING, message: String) {
        DispatchQueue.main.async {
            self.hideLoading()
            UIAlertController.showConfirmationAlert(title: title!, message: message, action: .exit, {}, in: self)
        }
    }
    
    // ====== NOTIFICATION CENTER ===========
    func sendBroadcast(act: NSNotification.Name,_ data: [String: Any]? = [:]) {
        if data != nil {
            NotificationCenter.default.post(name: act, object: nil, userInfo: data!)
            return
        }
        NotificationCenter.default.post(name: act, object: nil)
    }
    
}

//MARK: - UIGestureRecognizerDelegate
extension BaseViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
