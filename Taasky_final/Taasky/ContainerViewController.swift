//
//  ContainerViewController.swift
//  Taasky
//
//  Created by I_MT on 2017/3/8.
//  Copyright © 2017年 Ray Wenderlich. All rights reserved.
//

import UIKit

class ContainerViewController: UIViewController,UIScrollViewDelegate {
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var menuContainerView: UIView!
    private var detailViewController: DetailViewController?
    var showingMenu = false

    var menuItem: NSDictionary? {
        didSet {
            hideOrShowMenu(show: false, animated: true)
            if let detailViewController = detailViewController {
                detailViewController.menuItem = menuItem
            }
        }
    }
 
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hideOrShowMenu(show: showingMenu, animated: false)
        menuContainerView.layer.anchorPoint = CGPoint(x: 1.0, y: 0.5)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailViewSegue" {
        let navigationController = segue.destination as! UINavigationController
        detailViewController = navigationController.topViewController as? DetailViewController
        }
    }
    // MARK: ContainerViewController
    func hideOrShowMenu(show: Bool, animated: Bool) {
        let menuOffset = menuContainerView.bounds.width
        scrollView.setContentOffset(show ? CGPoint.zero : CGPoint(x: menuOffset, y: 0), animated: animated)
        showingMenu = show
    }
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        /*
         Fix for the UIScrollView paging-related issue mentioned here:
         http://stackoverflow.com/questions/4480512/uiscrollview-single-tap-scrolls-it-to-top
         */
        scrollView.isPagingEnabled = scrollView.contentOffset.x < (scrollView.contentSize.width - scrollView.frame.width)
        let menuOffset = menuContainerView.bounds.width
        showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)


        let multiplier = 1.0 / menuContainerView.bounds.width
        let offset = scrollView.contentOffset.x * multiplier
        let fraction = 1.0 - offset
        menuContainerView.layer.transform = transformForFraction(fraction: fraction)
        menuContainerView.alpha = fraction
        
        if let rotatingView = detailViewController?.hamburgerView {
            rotatingView.rotate(fraction: fraction)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let menuOffset = menuContainerView.bounds.width
//        showingMenu = !CGPoint(x: menuOffset, y: 0).equalTo(scrollView.contentOffset)
    }
    func transformForFraction(fraction:CGFloat) -> CATransform3D {
        var identity = CATransform3DIdentity
        identity.m34 = -1.0 / 1000.0;
        let angle = Double(1.0 - fraction) * -M_PI_2
        let xOffset = menuContainerView.bounds.width * 0.5
        let rotateTransform = CATransform3DRotate(identity, CGFloat(angle), 0.0, 1.0, 0.0)
        let translateTransform = CATransform3DMakeTranslation(xOffset, 0.0, 0.0)
        return CATransform3DConcat(rotateTransform, translateTransform)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
