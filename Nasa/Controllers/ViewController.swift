//
//  ViewController.swift
//  Nasa
//
//  Created by Robert Mutai on 26/08/2022.
//

import UIKit
import RxSwift
import RxCocoa
import Accelerate
class ViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel:ViewModel!
    
    private var bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.prefersLargeTitles=true
        
        //instantiate view model
        viewModel = ViewModel(service: APIController())
        
        setUpTableView()
        
       //subscribe to error events so as to show error message
        
        viewModel.error_received.subscribe(onNext: { element in
            DispatchQueue.main.async {
                self.showalert(msg: element)
                self.activityIndicator.stopAnimating()
            }
        }).disposed(by: bag)

       
        //make network call to get nasa images
        viewModel.getNasaImages()
        
        let numbers: [Int] = [1000, 5670, -1, 42, 21341123, 9223372036833434684]
        let average: Int = numbers.reduce(0,&+) / numbers.count
        
        
        
        print("AVERAGE:\(average)")
    }
    
    func setUpTableView(){
        
        tableView
            .rx.setDelegate(self)
            .disposed(by: bag)
        
       //navigate to next screen when table clicked
        tableView.rx.modelSelected(Items.self).subscribe { items in
            
            self.navigateNext(item: items)
            
        }.disposed(by: bag)
        
        //listen for when data comes back from server update table
        viewModel.nasaitems.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: NasaTableViewCell.self)){ row, item, cell in
            
            self.activityIndicator.stopAnimating()
            
            cell.lbTitle.text = item.data[0].title
            
            if let photographer = item.data[0].photographer {
                cell.lbPhotographer.text = photographer
            }else{
                cell.lbPhotographer.text = ""
                cell.lbseparator.text = ""
            }
            
            cell.lbDate.text = self.viewModel.displayDateFormat(date: item.data[0].date_created)
            
            
            cell.imnasaImage.downloadedFrom(link: item.links[0].href, contentMode: .scaleToFill)
            
            
        }.disposed(by: bag)
    }
    func navigateNext(item:Items){
//        let detailView = self.storyboard?.instantiateViewController(withIdentifier: "NasaDetailView") as! NasaDetailView
//        detailView.nasadetailmodel = NasaDetailModel(item: item)
//
//        self.navigationController?.pushViewController(detailView, animated: false)
        
        if let detailView = storyboard?.instantiateViewController(withIdentifier: "NasaDetailView") as? NasaDetailView {

            detailView.nasadetailmodel = NasaDetailModel(item: item)
            navigationController?.pushViewController(detailView, animated: true)
        }
        
    }
    func showalert(msg:String){
        let alert=UIAlertController(title: "That didn't work now", message: msg, preferredStyle: .alert)
        let action=UIAlertAction(title: "Retry", style: .default) { alertaction in
            self.activityIndicator.startAnimating()
            self.viewModel.getNasaImages()
        }
        alert.addAction(action)
        self.present(alert, animated: true)
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 138
    }

    

}

