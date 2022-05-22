//
//  ViewController.swift
//  MovieCase
//
//  Created by Bilge Çakar on 17.05.2022.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var categoryName: UILabel!
    
    @IBOutlet weak var movieListView: UIView!
    
    var moviePresenterObject : ViewToPresenterMovieProtocol?
    
    var movies : [Movies] = []
    
    var categories : [Categories] = []
    
    var count : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Design homepage
        updateUI()
        
        movieListView.isUserInteractionEnabled = true
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        MovieRouter.creatModule(ref: self)
        
        //Swipe Gesture for passing between pages
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        movieListView.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.swipeDesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        movieListView.addGestureRecognizer(swipeLeft)
        
    }
    
    private func updateUI()
    {
        movieListView.frame = CGRect(x: 0, y:0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        categoryName.frame =  CGRect(x: 0, y:20, width: self.view.frame.size.width, height: self.view.frame.size.height*0.10)
        
        movieCollectionView.frame = CGRect(x: 0, y: CGFloat(categoryName.frame.size.height), width: self.view.frame.size.width, height: self.view.frame.size.height-30)
        
        //Food collectionview UI
        let design = UICollectionViewFlowLayout()
        design.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        design.minimumLineSpacing = 10
        design.minimumInteritemSpacing = 5
        let width = movieCollectionView.frame.size.width
        let cellWidht = (width - 30) / 3
        design.itemSize = CGSize(width: cellWidht, height: cellWidht*1.5)
        movieCollectionView.collectionViewLayout = design
        
    }
    
    //Swipe pages
    private func swipeAnimation(direction : CATransitionSubtype)
    {
        DispatchQueue.main.async(execute: {
            let transition: CATransition = CATransition()
            transition.duration = 0.7
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
            transition.type = CATransitionType.push
            transition.subtype = direction
            self.view.window!.layer.add(transition, forKey: nil)
            self.dismiss(animated: false, completion: nil)
        })
    }
    
    
    @objc func swipeDesture(sender : UISwipeGestureRecognizer?)
    {
        
        if let swipeSender = sender
        {
            switch swipeSender.direction
            {
            case UISwipeGestureRecognizer.Direction.left :
                
                if count >= 0 && count < 18
                {
                    swipeAnimation(direction: CATransitionSubtype.fromRight)
                    count += 1
                    showMovies()
                }
                
            case UISwipeGestureRecognizer.Direction.right :
                
                if count > 0 && count < 19
                {
                    swipeAnimation(direction: CATransitionSubtype.fromLeft)
                    count -= 1
                    showMovies()
                }
                
            default :
                break
            }
        }
        
    }
    
    //List Movies and get Category Name
    private func showMovies()
    {
        
        moviePresenterObject?.getAllCategory{ result in
            switch result{
            case .success(let response):
                self.categories = response.genres ?? []
            case .failure(let error):
                print(error)
            }
            
            self.categoryName.text = self.categories[self.count].name
            
            self.moviePresenterObject?.getAllMovie(id: self.categories[self.count].id!, completion: {
                result in
                
                switch result{
                case .success(let response):
                    self.movies = response.results ?? []
                    self.movieCollectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            })
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showMovies()
    
    }
    
}

//Collectionview
extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        cell.configure(movie: movies[indexPath.row])
        cell.layer.cornerRadius = 10
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        performSegue(withIdentifier: "goMedia", sender: movie)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goMedia"
        {
            let movie = sender as? Movies
            let destinationVC = segue.destination as! MediaViewController
            destinationVC.movie = movie
        }
    }

}

