//
//  UpdateFlipCardView.swift
//  Flip Learner
//
//  Created by Apple  on 05/06/23.
//

import SwiftUI
import CoreData

struct UpdateFlipCardView: View {
    @State var flipCard:CardEntity
    @State var questionTxtField:String
    @State var answerTxtField:String
    @State var hintTxtField:String
    
    
    //MARK: for environment
    @Environment(\.managedObjectContext) var moc
    
    //MARK:
    @FetchRequest(sortDescriptors: []) var flipcards: FetchedResults<CardEntity>
    
    //MARK: for environmentobject for
    @EnvironmentObject var flashCardVm:FlashCardViewModel
    
    //MARK: For presentation
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
            Form {
              
                Section {
                    TextField("Enter question", text: $questionTxtField)
                    TextField("Enter Answer", text: $answerTxtField)
                    TextField("Enter hint", text: $hintTxtField)
                }


                Section {
                    Button {
                        print("save flipcard button tapped")
                        updateFlipcardWithCoreData()
                       
                    } label: {
                        HStack{
                            Spacer()
                            Text("Update flip card")
                            Spacer()
                        }
                    }
                }


            }
            .navigationBarTitle("Update current flipcard")
            .background(background.opacity(0.2))
            .scrollContentBackground(.hidden)
    }
    
    var background: some View {
        LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.6),.pink.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
    
    //MARK: Functions
    func updateFlipcardWithCoreData(){
        flipCard.questionAttribute = questionTxtField
        flipCard.answerAttribute = answerTxtField
        flipCard.hintAttribute = hintTxtField

        do{
            try moc.save()
            presentationMode.wrappedValue.dismiss()
        }catch{
            print(error.localizedDescription)
        }
       
    }
}

