import Foundation

protocol TableViewHeaderSection {
    var identifier: String { get }
}

protocol ConfigurableTableViewHeaderSectionModel {
    func configure(with model: TableViewHeaderSection)
}
