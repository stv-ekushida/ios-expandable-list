//
//  ExpandableTableView.swift
//  ios-expandable-list-ui
//
//  Created by Kushida　Eiji on 2016/12/03.
//  Copyright © 2016年 Kushida　Eiji. All rights reserved.
//

import UIKit

class ExpandableTableView : UITableView {
    var sectionOpen = NSNotFound
}

extension ExpandableTableView: HeaderViewDelegate {
    
    func openedView(section: Int) {
        
        if self.sectionOpen != NSNotFound {
            closedView(section: self.sectionOpen)
        }
        
        self.sectionOpen = section
        
        if let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section) {
            
            var indexesPathToInsert:[IndexPath] = []
            
            for i in 0 ..< numberOfRows {
                indexesPathToInsert.append(IndexPath(row: i, section: section))
            }
            
            if indexesPathToInsert.count > 0 {
                self.beginUpdates()
                self.insertRows(at: indexesPathToInsert as [IndexPath], with: UITableViewRowAnimation.automatic)
                self.endUpdates()
            }
        }
    }
    
    func closedView(section: Int) {
        
        if let numberOfRows = self.dataSource?.tableView(self, numberOfRowsInSection: section) {
            var indexesPathToDelete:[IndexPath] = []
            self.sectionOpen = NSNotFound
            
            for i in 0 ..< numberOfRows {
                indexesPathToDelete.append(IndexPath(row: i, section: section))
            }
            
            if indexesPathToDelete.count > 0 {
                self.beginUpdates()
                self.deleteRows(at: indexesPathToDelete as [IndexPath], with: UITableViewRowAnimation.top)
                self.endUpdates()
            }
        }
    }
}
