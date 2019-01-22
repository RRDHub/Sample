//
//  ViewController.swift
//  Sample
//
//  Created by Velmurugan Thangavelu on 6/6/18.
//  Copyright © 2018 Velmurugan Thangavelu. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController,UITextFieldDelegate {
    // @property (strong, nonatomic, readonly) NSPersistentContainer *persistentContainer;
    //@IBOutlet weak var persistentContainer:nsP
    @IBOutlet weak var expandTable: UITableView!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    var arr = NSMutableArray()
    var arrCategory = NSMutableArray()
    var tagStatus:Bool=false
   
    
    @IBOutlet weak var btn: UIButton!
    var expandData = [NSMutableDictionary]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.expandData.append(["isOpen":"1","data":["banana","mango"],"Title":"Section 1","text":"Hello World!"])
        self.expandData.append(["isOpen":"1","data":["banana","mango","apple"],"Title":"Section 2","text":"Hello World!"])
        self.expandData.append(["isOpen":"1","data":["banana"],"Title":"Section 3","text":"Hello World!"])
        label.text="This is the use case where UILabel content is variable. We want to keep the width fixed, but make height variable. Width can either be constrained to both ends or kept fixed in terms of fixed number for width This is the use case where UILabel content is variable. We want to keep the width fixed, but make height variable. Width can either be constrained to both ends or kept fixed in terms of fixed number for width"
        label2.text="This "
        label2.text="This lfdkgaklfgakfg"
        label2.text="This testtststsf,.df.adf"
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
//        let entity = NSEntityDescription.entity(forEntityName: "Customer", in: context)
//
//        // Initialize Fetch Request
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
//
//        // Configure Fetch Request
//        fetchRequest.includesPropertyValues = false
//
//        do {
//            let items = try context.fetch(fetchRequest) as! [NSManagedObject]
//
//            for item in items {
//                context.delete(item)
//            }
//            // Save Changes
//            try context.save()
//
//        } catch {
//            // Error Handling
//            // ...
//        }
//
//        for i in 0..<10 {
//        let newUser = NSManagedObject(entity: entity!, insertInto: context)
//       // newUser.setValue((fullDataArr[i] as AnyObject).value(forKey: "CategoryName"), forKey: "categoryname")
//        newUser.setValue(1234*i, forKey: "stockin")
//        newUser.setValue(120*i, forKey: "stockout")
//        }
//
//        do {
//            try context.save()
//        } catch {
//            print("Failed saving")
//        }
//
//        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Customer")
//        request.predicate = NSPredicate(format: "categoryname = %@", "Category6")
//        request.returnsObjectsAsFaults = false
//        let newArr=NSMutableArray()
//        do {
//            let result = try context.fetch(request)
//            for data in result as! [NSManagedObject] {
//                newArr.add(data)
//               //print(data.value(forKey: "categoryname") as! String)
//            }
//
//        } catch {
//
//            print("Failed")
//        }
//        print(newArr)
    }
    
    
    @IBAction func filterAction(_ sender: Any) {
        //GlobalConstants.loaded = false
        // print(GlobalConstants.loaded)
        //self.view.bringSubview(toFront:self.expandableTableView)
        let tblview:UITableView = self.view.viewWithTag(11) as! UITableView
        tblview.reloadData()
        let newFrame:CGRect=tblview.frame
        if !tagStatus {
            tblview.isHidden=false;
            tblview.frame=CGRect(x:tblview.frame.origin.x+500, y:tblview.frame.origin.y, width:tblview.frame.size.width,height:tblview.frame.size.height);
            UIView.animate(withDuration: 0.5, animations: { tblview.frame = newFrame }, completion: nil)
            tagStatus=true;
        }else{
            tblview.isHidden=false;
            UIView.animate(withDuration: 0.5, animations: {
                tblview.frame=CGRect(x:tblview.frame.origin.x+500, y:tblview.frame.origin.y, width:tblview.frame.size.width, height:tblview.frame.size.height)}, completion:{(finished: Bool) in tblview.isHidden=true
                    tblview.frame=CGRect(x:tblview.frame.origin.x-500, y:tblview.frame.origin.y, width:tblview.frame.size.width, height:tblview.frame.size.height)
            })
            tagStatus=false;
        }
    }
    
    
    @IBAction func btnAction(_ sender: Any) {
        let arrNew = NSMutableArray()
        for i in 0..<expandData.count {
            if arr[i] as! Int == 1 {
               arrNew.insert(expandData[i], at: 0)
            }else{
               arrNew.add(expandData[i])
            }
        }
        expandData=arrNew as! [NSMutableDictionary]
        print(expandData)
        expandTable.reloadData()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        let txtTag:Int=Int(textField.tag)
        let secVal:Int=txtTag/10
        arr[secVal]=1
        self.expandData[secVal]["text"] = textField.text
        print(self.expandData)
        
        for x in 0..<self.expandData.count {
            if let objView = self.view.viewWithTag(x + 100) as? UIView {
                objView.backgroundColor = UIColor.gray
            }
            for y in 0..<(self.expandData[x].value(forKey: "data") as AnyObject).count{
                if let cellRow = self.view.viewWithTag((x*10)+1000+y) as? UITableViewCell {
                    cellRow.backgroundColor = UIColor.clear
                }
            }
        }
        

        if let objView = self.view.viewWithTag(secVal + 100) {
             objView.backgroundColor = .brown
            for listOfViews in objView.subviews {
                if let lbl = listOfViews as? UILabel {
                    print(lbl)
                    lbl.text="Vel"
                    self.expandData[secVal]["Title"] = lbl.text
                }else{
                    print("Not a label")
                }
            }
        }
        
        //let rowVal = txtTag%10
        let dataarray = self.expandData[secVal].value(forKey: "data") as! NSArray
        for i in 0..<dataarray.count {
        if let cellRow = self.view.viewWithTag((secVal*10)+1000+i) as? UITableViewCell {
             cellRow.backgroundColor = .brown
        }}
        
        
            
        
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

class ExpandCell:UITableViewCell{
    @IBOutlet weak var expandLbl: UILabel!
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 10 {
        if self.expandData[section].value(forKey: "isOpen") as! String == "1"{
            return 0
        }else{
            let dataarray = self.expandData[section].value(forKey: "data") as! NSArray
            return dataarray.count
            }}else{
            return ((arrCategory[section] as AnyObject).value(forKey: "RowDetails") as! NSArray).count
        }
    }
    func numberOfSections(in tableView: UITableView) -> Int {
//        if tableView.tag == 11 {
//            return arrCategory.count
//        }
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellNew = UITableViewCell()
        if tableView.tag == 10 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Table", for: indexPath) as! ExpandCell
        if cell == nil {
            tableView.register(UINib.init(nibName: "TableCell", bundle: nil), forCellReuseIdentifier: "expand")
        }
       
        tableView.separatorStyle = .none
        return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
            let arrVal=(arrCategory.object(at: indexPath.section) as AnyObject).value(forKey: "RowDetails") as! NSArray
            cell.textLabel?.text=arrVal.object(at: indexPath.row) as! String
            return cell
        }
        return cellNew
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let newView = UIView()
        if tableView.tag == 10 {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.gray
        let label = UILabel(frame: CGRect(x: 5, y: 3, width: headerView.frame.size.width - 5, height: 27))
        label.text = self.expandData[section].value(forKey: "Title") as! String
        headerView.addSubview(label)
        headerView.tag = section + 100
        
        let tapgesture = UITapGestureRecognizer(target: self , action: #selector(self.sectionTapped(_:)))
        headerView.addGestureRecognizer(tapgesture)
        return headerView
        }else{
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor.gray
        let label = UILabel(frame: CGRect(x: 5, y: 3, width: headerView.frame.size.width - 5, height: 27))
            label.text = (self.arrCategory.object(at:section) as AnyObject).value(forKey: "Title") as! String
        headerView.addSubview(label)
        headerView.tag = section + 100
        return headerView
        }
        return newView
    }
    @objc func sectionTapped(_ sender: UITapGestureRecognizer){
        if(self.expandData[(sender.view?.tag)! - 100].value(forKey: "isOpen") as! String == "1"){
            self.expandData[(sender.view?.tag)! - 100].setValue("0", forKey: "isOpen")
        }else{
            self.expandData[(sender.view?.tag)! - 100].setValue("1", forKey: "isOpen")
        }
        self.expandTable.reloadSections(IndexSet(integer: (sender.view?.tag)! - 100), with: .automatic)
    }
    
}

