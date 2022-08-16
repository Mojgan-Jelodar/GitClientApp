//
//  RepoTableCell.swift
//  GitClient
//
//  Created by Mozhgan on 9/26/21.
//

import Foundation
import UIKit
final class RepoTableCell: UITableViewCell {
    private(set) lazy var nameLbl : UILabel = {
        let tmp = UILabel()
        tmp.numberOfLines = 0
        tmp.font = UIFont.systemFont(ofSize: LayoutContants.Shared.fontSize, weight: UIFont.Weight.semibold)
        tmp.lineBreakMode = .byTruncatingTail
        return tmp
    }()
    private(set) lazy var descriptionLbl : UILabel = {
        let tmp = UILabel()
        tmp.font = UIFont.systemFont(ofSize: LayoutContants.Shared.fontSize, weight: UIFont.Weight.regular)
        tmp.numberOfLines = 0
        tmp.lineBreakMode = .byTruncatingTail
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
        func setNameConstraint() {
            nameLbl.snp.makeConstraints { maker in
                maker.top.leading.trailing.equalToSuperview().offset(LayoutContants.Shared.margin)
            }
        }
        func setDescriptionConstraint() {
            descriptionLbl.snp.makeConstraints { maker in
                maker.leading.equalTo(nameLbl.snp.leading).offset(LayoutContants.Shared.margin)
                maker.trailing.equalToSuperview()
                maker.top.equalTo(nameLbl.snp.bottom).offset(LayoutContants.Shared.margin)
                maker.bottom.equalToSuperview()
            }
        }
        self.contentView.addSubview(descriptionLbl)
        self.contentView.addSubview(nameLbl)
        setNameConstraint()
        setDescriptionConstraint()
    }

}

extension RepoTableCell {
    func configCell(viewModel : Repo) {
        self.nameLbl.text = viewModel.name
        self.descriptionLbl.text = viewModel.description
    }
}
