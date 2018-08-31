//
//  ViewController.swift
//  Translator
//
//  Created by Sergey on 22.08.2018.
//  Copyright © 2018 Sergey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var textForTranslateTextView: UITextView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var translatedTextView: UITextView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var nameLangButton: UIButton!
    @IBOutlet weak var copyrightTextField: UITextView!

    var nameLang: String = "ru"  //default value
    private let mainURL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    private let langQuery = "?lang="
    private let keyQuery = "&key="
    private let textQuery = "&text="
    private let key = "trnsl.1.1.20180822T102955Z.c678bb22f93e12a9.325e77855abb75273b457d5e7afd1f4a32d35637"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        nameLangButton.setTitle(nameLang, for: .normal)
    }
    
    private func setup() {
        title = "Яндекс переводчик"
        activityIndicatorView.hidesWhenStopped = true
        
        self.textForTranslateTextView.layer.cornerRadius = 5
        self.textForTranslateTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.textForTranslateTextView.layer.borderWidth = 1
        
        self.translatedTextView.layer.cornerRadius = 5
        self.translatedTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.translatedTextView.layer.borderWidth = 1
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(tapGesture)
        
        self.textForTranslateTextView.delegate = self
        self.translatedTextView.delegate = self
        
        self.copyrightTextField.isEditable = false
        self.copyrightTextField.dataDetectorTypes = .link
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    private func getFullURL() -> String {
        var fullURL = ""
        let langTranslate = (nameLangButton.titleLabel?.text)!
        
        var dataCoding = textForTranslateTextView.text!
        dataCoding = dataCoding.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        fullURL = mainURL + langQuery + langTranslate +
                  keyQuery + key + textQuery + dataCoding
        
        return fullURL
    }
    
    @IBAction func getTranslate(_ sender: UIButton) {
        guard textForTranslateTextView.text != "" else {
            let alertController = UIAlertController(title: "Внимание",
                                                    message: "Необходимо ввести текст для перевода",
                                                    preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Ok",
                                                    style: .default,
                                                    handler: nil))
            self.present(alertController, animated: true, completion: nil)
            return
        }
        
        let stringURL = getFullURL()
        self.activityIndicatorView.startAnimating()
        
        MainNetworkService.getContent(stringURL: stringURL) { (responce) in
            self.translatedTextView.text = responce
        }
        
        self.activityIndicatorView.stopAnimating()
        view.endEditing(true)
    }
    
    //MARK: - Choice lang for translate
    @IBAction func choseLangButton(_ sender: UIButton) {
        self.textForTranslateTextView.resignFirstResponder()
    }
    
    //готовим обратный переход
    @IBAction func backToMainVC(segue: UIStoryboardSegue) {
        guard segue.identifier == "backSegue" else { return }
        guard let svc = segue.source as? ListLangTableViewController else { return }
        self.nameLang = svc.langSelect
    }
}

extension ViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView == self.textForTranslateTextView else { return }
        textForTranslateTextView.text = ""
    }
}














