//
//  ContentView.swift
//  Flip Learner
//
//  Created by Apple  on 21/05/23.
//

import SwiftUI
import CoreData


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct CardFront : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    ///card data from content view
    let cardData:CardEntity
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.white)
                .frame(width: width, height: height)
                .shadow(color: .gray, radius: 2, x: 0, y: 0)
            
            Text(cardData.answerAttribute ?? "UNKNOWN")
                .padding()
                .frame(width: width,height: height)
                .foregroundColor(.red)
            
        }.rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
    }
}

struct CardBack : View {
    let width : CGFloat
    let height : CGFloat
    @Binding var degree : Double
    
    ///card data from content view
    let cardData:CardEntity
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .stroke(.pink.opacity(0.7), lineWidth: 3)
                .frame(width: width, height: height)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.red.opacity(0.2))
                .frame(width: width, height: height)
                .shadow(color: .white, radius: 2, x: 0, y: 0)
            
            RoundedRectangle(cornerRadius: 20)
                .fill(.pink.opacity(0.4))
                .padding(3)
                .frame(width: width, height: height)
            
            
            VStack{
                ScrollView(showsIndicators:false){
                    Text(cardData.hintAttribute ?? "UNKNOWN")
                }
                .padding()
                .frame(width: width,height: height)
                .foregroundColor(.white)
                
            }
            
            GeometryReader { geometry in                    // Get the geometry
                ScrollView(.vertical) {
                    VStack {
                        Text(cardData.questionAttribute ?? "UNKNOWN")
                            .frame(width: width,height: height)              // Set your max width
                    }
                    
                    .padding()
                    .background(.thinMaterial)
                    .cornerRadius(20)
                    .frame(width: geometry.size.width)      // Make the scroll view full-width
                    .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent
                    
                }
            }
            
            
        }
        .rotation3DEffect(Angle(degrees: degree), axis: (x: 0, y: 1, z: 0))
        
    }
}

struct ContentView: View {
    //MARK: Variables
    @State var backDegree = 0.0
    @State var frontDegree = -90.0
    @State var isFlipped = false
    
    let width : CGFloat = 300
    let height : CGFloat = 350
    let durationAndDelay : CGFloat = 0.3
    
    //MARK: For adding new FlipCard
    @State var showAddNewFlipcard:Bool = false
    
    //MARK: StateObject
    //@ObservedObject var flashCardVm = FlashCardViewModel()
    
    @EnvironmentObject var flashCardVm:FlashCardViewModel
    
    
    //MARK: to fetch flicards from Local db
    @FetchRequest(sortDescriptors: []) var flipcards: FetchedResults<CardEntity>
    
    //MARK: for environment
    @Environment(\.managedObjectContext) var moc
    
    
    //MARK: View Body
    var body: some View {

        NavigationStack {
            ZStack {
                
                background
                    .onAppear{
                        for eachCard in flipcards{
                            flashCardVm.flashCardModelsArray.append(eachCard)
                        }
                    }
                
                flashCard
                
            }//:Zstack
            .overlay(alignment:.bottom){
                left_rightArrow
            }
            .overlay(alignment:.top){
                HStack{
                    Text("Flip Learner")
                          .font(.headline)
                          .padding()
                   
                }
            }
            .overlay(alignment:.topTrailing){
                NavigationLink {
                    AddNewFlipCardView()
                } label: {
                    Image(systemName: "plus")
                        .padding()
                        .foregroundColor(.black)
                        
                }

                    
            }
            
            .overlay(alignment:.topLeading){
                NavigationLink {
                    EditFlipCardView()
                } label: {
                    Image(systemName: "square.and.pencil")
                        .padding()
                        .foregroundColor(.black)
                }

            }
        }
       
            
    }
    
    var background: some View {
        LinearGradient(gradient: Gradient(colors: [.pink.opacity(0.6),.pink.opacity(0.4)]), startPoint: .topLeading, endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
    
    var flashCard: some View {
        ZStack{
            if !flashCardVm.flashCardModelsArray.isEmpty{
                
            
                CardFront(width: width, height: height, degree: $frontDegree, cardData:flashCardVm.flashCardModelsArray[0])
                   
                
                CardBack(width: width, height: height, degree: $backDegree, cardData: flashCardVm.flashCardModelsArray[0])
            }
                
        }
        .onTapGesture {
            flipCard ()
        }
    }
    
    var left_rightArrow: some View {
        HStack(spacing:60){
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50,height: 50)
                .foregroundColor(.pink.opacity(0.2))
                .overlay(alignment:.center){
                    Image(systemName: "arrow.left")
                }
                .onTapGesture {
                    showPreviousQuestion()
                }
               
            
            Image(systemName: "circle.fill")
                .resizable()
                .frame(width: 50,height: 50)
             
                .foregroundColor(.pink.opacity(0.2))
                .foregroundColor(.white)
                .overlay(alignment:.center){
                    Image(systemName: "arrow.right")
                }
                
                .onTapGesture {
                    showNextQuestion()
                }
        }//:Hstack
        

    }
    
    //MARK: Functions
    func showNextQuestion(){
        let arrayLength = flashCardVm.flashCardModelsArray.count
        //here im just holding zeroth index and  doing a left shift to all element in the array , then after the execution of for loop  making last index value as holded zeroth index value
        let zerothIndexValue = flashCardVm.flashCardModelsArray[0]
        
        for each in 0..<arrayLength-1{
            flashCardVm.flashCardModelsArray[each] = flashCardVm.flashCardModelsArray[each+1]
        }
        
        
        flashCardVm.flashCardModelsArray[arrayLength-1] = zerothIndexValue
            
    }//:showNextQuestion
    
    func showPreviousQuestion(){
        let arrayLength = flashCardVm.flashCardModelsArray.count
        
        let lastIndexValue = flashCardVm.flashCardModelsArray[arrayLength-1]
        
        for index in stride(from:arrayLength-1 , to: 0 , by: -1){
            flashCardVm.flashCardModelsArray[index] = flashCardVm.flashCardModelsArray[index-1]
        }
        
        flashCardVm.flashCardModelsArray[0] = lastIndexValue
    }//:showPreviousQuestion
    
    //MARK: Flip Card Function
    func flipCard () {
        isFlipped = !isFlipped
        if isFlipped {
            withAnimation(.linear(duration: durationAndDelay)) {
                backDegree = 90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                frontDegree = 0
            }
        } else {
            withAnimation(.linear(duration: durationAndDelay)) {
                frontDegree = -90
            }
            withAnimation(.linear(duration: durationAndDelay).delay(durationAndDelay)){
                backDegree = 0
            }
        }
    }//:flipCard
}
