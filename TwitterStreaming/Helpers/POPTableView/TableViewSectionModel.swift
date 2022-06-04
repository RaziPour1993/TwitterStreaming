import Foundation

protocol TableViewSectionModel {
    var cellModels: [TableViewCellModel] {get set}
    var headerSectionModel: TableViewHeaderSection? {get set}
    var footerSectionModel: TableViewFooterSectionModel? {get set}
}

