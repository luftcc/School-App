

import UIKit
import CoreData
import MBProgressHUD

class MainVC: UITableViewController {
    
    var noteDataArr: [Note]?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "备忘录"
        self.tableView.register(UINib.init(nibName: "NoteCell", bundle: nil), forCellReuseIdentifier: "NoteCell")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addNote))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.reloadCoreData()
    }
    
    func reloadCoreData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Note")
        do {
            let result = try context.execute(fetchRequest) as! NSAsynchronousFetchResult<Note>
            noteDataArr = result.finalResult
            self.tableView.reloadData()
        } catch {
            let nserror = error as NSError
            print(nserror.localizedDescription)
        }
    }

    @objc func addNote() {
        let vc = DetailVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let noteArr = noteDataArr else {
            return 0;
        }
        return noteArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! NoteCell
        cell.titleL.text = noteDataArr?[indexPath.row].title
        cell.descL.text = noteDataArr?[indexPath.row].desc
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailVC.init(noteModel: (noteDataArr?[indexPath.row])!)
        self.navigationController?.pushViewController(vc, animated: true);
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let ac = UIAlertController(title: "确定删除吗?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .destructive) { (action) in
            let note = self.noteDataArr![indexPath.row]
            self.context.delete(note)
            do {
                try self.context.save()
                self.reloadCoreData()
            } catch {
                let nserror = error as NSError
                let hud = MBProgressHUD.init()
                hud.mode = .text
                hud.label.text = nserror.localizedDescription
                hud.show(animated: true)
            }
        }
        ac.addAction(cancel)
        ac.addAction(confirm)
        self.present(ac, animated: true, completion: nil)
        
    }

}
