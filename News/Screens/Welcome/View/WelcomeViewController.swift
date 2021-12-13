//
//  WelcomeViewController.swift
//  News
//
//  Created by Александр Басов on 12/7/21.
//

import UIKit
import PanModal

class WelcomeViewController: UIViewController {

    @IBOutlet weak var holderView: UIView!

    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
}
    
//MARK: - PanModal
extension WelcomeViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(350)
    }
    
    var anchorModalToLongForm: Bool {
        return false
    }
    
    var shouldRoundTopCorners: Bool {
        return true
    }
    
    var cornerRadius: CGFloat {
        return 16
    }
    
    var showDragIndicator: Bool {
        return true
    }

}


// MARK: - Configure
private extension WelcomeViewController {

    private func configure() {
        
        scrollView.frame = holderView.bounds
        holderView.addSubview(scrollView)

        let titles = ["Welcome to News App", "Sorting News", "Cash News"]
        let description = ["Be the first to know the news from all over the world!","Use a convenient sorting of news into categories!","Cash news and read it everywhere!"]

        for x in 0..<3 {
          
            let pageView = UIView(frame: CGRect(x: CGFloat(x) * holderView.frame.size.width , y: 0, width: holderView.frame.size.width, height: holderView.frame.size.height))
            scrollView.addSubview(pageView)
            
            let imageView = UIImageView(frame: CGRect(x: 10, y: 20, width: pageView.frame.size.width - 20, height: pageView.frame.size.height - 60 - 130 - 15))
            
            let labelTitle = UILabel(frame: CGRect(x: 10, y: 130, width: pageView.frame.size.width - 20, height: 120))
           
            let labelDescription = UILabel(frame: CGRect(x: 10, y: imageView.frame.size.height + 50, width: pageView.frame.size.width - 20, height: 60))
           
            let button = UIButton(frame: CGRect(x: 10, y: pageView.frame.size.height - 60, width: pageView.frame.size.width - 20, height: 50))
            
            // - Title
            labelTitle.textAlignment = .center
            labelTitle.font = UIFont(name: "Hiragino Mincho ProN ", size: 19)
            pageView.addSubview(labelTitle)
            labelTitle.text = titles[x]
            
            // - Image
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: "welcome_\(x + 1)")
            imageView.layer.cornerRadius = 10
            pageView.addSubview(imageView)

            // - description
            labelDescription.textAlignment = .center
            labelDescription.numberOfLines = 0
            labelDescription.font = UIFont(name: "Hiragino Mincho ProN ", size: 18)
            labelDescription.textColor = .lightGray
            labelDescription.text = description[x]
            pageView.addSubview(labelDescription)

            // - Button
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = #colorLiteral(red: 0.1316036046, green: 0.7196111185, blue: 0.7652722923, alpha: 1)
            button.layer.cornerRadius = 10
            button.setTitle("Continue", for: .normal)
            pageView.addSubview(button)

            if x == 2 {
                button.setTitle("Get started", for: .normal)
            }
            
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            button.tag = x + 1
        }
        
        scrollView.contentSize = CGSize(width: holderView.frame.size.width * 3, height: 0)
        scrollView.isPagingEnabled = true
        
    }
}

//MARK: - Action
private extension WelcomeViewController {
    @objc func didTapButton(_ button: UIButton) {
        guard button.tag < 3 else {
            Core.shared.isNotNewUser()
            dismiss(animated: true, completion: nil)
            return
        }
        scrollView.setContentOffset(CGPoint(x: holderView.frame.size.width * CGFloat(button.tag), y: 0), animated: true)
    }
}


