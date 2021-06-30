//
//  ViewController.swift
//  TicTacToe
//
//  Created by DCS on 29/06/21.
//  Copyright © 2021 HRK. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    private var state = [2,2,2,2,
                         2,2,2,2,
                         2,2,2,2,
                         2,2,2,2]
    
    private let winningCombinations = [[0, 1, 2, 3], [4, 5,6,7], [8,9,10,11], [12,13,14,15], [0, 5, 10,15], [3,6,9,12], [0,4,8,12], [1,5,9,13],[2,6,10,14],[3,7,11,15]]
    
    
    private var Flag = false
    private var scorex = 0
    private var scoreo = 0
    
    
    private let penal:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 120, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        
        
        let collview = UICollectionView(frame: .zero,collectionViewLayout: layout)
        collview.backgroundColor = .white
        return collview
    }()
    
    private let mybutton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Reset Game", for: .normal)
        btn.addTarget(self, action: #selector(resetgame), for: .touchUpInside)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.backgroundColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 0.8)
        btn.layer.cornerRadius = 50
        return btn
    }()
    
    private let player1:UILabel = {
        let lab = UILabel()
        lab.text = "Player1 :-"
        lab.font = .boldSystemFont(ofSize: 20)
        lab.textAlignment = .center
        lab.textColor = .black
        //lab.backgroundColor = UIColor.gray
        return lab
    }()
    
    private let player2:UILabel = {
        let lab = UILabel()
        lab.text = "Player2 :-"
        lab.font = .boldSystemFont(ofSize: 20)
        lab.textAlignment = .center
        lab.textColor = .black
        //lab.backgroundColor = UIColor.gray
        return lab
    }()
    
    
    private let scorelo:UILabel = {
        let lab = UILabel()
        lab.text = "0"
        lab.font = .boldSystemFont(ofSize: 20)
        lab.textAlignment = .center
        lab.textColor = .black
        //lab.backgroundColor = UIColor.gray
        return lab
    }()
    
    private let scorelx:UILabel = {
        let lab = UILabel()
        lab.text = "0"
       lab.font = .boldSystemFont(ofSize: 20)
        lab.textAlignment = .center
        lab.textColor = .black
        //lab.backgroundColor = UIColor.gray
        return lab
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Tic-Tac-Toe"
        
        view.addSubview(penal)
        view.addSubview(player1)
        view.addSubview(player2)
        view.addSubview(scorelo)
        view.addSubview(scorelx)
        penal.addSubview(mybutton)
        
        
        let bckimage = UIImageView(frame: UIScreen.main.bounds)
        bckimage.image = UIImage(named: "back-7")
        bckimage.contentMode = .scaleToFill
        self.view.insertSubview(bckimage, at: 0)
        
        
        penal.backgroundColor = UIColor.init(red: 0, green: 1, blue: 1, alpha: 0.4)
       
        setupcollectionview()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        penal.frame = view.bounds
        
        
        player1.frame = CGRect(x: 20, y: 100, width: 100, height: 80)
        scorelx.frame = CGRect(x: player1.right + 5, y: 100, width: 50, height: 80)
        
        player2.frame = CGRect(x: scorelx.right + 50, y: 100, width: 100, height: 80)
        scorelo.frame = CGRect(x: player2.right + 5, y: 100, width: 50, height: 80)
        
        mybutton.frame = CGRect(x: 20, y: penal.bottom - 150 , width: view.width - 40, height: 40)
        //mybutton.frame = CGRect(x: 20, y: mytextview.bottom+50, width: view.width-40, height: 40)
    }

}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    
    private func setupcollectionview(){
        penal.register(PenalVC.self, forCellWithReuseIdentifier: "penalvc")
        penal.dataSource = self
        penal.delegate = self
       
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 16
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "penalvc", for: indexPath) as! PenalVC
        cell.setupcell(with: state[indexPath.row])
    
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    
        if state[indexPath.row] != 0 && state[indexPath.row] != 1 {
            
            state.remove(at: indexPath.row)
            
            if Flag {
                state.insert(0, at: indexPath.row)
                scoreo+=1;
            }else{
                state.insert(1, at: indexPath.row)
                scorex+=1;
            }
            
            scorelo.text = String(scoreo)
            scorelx.text = String(scorex)
            Flag = !Flag
            penal.reloadData()
            checkwinner()
        }
    }
    
    private func checkwinner(){
        
        if !state.contains(2){
            let alert = UIAlertController(title: "Game Over", message: "Draw...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
                self?.resetgame()
            }))
            DispatchQueue.main.async {
                self.present(alert,animated: true,completion: nil)
            }
        }
        
        for i in winningCombinations{
            if state[ i[0] ] == state[ i[1] ] && state[ i[1] ] == state[ i[2] ] && state[ i[2] ] == state[ i[3] ] && state[ i[0] ] != 2{
                winnername(player: state[ i[0] ] == 0 ? "player1" : "player2")
                break
            }
        }
    }
    
    private func winnername(player:String){
        let alert = UIAlertController(title: "Game Over", message: "Winner is :- \(player)", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { [weak self] _ in
            self?.resetgame()
        }))
        DispatchQueue.main.async {
            self.present(alert,animated: true,completion: nil)
        }
    }
    
    
    @objc private func resetgame(){
        state = [2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2]
        Flag = false
        scorex = 0
        scoreo = 0
        scorelo.text = "0"
        scorelx.text = "0"
        penal.reloadData()
    }
}

