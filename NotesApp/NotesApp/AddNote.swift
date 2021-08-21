//
//  AddNote.swift
//  NotesApp
//
//  Created by DCS on 09/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class AddNote: UIViewController {
    
    var updatedata = ""
    
    private let titlefile:UITextField = {
        let textf = UITextField()
        textf.placeholder = ""
        textf.textAlignment = .center
        textf.borderStyle = .roundedRect
        textf.layer.borderWidth = 5
        textf.font = UIFont.boldSystemFont(ofSize: 20)
        return textf
    }()
    
    private let des:UITextView = {
        let textv = UITextView()
        textv.text = ""
        textv.textAlignment = .center
        textv.layer.borderWidth = 5
        //textv.backgroundColor = .gray
        textv.font = UIFont.boldSystemFont(ofSize: 25)
        textv.sizeThatFits(CGSize(width: 50, height: 50))
        return textv
    }()
    
    
    private let save:UIButton = {
        let btn = UIButton()
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveaction), for: .touchUpInside)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.init(red: 0, green: 255, blue: 0, alpha: 0.6)
        btn.layer.cornerRadius = 5
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(titlefile)
        view.addSubview(des)
        view.addSubview(save)
        
        
        if updatedata != ""{
            titlefile.text = updatedata.components(separatedBy: ".").first
            titlefile.isEnabled = false
            
            let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            
            let fileURL = URL(fileURLWithPath: "\(titlefile.text!)", relativeTo: directoryURL).appendingPathExtension("txt")
            
            do {
                let savedData = try Data(contentsOf: fileURL)
                
                if let savedString = String(data: savedData, encoding: .utf8) {
                    des.text = savedString
                }
                
            } catch {
                // Catch any errors
                print("Unable to read the file")
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        titlefile.frame = CGRect(x: 40, y: view.safeAreaInsets.top + 20, width: view.width - 80, height: 60)
        des.frame = CGRect(x: 40, y: titlefile.bottom + 20, width: view.width - 80, height: 150)
        save.frame = CGRect(x: 40, y: des.bottom + 20, width: view.width - 80, height: 60)
        
        
    }
    
    @objc func saveaction(){
        
        let directoryURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL = URL(fileURLWithPath: "\(titlefile.text!)", relativeTo: directoryURL).appendingPathExtension("txt")
        
        
        let myString = "\(des.text!)"
        
        guard let data = myString.data(using: .utf8) else {
            print("Unable to convert string to data")
            return
        }
        
        do {
            try data.write(to: fileURL)
            print("File saved: \(fileURL.absoluteURL)")
        } catch {
            // Catch any errors
            print(error.localizedDescription)
        }
        
        
        let vc = Port()
        navigationController?.pushViewController(vc, animated: true)
    }
}
