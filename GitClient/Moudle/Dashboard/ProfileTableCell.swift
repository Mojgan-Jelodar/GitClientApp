//
//  ProfileTableCell.swift
//  GitClient
//
//  Created by Mozhgan on 9/25/21.
//

import UIKit
import SnapKit
import Kingfisher

final class ProfileTableCell: UITableViewCell {
    private(set) lazy var avatarImgView : UIImageView = {
        let tmp = UIImageView()
        tmp.contentMode = .scaleAspectFit
        return tmp
    }()
    private(set) lazy var nameLbl : UILabel = {
        let tmp = UILabel()
        tmp.numberOfLines = 0
        tmp.font = UIFont.systemFont(ofSize: LayoutContants.Shared.fontSize, weight: UIFont.Weight.regular)
        tmp.lineBreakMode = .byTruncatingTail
        return tmp
    }()
    private(set) lazy var emailLbl : UILabel = {
        let tmp = UILabel()
        tmp.font = UIFont.systemFont(ofSize: LayoutContants.Shared.fontSize, weight: UIFont.Weight.regular)
        tmp.numberOfLines = 0
        tmp.lineBreakMode = .byTruncatingTail
        return tmp
    }()
    private(set) lazy var followersLbl : UILabel = {
        let tmp = UILabel()
        tmp.numberOfLines = 0
        tmp.textAlignment = .center
        tmp.font = UIFont.boldSystemFont(ofSize: LayoutContants.Shared.fontSize)
        tmp.lineBreakMode = .byTruncatingTail
        return tmp
    }()
    private(set) lazy var followingLbl : UILabel = {
        let tmp = UILabel()
        tmp.numberOfLines = 0
        tmp.textAlignment = .center
        tmp.font = UIFont.boldSystemFont(ofSize: LayoutContants.Shared.fontSize)
        tmp.lineBreakMode = .byTruncatingTail
        return tmp
    }()
    private(set) lazy var stackView : UIStackView = {
        let tmp = UIStackView()
        tmp.alignment = .fill
        tmp.axis = .horizontal
        tmp.distribution = .equalCentering
        tmp.addArrangedSubview(followingLbl)
        tmp.addArrangedSubview(followersLbl)
        return tmp
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupView()
    }

    func setupView() {
        func setAvatarConstraint() {
            avatarImgView.snp.makeConstraints { maker in
                maker.leading.equalTo(LayoutContants.Shared.margin)
                maker.centerY.equalToSuperview()
                maker.size.equalTo(Dashboard.Style.size)
            }
        }
        func setNameConstraint() {
            nameLbl.snp.makeConstraints { maker in
                maker.leading.equalTo(avatarImgView.snp.trailing).offset(LayoutContants.Shared.margin)
                maker.centerY.equalTo(avatarImgView).offset(LayoutContants.Shared.margin * -1)
            }
        }
        func setEmailConstraint() {
            emailLbl.snp.makeConstraints { maker in
                maker.leading.equalTo(nameLbl.snp.leading)
                maker.trailing.equalToSuperview()
                maker.top.equalTo(nameLbl.snp.bottom)
            }
        }
        func setStackConstraint() {
            stackView.snp.makeConstraints { maker in
                maker.leading.equalTo(avatarImgView.snp.trailing).offset(LayoutContants.Shared.margin)
                maker.trailing.equalToSuperview().offset(-LayoutContants.Shared.margin)
                maker.top.equalTo(emailLbl.snp.bottom).offset(LayoutContants.Shared.margin)
                maker.bottom.equalToSuperview().offset(-LayoutContants.Shared.margin)
            }
        }
        self.contentView.addSubview(avatarImgView)
        self.contentView.addSubview(emailLbl)
        self.contentView.addSubview(nameLbl)
        self.contentView.addSubview(stackView)
        setAvatarConstraint()
        setNameConstraint()
        setEmailConstraint()
        setStackConstraint()
    }

}

extension ProfileTableCell {
    func configCell(viewModel : Dashboard.UserViewModel) {
        self.nameLbl.text = viewModel.user?.name
        self.emailLbl.text = viewModel.user?.email
        self.followingLbl.text = [R.string.dashboard.following(),"\(viewModel.user?.following ?? 0)"].joined(separator : "\n")
        self.followersLbl.text = [R.string.dashboard.followers(),"\(viewModel.user?.followers ?? 0)"].joined(separator : "\n")
        guard let urlPath = viewModel.user?.avatarUrl,
              let url = URL(string: urlPath) else {
            return
        }
        avatarImgView.kf.indicatorType = .activity
        avatarImgView.kf.setImage(with: Source.network(ImageResource(downloadURL: url)),
                                  placeholder: nil,
                                  options: [.scaleFactor(UIScreen.main.scale),
                                            .transition(.fade(1)),
                                             .cacheOriginalImage])
    }
}
