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
    private var previousSelected: IndexPath?
    
    var didSelectRowHandler: ((Layer?) -> ())?
    var didMoveRowHandler: ((Int, Int) -> ())?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(LayerTableViewCell.self, forCellReuseIdentifier: "layerTableViewCell")
                tableView.isEditing = true
                tableView.allowsSelectionDuringEditing = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(didAddLayer(_:)), name: Plane.Event.didAddLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReorderLayer(_:)), name: Plane.Event.didReorderLayer, object: nil)
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
        guard let selected = notification.userInfo?[Plane.InfoKey.selected] as? Layer, let index = layers.firstIndex(of: selected)  else { return }
        let indexPath = IndexPath(row: index, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
    
    @objc func didReorderLayer(_ notification: Notification) {
        guard let reorderedLayers = notification.userInfo?[Plane.InfoKey.changed] as? [Layer] else { return }
        self.layers = reorderedLayers
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "layerTableViewCell", for: indexPath)
        
        let layer = layers[indexPath.row]
        cell.selectionStyle = .none
        cell.backgroundConfiguration?.backgroundColor = .clear
        
        var config = cell.defaultContentConfiguration()
        config.text = layer.title
        
        if let symbol = ViewFactory.createSymbol(from: layer) {
            config.image = symbol
        }
        cell.contentConfiguration = config
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Will not select row because this method only handles input flow
        tableView.deselectRow(at: indexPath, animated: false)
        
        let selectedLayer = layers[indexPath.row]
        didSelectRowHandler?(selectedLayer)
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        //
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        didMoveRowHandler?(sourceIndexPath.row, destinationIndexPath.row)
    }
}
