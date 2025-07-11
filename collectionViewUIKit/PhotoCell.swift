
import UIKit

final class PhotoCell: UICollectionViewCell {
    static let identifier = "PhotoCell"

    private let imageView = UIImageView()
    private let titleLabel = UILabel()
    private let favoriteButton = UIButton(type: .system)

    var onFavoriteToggle: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupViews() {
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 8
        contentView.clipsToBounds = true

        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true

        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textAlignment = .center

        favoriteButton.tintColor = .systemRed
        favoriteButton.addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)

        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(favoriteButton)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: 0, y: 0, width: contentView.bounds.width, height: contentView.bounds.width)
        titleLabel.frame = CGRect(x: 0, y: imageView.frame.maxY, width: contentView.bounds.width, height: 20)
        favoriteButton.frame = CGRect(x: contentView.bounds.width - 30, y: 5, width: 25, height: 25)
    }

    @objc private func toggleFavorite() {
        onFavoriteToggle?()
    }

    func configure(with photo: Photo) {
        imageView.image = UIImage(named: photo.imageName)
        titleLabel.text = photo.title
        let heartImage = UIImage(systemName: photo.isFavorite ? "heart.fill" : "heart")
        favoriteButton.setImage(heartImage, for: .normal)
    }
}
