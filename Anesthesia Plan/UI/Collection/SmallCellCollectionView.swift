//
//  SmallCellCollectionView.swift
//  Anesthesia Plan
//
//  Created by Jean-David Morgenstern-Peirolo on 6/28/18.
//  Copyright © 2018 Jean-David Morgenstern-Peirolo. All rights reserved.
//

import UIKit

class SmallCellCollectionView: UICollectionView {
    
    fileprivate let viewModel: MultiChoiceCollectionViewModel
    
    init(viewModel: MultiChoiceCollectionViewModel) {
        self.viewModel = viewModel
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 50, height: 50)
        layout.headerReferenceSize = CGSize(width: 50, height: Constants.questionHeaderHeight)
        super.init(frame: .zero, collectionViewLayout: layout)
        prepareView()
        prepareViewModel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate let sectionInsets: UIEdgeInsets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    fileprivate let HEADER_IDENTIFIER: String = "HeaderView"
    fileprivate let CHOICE_CELL_IDENTIFIER: String = "ChoiceCell"
    
    func prepareView() {
        delegate = self
        dataSource = self
        backgroundColor = Constants.Colors.background
        register(ProblemReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HEADER_IDENTIFIER)
        register(ChoiceCell.self, forCellWithReuseIdentifier: CHOICE_CELL_IDENTIFIER)
    }
    
    func prepareViewModel() {
        viewModel.reloadData = { [weak self] () in
            self?.reloadData()
        }
    }
}

/*************************
 *                       *
 *     DATA SOURCE       *
 *                       *
 *************************/
extension SmallCellCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let choiceViewModel: ChoiceCellModel = viewModel.getChoiceCellModel(at: indexPath)
        let cell = dequeueReusableCell(withReuseIdentifier: CHOICE_CELL_IDENTIFIER, for: indexPath) as! ChoiceCell
        cell.choice = choiceViewModel.body
        cell.checked = choiceViewModel.selected
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header: String = viewModel.header
        switch kind {
        case UICollectionElementKindSectionHeader:
            let headerView = dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HEADER_IDENTIFIER, for: indexPath) as! ProblemReusableView
            headerView.header = header
            return headerView
        default:
            return UICollectionReusableView()
        }
    }
}

/*************************
 *                       *
 *       DELEGATE        *
 *                       *
 *************************/
extension SmallCellCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.choiceSelected(at: indexPath)
    }
}

/*************************
 *                       *
 *     FL DELEGATE       *
 *                       *
 *************************/
extension SmallCellCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8.0
    }
}

