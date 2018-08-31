//
//  ListLangTableViewController.swift
//  Translator
//
//  Created by Sergey on 26.08.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

class ListLangTableViewController: UITableViewController {

    private let allLangArray = ["ru": "Русский", "en": "Английский", "fr": "Французкий", "de": "Немецкий"]
    var langSelect = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Выбор языка"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allLangArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.font = UIFont.systemFont(ofSize: 14)
        cell.textLabel?.text = Array(self.allLangArray.values)[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        langSelect = Array(self.allLangArray.keys)[indexPath.row]
        performSegue(withIdentifier: "backSegue", sender: nil)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}
