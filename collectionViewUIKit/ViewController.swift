
import UIKit

final class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    private var photos: [Photo] = []
    private var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Photo Gallery"
        configurePhotos()
        configureCollectionView()
    }

    private func configurePhotos() {
        photos = [
            Photo(imageName: "image1", title: "Sunset", date: Date(), isFavorite: false),
            Photo(imageName: "image2", title: "Forest", date: Date(), isFavorite: false),
            Photo(imageName: "image3", title: "Beach", date: Date(), isFavorite: true),
            Photo(imageName: "image4", title: "Mountains", date: Date(), isFavorite: false)
        ]
    }

    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)

        view.addSubview(collectionView)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            fatalError("Unable to dequeue PhotoCell")
        }
        let photo = photos[indexPath.item]
        cell.configure(with: photo)
        cell.onFavoriteToggle = { [weak self] in
            self?.photos[indexPath.item].isFavorite.toggle()
            let name = photo.title
            let message = self?.photos[indexPath.item].isFavorite == true ? "Marked \(name) as Favorite!" : "Removed \(name) from Favorites."
            let alert = UIAlertController(title: "Favorite Updated", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
            self?.collectionView.reloadItems(at: [indexPath])
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsPerRow: CGFloat = UIDevice.current.orientation.isLandscape ? 5 : 3
        let padding: CGFloat = 10 * (itemsPerRow + 1)
        let availableWidth = view.bounds.width - padding
        let widthPerItem = availableWidth / itemsPerRow
        return CGSize(width: widthPerItem, height: widthPerItem + 30)
    }
}
