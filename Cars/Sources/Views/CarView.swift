//
//  CarView.swift
//  Cars
//
//  Created by Joce on 16.09.2021.
//

import Kingfisher
import UIKit

struct CarViewModel {
    let id: Int

    let title: String
    let imageUrl: URL?
    let isPremium: Bool
    let horsePowers: String
    let brand: String

    let price: String
    let engineVolume: String
    let mileage: String

    let daysPosted: String
}

class CarView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .design(.header(style: .h3))
        titleLabel.textColor = .design(.text(style: .primary))
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 3, for: .vertical)
        return titleLabel
    }()

    private let iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.image = UIImage(named: "Icons/car")
        iconImageView.heightAnchor.constraint(equalToConstant: 12).isActive = true
        iconImageView.widthAnchor.constraint(equalToConstant: 12).isActive = true
        iconImageView.tintColor = .purple
        return iconImageView
    }()

    private let brandLabel: UILabel = {
        let brandLabel = UILabel()
        brandLabel.font = .design(.paragraph(style: .p2))
        brandLabel.textColor = .design(.text(style: .secondary))
        brandLabel.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return brandLabel
    }()

    private let detailsLabel: UILabel = {
        let detailsLabel = UILabel()
        detailsLabel.font = .design(.paragraph(style: .p2))
        detailsLabel.textColor = .design(.text(style: .primary))
        detailsLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .vertical)
        detailsLabel.setContentCompressionResistancePriority(.defaultHigh - 1, for: .horizontal)
        detailsLabel.setContentHuggingPriority(.defaultLow + 1, for: .horizontal)
        return detailsLabel
    }()

    private let timeLabel: UILabel = {
        let timeLabel = UILabel()
        timeLabel.font = .design(.paragraph(style: .p2))
        timeLabel.textColor = .design(.text(style: .primary))
        timeLabel.setContentCompressionResistancePriority(.defaultHigh + 1, for: .horizontal)
        timeLabel.setContentHuggingPriority(.defaultLow + 2, for: .horizontal)
        return timeLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        backgroundColor = .design(.background(style: .primary))
        let areaStackView = UIStackView(arrangedSubviews: [iconImageView, brandLabel])
        areaStackView.spacing = .horizontalStackSpacing
        areaStackView.axis = .horizontal

        let detailsStackView = UIStackView(arrangedSubviews: [detailsLabel, timeLabel])
        detailsStackView.spacing = .horizontalStackSpacing
        detailsStackView.axis = .horizontal

        let stackView = UIStackView(arrangedSubviews: [imageView, titleLabel, areaStackView, detailsStackView])
        stackView.axis = .vertical
        stackView.frame = bounds
        stackView.spacing = .verticalStackSpacing
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(viewModel: CarViewModel) {
        titleLabel.text = viewModel.title
        brandLabel.text = viewModel.brand
        detailsLabel.text = [viewModel.price, viewModel.engineVolume, viewModel.horsePowers, viewModel.mileage].commaSeparated
        timeLabel.text = viewModel.daysPosted
        if viewModel.isPremium {
            imageView.layer.borderWidth = .premiumBorderWidth
            imageView.layer.borderColor = UIColor.design(.constant(style: .premium)).cgColor
        } else {
            imageView.layer.borderWidth = 0
            imageView.layer.borderColor = nil
        }
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
}

private extension CGFloat {
    static let verticalStackSpacing: CGFloat = 5
    static let horizontalStackSpacing: CGFloat = 5
    static let premiumBorderWidth: CGFloat = 2.5
}
