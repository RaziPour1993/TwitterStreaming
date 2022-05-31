import Foundation

protocol TableViewFooterSectionModel {
    var identifier: String { get }
}

protocol ConfigurableTableViewFooterSectionModel {
    func configure(with model: TableViewFooterSectionModel)
}
