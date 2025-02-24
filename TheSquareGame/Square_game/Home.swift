import SwiftUI

struct HomeView: View {
//    var body: some View {
//        NavigationView {
//            VStack {
//                NavigationLink(destination: GridView()) {
//                    Text("Play")
//                        .font(.title)
//                        .fontWeight(.bold)
//                        .foregroundColor(.white)
//                        .padding()
//                        .frame(width: 150, height: 50)
//                        .background(Color.red)
//                        .cornerRadius(10)
//                }
//                .padding()
//            }
//            .navigationBarHidden(true)
//        }
//    }
    
    
    
    @State private var offset = CGSize.zero
    
    var body: some View{
        ZStack{
            Color.blue
                .frame(width: 300, height: 300)
                .overlay( Text("Map View").foregroundColor(.white)
                    .font(.largeTitle))
                .shadow(radius: 10)
                .offset(offset)
                .gesture(DragGesture().onChanged({ value in
                    self.offset = CGSize(width: value.translation.width, height: value.translation.height)
                }))
//                .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    HomeView()
}
