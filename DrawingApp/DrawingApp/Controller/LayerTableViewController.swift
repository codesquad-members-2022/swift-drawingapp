//
//  LayerTableViewController.swift
//  DrawingApp
//
//  Created by Bumgeun Song on 2022/03/14.
//

import UIKit

class LayerTableViewController: UITableViewController {
    
    enum identifier {
        static let cell = "LayerCell"
    }
    
    private var layers: [Layer] = []
    var didSelectRowHandler: ((Int) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didAddLayer(_:)), name: Plane.Event.didAddLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: nil)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layers.count
    }
    
    @objc func didAddLayer(_ notification: Notification) {
        guard let newLayer = notification.userInfo?[Plane.InfoKey.added] as? Layer else { return }
        layers.append(newLayer)
        tableView.reloadData()
    }
    
    @objc func didSelectLayer(_ notification: Notification) {
        if let old = notification.userInfo?[Plane.InfoKey.unselected] as? Layer, let row = layers.firstIndex(of: old) {
            let indexPath = IndexPath.init(row: Int(row), section: 0)
            tableView.cellForRow(at: indexPath)?.setHighlighted(false, animated: false)
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
        if let new = notification.userInfo?[Plane.InfoKey.selected] as? Layer, let row = layers.firstIndex(of: new) {
            let indexPath = IndexPath.init(row: Int(row), section: 0)
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .middle)
            tableView.cellForRow(at: indexPath)?.setHighlighted(true, animated: false)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LayerTableViewController.identifier.cell, for: indexPath)

        let layer = layers[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = layer.title

        if let symbol = ViewFactory.createSymbol(from: layer) {
            config.image = symbol
        }
        
        cell.contentConfiguration = config
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        didSelectRowHandler?(indexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
