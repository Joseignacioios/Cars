//
//  CarsListViewController.swift
//  Cars
//
//  Created by Joce on 14.09.2021.
//

import UIKit

protocol CarsListViewControllerProtocol: AnyObject {
    func show(viewModel: CarsList.ViewModel)
}

final class CarsListViewController: UIViewController {
    private typealias CarCell = CollectionCell<CarView>
    private typealias BrandCell = CollectionCell<BrandView>
    private typealias ViewModel = CarsList.ViewModel

    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()

    private let interactor: CarsListInteractorProtocol
    
    private var cells = [ViewModel.Cell]()

    init(interactor: CarsListInteractorProtocol) {
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
        title = "Buy auto"
        view.backgroundColor = .design(.background(style: .primary))
        flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 20
        flowLayout.sectionInset = UIEdgeInsets(
            top: flowLayout.minimumInteritemSpacing,
            left: 0,
            bottom: 0,
            right: 0
        )
        flowLayout.sectionInsetReference = .fromSafeArea

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = .design(.background(style: .primary))
        collectionView.alwaysBounceVertical = true
        view.addSubview(collectionView)

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(CarCell.self, forCellWithReuseIdentifier: "CarCell")
        collectionView.register(BrandCell.self, forCellWithReuseIdentifier: "BrandCell")
        
        refreshControl.addTarget(self, action: #selector(didPull), for: .valueChanged)
        collectionView.addSubview(refreshControl)
    }

    private func showAlert(viewModel: ViewModel.Alert) {
        let alert = UIAlertController(
            title: viewModel.title,
            message: viewModel.message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: viewModel.retry, style: .default, handler: { _ in
            self.interactor.request(request: .reload)
        }))
        alert.addAction(UIAlertAction(title: viewModel.cancel, style: .cancel, handler: nil))
        present(alert, animated: true)
    }

    @objc private func didPull() {
        refreshControl.endRefreshing()
        interactor.request(request: .reload)
    }
}

extension CarsListViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
            height: cells[indexPath.row].cellHeight
        )

    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewModel = cells[indexPath.row]
        let cell: UICollectionViewCell

        switch viewModel {
        case let .car(viewModel):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath)
            (cell as? CarCell)?.view.configure(viewModel: viewModel)
        case let .brand(viewModel):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath)
            (cell as? BrandCell)?.view.configure(viewModel: viewModel)
        }
        return cell
    }
}



extension CarsListViewController: CarsListViewControllerProtocol {
    func show(viewModel: CarsList.ViewModel) {
        switch viewModel {
        case let .data(cells):
            self.cells = cells
            collectionView.reloadData()
        case let .failure(alert):
            showAlert(viewModel: alert)
        }
    }
}

private extension CarsList.ViewModel.Cell {
    var cellHeight: CGFloat {
        switch self {
        case .car:
            return 280
        case .brand:
            return 180
        }
    }
}
