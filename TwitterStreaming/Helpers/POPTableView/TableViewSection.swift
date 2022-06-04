import Foundation

class TableViewSection: TableViewSectionModel {
    
    var cellModels: [TableViewCellModel]
    var headerSectionModel: TableViewHeaderSection?
    var footerSectionModel: TableViewFooterSectionModel?
    
    init( headerSection: TableViewHeaderSection? = nil,
          footerSection: TableViewFooterSectionModel? = nil,
          cellModels: [TableViewCellModel] = []) {
        
        self.cellModels = cellModels
        self.headerSectionModel = headerSection
        self.footerSectionModel = footerSection
    }
}


