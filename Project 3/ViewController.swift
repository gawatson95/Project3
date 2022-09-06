//
//  ViewController.swift
//  Project 3
//
//  Created by Grant Watson on 9/6/22.
//

import UIKit

class ViewController: UITableViewController {
    var countries: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Flags"
        
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let items = try! fm.contentsOfDirectory(atPath: path)
        
        for item in items {
            if item.hasSuffix(".png") {
                countries.append(item)
            }
        }
        countries.sort()
        print(countries)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Country", for: indexPath)
        let text = countries[indexPath.row]
        cell.imageView?.image = UIImage(named: text)
        cell.imageView?.layer.borderWidth = 0.5
        cell.imageView?.layer.borderColor = UIColor.lightGray.cgColor
        cell.textLabel?.text = text.fileName()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "Detail") as? DetailVC {
            vc.selectedImage = countries[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}

extension String {
    func fileName() -> String {
        if self.count < 7 {
            return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent.uppercased() ?? ""
        } else {
            return NSURL(fileURLWithPath: self).deletingPathExtension?.lastPathComponent.capitalized ?? ""
        }
    }
}

