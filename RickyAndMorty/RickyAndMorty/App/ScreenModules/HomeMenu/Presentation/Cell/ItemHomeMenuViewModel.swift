//
//  ItemHomeMenuViewModel.swift
//  RickyAndMorty
//
//  Created by 박현준 on 10/11/23.
//

struct ItemHomeMenuViewModel {
    private let menuItem: MenuItem
    
    init(menuItem: MenuItem) {
        self.menuItem = menuItem
    }
    
    var title: String {
        menuItem.title.capitalized
    }
    
    var imageName: String {
        menuItem.title
    }
}
