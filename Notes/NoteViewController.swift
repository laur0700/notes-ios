//
//  NoteViewController.swift
//  Notes
//
//  Created by Laurentiu-Andrei Postole on 07.06.2022.
//

import UIKit

class NoteViewController: UIViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var noteTitle: UITextField!
    @IBOutlet weak var noteBody: UITextView!
    var note: NoteItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTitle.text = note?.title
        noteBody.text = note?.body
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
    }
    
    @objc private func didTapSave() {
        note!.title = noteTitle.text
        note!.body = noteBody.text
            
        self.updateNote(item: note!)
    }
    
    func updateNote(item : NoteItem){
        do {
            try context.save()
        } catch{
            //error
        }
        
    }

}
