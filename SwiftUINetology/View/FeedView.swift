//
//  FeedView.swift
//  SwiftUINetology
//
//  Created by TIS Developer on 17.05.2022.
//

import SwiftUI

struct FeedItem {
    var name : String
}

struct FeedListItem : View {
    var contentItem : FeedItem
    var body: some View {
        HStack {
            Image("Mortal_kombat_logo").resizable().aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            
            Spacer()
            
            Text("\(contentItem.name)")
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
        }
        
    }
}

struct FeedView: View {
    var body: some View {
        List {
            Section(header: Text("Mortal Kombat")) {
                Group {
                    FeedListItem(contentItem: FeedItem(name: "Скорпион"))
                    FeedListItem(contentItem: FeedItem(name: "Соня Блейд"))
                    FeedListItem(contentItem: FeedItem(name: "Лю Кан"))
                    FeedListItem(contentItem: FeedItem(name: "Саб-Зиро"))
                    FeedListItem(contentItem: FeedItem(name: "Райдэн"))
                    FeedListItem(contentItem: FeedItem(name: "Джонни Кейдж"))
                    FeedListItem(contentItem: FeedItem(name: "Коллектор"))
                    FeedListItem(contentItem: FeedItem(name: "Нуб Сайбот"))
                    FeedListItem(contentItem: FeedItem(name: "Кано"))
                    FeedListItem(contentItem: FeedItem(name: "Джеки Бриггс"))
                }
            }.listRowBackground(Color.yellow)
        }.listStyle(.insetGrouped)
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
