import UIKit
import Foundation

public extension UITableView {
  
  
  public func layoutHeaderAndFooter() {
    layoutTableFooterView()
    layoutTableHeaderView()
  }
  
  /// Adds a header to the tableview that is layed out with AutoLayout.
  public func addAutoLayoutHeader(header: UIView) {
    let headerContainer = UIView()
    headerContainer.translatesAutoresizingMaskIntoConstraints = false
    tableHeaderView = headerContainer
    
    headerContainer.addSubview(header)
    headerContainer.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    headerContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    headerContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
    header.pinToSuperview()
    layoutTableHeaderView()
  }
  
  /// Adds a footer to the tableview that is layed out with AutoLayout.
  public func addAutoLayoutFooter(footer: UIView) {
    let footerContainer = UIView()
    tableFooterView = footerContainer
    
    footerContainer.addSubview(footer)
    footer.pinToSuperview()
    layoutTableFooterView()
  }
  
  //Set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
  public func layoutTableHeaderView() {
    guard let header = tableHeaderView else {
      return
    }
    self.tableHeaderView = header
    header.setNeedsLayout()
    header.layoutIfNeeded()
    header.frame.origin = .zero
    header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    self.tableHeaderView = header
  }
  
  //Set the tableFooterView so that the required height can be determined, update the footer's frame and set it again
  public func layoutTableFooterView() {
    guard let footer = tableFooterView else {
      return
    }
    self.tableFooterView = footer
    footer.setNeedsLayout()
    footer.layoutIfNeeded()
    footer.frame.size = footer.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    self.tableFooterView = footer
  }
}
