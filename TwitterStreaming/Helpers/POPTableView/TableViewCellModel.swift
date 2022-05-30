import Foundation

protocol TableViewCellModel {
    func identifier()-> String
}

protocol ConfigurableTableViewCell {
    func configure(with model: TableViewCellModel, indexPath: IndexPath)
}
