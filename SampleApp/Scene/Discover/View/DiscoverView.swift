//
//  
//  DiscoverView.swift
//  SampleApp
//
//  Created by Puttheavy tep on 24/3/2566 BE.
//
//
import UIKit
class DiscoverUIView: BaseView {
    
    override func setupView() {
        setupTableView()
    }
    
    func setupTableView() {
        addSubviews([headerView,tableView,footerView,bluetoothView])
        
        headerView.anchor(top: safeAreaLayoutGuide.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: self.trailingAnchor)
        headerView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        tableView.anchor(top: headerView.bottomAnchor, leading: self.leadingAnchor, bottom: bluetoothView.topAnchor, trailing: self.trailingAnchor)
        
        
        bluetoothView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        bluetoothView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bluetoothView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bluetoothView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        
        footerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        footerView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        footerView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        footerView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.sectionFooterHeight = 0
        table.sectionHeaderHeight = 0
        table.backgroundColor = .white
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    private lazy var headerView: DeviceHeaderView = {
        let view = DeviceHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    lazy var bluetoothView: BluetoothFooterView = {
        let view = BluetoothFooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hexString: "#EF5350")
        view.isHidden = true
        view.layoutIfNeeded()
        return view
    }()
    
    lazy var footerView: DeviceFooterView = {
        let view = DeviceFooterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .init(hexString: .colorPrimary)
        
        view.layoutIfNeeded()
        return view
    }()
}

class DeviceHeaderView: BaseView {
    override func setupUI() {
        let view = [titleLabel, loading,borderView]
        addSubviews(view)
        loading.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        loading.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: loading.trailingAnchor, constant: 10).isActive = true
        borderView.anchor(top: titleLabel.bottomAnchor, leading: safeAreaLayoutGuide.leadingAnchor, bottom: self.bottomAnchor, trailing: safeAreaLayoutGuide.trailingAnchor)
        borderView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.SEARCH_FOR_NEARBY.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var loading: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.color = .gray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }()
    
    private lazy var borderView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(hexString: "#E0E0E0")
        return view
    }()
}


class DeviceFooterView: BaseView {
    override func setupUI() {
        let view = [titleLabel, image]
        addSubviews(view)
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.GUIDE_DESC.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "infocircle")
        return image
    }()
}


class BluetoothFooterView: BaseView {
    override func setupUI() {
        let view = [titleLabel,descLabel, image]
        addSubviews(view)
       
        let height = descLabel.heightForView(text: descLabel.text!, width: UIScreen.main.bounds.width - 40)
        
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        descLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        descLabel.trailingAnchor.constraint(equalTo: image.leadingAnchor, constant: -10).isActive = true
        descLabel.heightAnchor.constraint(equalToConstant: height).isActive = true
        
        image.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        image.widthAnchor.constraint(equalToConstant: 24).isActive = true
        image.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.TURN_ON_BLUETOOTH.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.setLabel(title: LanguageString.TURN_ON_BLUETOOTH_DESC.LOCALIZE_STRING)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrowright2")
        return image
    }()
}
