//
//  CarDetailViewController.swift
//  Cars
//
//  Created by Joce on 19.09.2021.
//

import UIKit

protocol CarDetailViewControllerProtocol: AnyObject {
    func show(viewModel: CarDetail.ViewModel)
}

final class CarDetailViewController: UIViewController {
    private let interactor: CarDetailInteractorProtocol
    private var carView: CarView!

    init(interactor: CarDetailInteractorProtocol) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        interactor.loadData()
    }
    
    private func setup() {
        view.backgroundColor = .design(.background(style: .primary))
        carView = CarView()
        view.addSubview(carView)
        carView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            carView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            carView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            carView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            carView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
}

extension CarDetailViewController: CarDetailViewControllerProtocol {
    func show(viewModel: CarDetail.ViewModel) {
        carView.configure(viewModel: viewModel.car)
        title = viewModel.car.title
    }
}
