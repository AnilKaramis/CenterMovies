//
//  MainViewCell.swift
//  CenterMovies
//
//  Created by AnılKaramış on 12.02.2024.
//
import UIKit
import SDWebImage
import SnapKit

class MainViewCell: UITableViewCell {
    
    public static var identifier: String {
        get {
            "MainViewCell"
        }
    }
    public static func register() -> UINib {
        UINib(nibName: "MainViewCell", bundle: nil)
    }
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var rateLabel: UILabel!
    
//    private let nameLabel:UILabel = {
//        var name = UILabel()
//        return name
//    }()
//    private let rateLabel:UILabel = {
//        var rate = UILabel()
//        return rate
//    }()
//    private let dateLabel:UILabel = {
//        var date = UILabel()
//        return date
//    }()
//    private let movieImageView:UIImageView = {
//        var image = UIImageView()
//        return image
//    }()
//    private let backView: UIView = {
//        var view = UIView()
//        return view
//    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // 1-) Cell icinde olusturulmus bu yapilari constraints ayarlamak icin nasil bir sablon olusturulmali ?
        // 2-)awakeFromNib komutu arastirilacak ?
        
        setupCellUI()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupCellUI() {
        // made optional
        
        backView?.addBorder(color: .label, width: 1)
        backView?.round(10)
        
        movieImageView?.round(5)
    }
    func setupCell(viewModel: CenterMoviesViewCell) {
        self.nameLabel.text = viewModel.title
        self.dateLabel.text = viewModel.date
        self.rateLabel.text = viewModel.rating
        self.movieImageView.sd_setImage(with: viewModel.imageUrl)
    }
}
extension UIView {
    //MovieTable Property
    
    func round(_ radius: CGFloat = 10) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
    func addBorder(color: UIColor, width: CGFloat) {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
}
