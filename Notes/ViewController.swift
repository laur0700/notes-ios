//
//  ViewController.swift
//  Notes
//
//  Created by Laurentiu-Andrei Postole on 08.05.2022.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var tableView: UITableView!
    var models = [NoteItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Notes"
        getAllNotes()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    @objc private func didTapAdd() {
        self.createNote(title: "New Note", body: "new note")
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCell") as! NoteTableViewCell
        
        noteCell.noteTitle.text = models[indexPath.row].title
        noteCell.notePreview.text = models[indexPath.row].body
        
        return noteCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(item: models[indexPath.row])
            models.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            getAllNotes()
        }
    }
    
    func tableView(_ tablewView: UITableView, didSelectRowAt indexPath: IndexPath ){
        performSegue(withIdentifier: "showNoteDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? NoteViewController {
            destination.note = models[(tableView.indexPathForSelectedRow?.row)!]
            tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
        }
    }
    
    // CoreData
    
    func getAllNotes(){
        do{
            models = try context.fetch(NoteItem.fetchRequest())
            models.reverse()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        catch{
            //error
        }
    }
    
    func createNote(title: String, body: String){
        let newItem = NoteItem(context: context)
        newItem.title = title
        newItem.body = body
        
        do {
            try context.save()
            getAllNotes()
        } catch{
            //error
        }
    }
    
    func deleteNote(item: NoteItem){
        context.delete(item)
        
        do {
            try context.save()
        } catch{
            //error
        }
    }
    
    func updateNote(item : NoteItem){
        do {
            try context.save()
        } catch{
            //error
        }
        
    }


}

