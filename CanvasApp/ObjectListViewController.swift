//
//  ObjectListViewController.swift
//  CanvasApp
//
//  Created by JK-Master on 2021/09/18.
//

import UIKit

protocol ObjectsIteratable : NSObject {
    var count : Int { get }
    func object(at index: Int) -> ObjectDescription?
}

class ObjectListViewController: UIViewController {

    @IBOutlet weak var objectList: UITableView!
    weak var objectSource : (ObjectsIteratable & ObjectSelectablePlane)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func reloadView() {
        objectList.reloadData()
    }
}

extension ObjectListViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectSource?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectCell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        guard let description = objectSource?.object(at: indexPath.row) else { return cell }
        let selected = objectSource?.isSelected(id: description.id) ?? false
        content.text = description.text
        content.textProperties.color = (selected) ? UIColor.red : UIColor.darkText
        cell.contentConfiguration = content
        return cell
    }
}

extension ObjectListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        objectSource?.select(at: indexPath.row)
    }
}
