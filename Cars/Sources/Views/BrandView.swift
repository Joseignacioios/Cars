//
//  BrandView.swift
//  Cars
//
//  Created by Joce on 16.09.2021.
//

import Kingfisher
import UIKit

struct BrandViewModel {
    let id: Int
    let title: String
    let country: String
    let rating: String
    let imageUrl: URL?
    let year: String
}

final class BrandView: UIView {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .design(.header(style: .h1))
        titleLabel.textColor = .design(.text(style: .primary))
        titleLabel.setContentCompressionResistancePriority(.defaultHigh + 4, for: .vertical)
        return titleLabel
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 6
        imageView.clipsToBounds = true
        imageView.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return imageView
    }()

    private let countryLabel: UILabel = {
        let countryLabel = UILabel()
        countryLabel.font = .design(.header(style: .h2))
        countryLabel.textColor = .design(.text(style: .primary))
        countryLabel.setContentCompressionResistancePriority(.defaultHigh + 3, for: .vertical)
        return countryLabel
    }()

    private let ratingLabel: UILabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = .design(.paragraph(style: .p1))
        ratingLabel.textColor = .design(.text(style: .primary))
        ratingLabel.setContentCompressionResistancePriority(.defaultHigh + 2, for: .vertical)
        return ratingLabel
    }()

    private let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.font = .design(.paragraph(style: .p1))
        yearLabel.textColor = .design(.text(style: .primary))
        return yearLabel
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
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            imageView,
            countryLabel,
            ratingLabel,
            yearLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 5
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    func configure(viewModel: BrandViewModel) {
        titleLabel.text = viewModel.title
        countryLabel.text = viewModel.country
        ratingLabel.text = viewModel.rating
        yearLabel.text = viewModel.year
        imageView.kf.setImage(with: viewModel.imageUrl)
    }
}
