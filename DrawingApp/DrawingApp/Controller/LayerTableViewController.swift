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
    
    var didSelectRowHandler: ((Layer?) -> ())?
    var didMoveRowHandler: ((Int, Int) -> ())?
    var didCommandMoveHandler: ((Layer, Plane.reorderCommand) -> ())?
    
    var fetchLayer: ((Int) -> Layer?)?
    var getLayerCount: (() -> Int?)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        subscribePlaneNotification()
    }
    
    private func configureTableView() {
        tableView.isEditing = true
        tableView.allowsSelectionDuringEditing = true
    }
    
    private func subscribePlaneNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(didAddLayer(_:)), name: Plane.Event.didAddLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectLayer(_:)), name: Plane.Event.didSelectLayer, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didReorderLayer(_:)), name: Plane.Event.didReorderLayer, object: nil)
    }
}

// MARK: - Table view data source

extension LayerTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return getLayerCount?() ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StoryBoardLayerCell", for: indexPath)
        
        cell.selectionStyle = .default
        cell.backgroundConfiguration?.backgroundColor = .white
        
        var config = cell.defaultContentConfiguration()
        
        guard let layer = fetchLayer?(indexPath.row) else { return cell }
        
        config.text = layer.title
        config.textProperties.color = .black
        
        guard let symbol = ViewFactory.createSymbol(from: layer) else { return cell }
        
        config.image = symbol
        config.imageProperties.tintColor = .black
        
        cell.contentConfiguration = config
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress(_:)))
        cell.addGestureRecognizer(longPress)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
}

// MARK: - Use case: Add Layer
// MARK: [Output] Load table cell according to Layers (Output)

extension LayerTableViewController {
    
    @objc func didAddLayer(_ notification: Notification) {
//        guard let newLayer = notification.userInfo?[Plane.InfoKey.added] as? Layer else { return }
//        layers.append(newLayer)
        tableView.reloadData()
    }
}

// MARK: - Use case: Select Layer
// MARK: [Input] Touch table cell (input)
// MARK: [Output] Select table cell according to Plane (Output)

extension LayerTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selectedLayer = fetchLayer?(indexPath.row) else { return }
        didSelectRowHandler?(selectedLayer)
    }
    
    @objc func didSelectLayer(_ notification: Notification) {
//        guard let selected = notification.userInfo?[Plane.InfoKey.selected] as? Layer, let index = layers.firstIndex(of: selected)  else { return }
//        let indexPath = IndexPath(row: index, section: 0)
//        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
}

// MARK: - Use case: Reorder Layer
// MARK: [Input] Move Row with drag & Long press menu
// MARK: [Output] Update table cell

extension LayerTableViewController {
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        didMoveRowHandler?(sourceIndexPath.row, destinationIndexPath.row)
    }
    
    
    @objc func handleLongPress(_ gesture: UILongPressGestureRecognizer) {
        guard let pressedCell = gesture.view as? UITableViewCell, let pressedIndexPath = tableView.indexPath(for: pressedCell) else { return }
        
        guard let pressedLayer = fetchLayer?(pressedIndexPath.row) else { return }
        
        let alertController = UIAlertController(title: nil, message: "Arrange Layer", preferredStyle: .actionSheet)
        
        let sendToBack = UIAlertAction(title: "맨 뒤로 보내기", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.didCommandMoveHandler?(pressedLayer, .sendToBack)
        })
        
        let bringToFront = UIAlertAction(title: "맨 앞으로 가져오기", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.didCommandMoveHandler?(pressedLayer, .bringToFront)
        })
        
        let sendBackward = UIAlertAction(title: "뒤로 보내기", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.didCommandMoveHandler?(pressedLayer, .sendBackward)
        })
        
        let bringForward = UIAlertAction(title: "앞으로 가져오기", style: .default, handler: { (alert: UIAlertAction!) -> Void in
            self.didCommandMoveHandler?(pressedLayer, .bringForward)
        })
        
        alertController.addAction(sendToBack)
        alertController.addAction(bringToFront)
        alertController.addAction(sendBackward)
        alertController.addAction(bringForward)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = pressedCell
        }
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    @objc func didReorderLayer(_ notification: Notification) {
        guard let from = notification.userInfo?[Plane.InfoKey.fromIndex] as? Int,
              let to = notification.userInfo?[Plane.InfoKey.toIndex] as? Int else { return }
        tableView.moveRow(at: IndexPath(row: from, section: 0), to: IndexPath(row: to, section: 0))
    }
}
