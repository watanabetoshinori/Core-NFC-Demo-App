//
//  MessageTableViewController.swift
//  NFCReader
//
//  Created by Watanabe Toshinori on 6/12/17.
//

import UIKit
import CoreNFC

class MessageTableViewController: UITableViewController {

    var message: NFCNDEFMessage!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message.records.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessageTableViewCell

        let payload = message.records[indexPath.row]

        cell.label.text = payload.description

        return cell
    }

}
