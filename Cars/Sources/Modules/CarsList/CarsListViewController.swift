//
//  CarsViewController.swift
//  Cars
//
//  Created by Joce on 14.09.2021.
//

import UIKit

protocol CarsViewControllerProtocol: AnyObject {}

final class CarsViewController: UIViewController {
    private var flowLayout: UICollectionViewFlowLayout!
    private var collectionView: UICollectionView!

    private typealias CarCell = CollectionCell<CarView>
    private typealias BrandCell = CollectionCell<BrandView>

    private let interactor: CarsInteractorProtocol

    init(interactor: CarsInteractorProtocol) {
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
        title = "Купить авто"
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
    }
}

extension CarsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % 3 == 0 {
            return CGSize(
                width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
                height: 180
            )
        } else {
            return CGSize(
                width: collectionView.bounds.inset(by: collectionView.layoutMargins).size.width,
                height: 280
            )
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell

        if indexPath.row % 3 == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BrandCell", for: indexPath)
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CarCell", for: indexPath)
        }

        switch cell {
        case let propertyCell as CarCell:
            propertyCell.view.configure(
                viewModel: CarViewModel(
                    id: 1,
                    title: "BMW M8",
                    imageUrl: URL(string: "https://cdn.bmwblog.com/wp-content/uploads/2020/02/Nardo-Grey-BMW-M8-04.jpg"),
                    isPremium: indexPath.row % 2 == 0,
                    horsePowers: "625 л.с.",
                    brand: "BMW",
                    price: "16 150 000 ₽",
                    engineVolume: "4.4 л",
                    mileage: "12 000 км",
                    daysPosted: "3 дня назад"
                )
            )
        case let brandCell as BrandCell:
            brandCell.view.configure(
                viewModel: BrandViewModel(
                    id: 1,
                    title: "BMW",
                    country: "Германия",
                    rating: "Рейтинг: 4.7/5",
                    imageUrl: URL(string: "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f4/BMW_logo_%28gray%29.svg/600px-BMW_logo_%28gray%29.svg.png"),
                    year: "1916 г."
                )
            )
        default:
            fatalError("Unexpected cell type")
        }

        return cell
    }
}

extension CarsViewController: CarsViewControllerProtocol {}
