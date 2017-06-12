//
//  MessagesTableViewController.swift
//  NFCReader
//
//  Created by Watanabe Toshinori on 6/12/17.
//

import UIKit
import CoreNFC

class MessagesTableViewController: UITableViewController, NFCNDEFReaderSessionDelegate {

    var messages = [NFCNDEFMessage]()

    // MARK: - NFCNDEFReaderSessionDelegate

    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        // Check invalidation reson from the returned error. Session will be invalidated after the function returns. New Session instance is required to restart the scanning.
        print(error)
    }

    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        // Process read NFCNDEFMessage objects.
        self.messages = messages

        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Actions

    @IBAction func begginScanning(_ sender: Any) {
        let session = NFCNDEFReaderSession(delegate: self, queue: nil, invalidateAfterFirstRead: true)
        session.begin()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let message = messages[indexPath.row]

        cell.textLabel?.text = "\(message.records.count) Payload"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let message = messages[indexPath.row]

        print(message.description)
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch (segue.destination, segue.identifier) {
        case (let viewController as MessageTableViewController, "ShowTag"?):
            guard let indexPath = tableView.indexPathForSelectedRow else {
                return
            }
            viewController.message = messages[indexPath.row]
        default:
            break
        }
    }

}
