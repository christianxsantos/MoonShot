import SwiftUI

struct AstronautView: View {
    let missions: [Mission] = Bundle.main.decode("missions")
    let mission: Mission
    let astronauts: [String: Astronaut]
    let astronaut: Astronaut

    var pastMissions: [Mission] {
        missions.filter { $0.crew.contains(where: { $0.name == astronaut.id }) }
    }
    
    var astronautRole: String {
        mission.crew.first(where: { $0.name == astronaut.id })?.role ?? "No Role"
    }

    var body: some View {
        ScrollView {
                Image(astronaut.image)
                    .resizable()
                    .scaledToFill()
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                VStack(alignment:.center){
                    Text(astronaut.name)
                        .font(.title.bold())
                    Text(astronautRole)
                    
                }
            
            Divider().overlay(Color.white.opacity(0.2))
                .padding(.horizontal,50)
                .padding(.top, 12)
                .padding(.bottom, 12)
                
                Text("About")
                .font(.title2.bold())
                .foregroundStyle(LinearGradient(colors:[.gray,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.bottom,-1)

                Text(astronaut.description)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)

                Divider().overlay(Color.white.opacity(0.2))
                .padding(.horizontal,50)
                .padding(.top, 12)
                .padding(.bottom, 12)

                // Past missions
                if !pastMissions.isEmpty {
                    Text("Missions")
                        .font(.title2.bold())
                        .foregroundStyle(LinearGradient(colors:[.gray,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                        .padding(.bottom,-2)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(pastMissions) { past in
                                NavigationLink {
                                    MissionView(mission: past, astronauts: astronauts)
                                } label: {
                                    VStack(spacing: 8) {
                                        Image(past.image)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 80)
                                            .shadow(radius: 2, y: 1)

                                        Text(past.displayName)
                                            .font(.subheadline.bold())
                                            .lineLimit(1)
                                            .minimumScaleFactor(0.8)
                                    }
                                    .foregroundStyle(.white)
                                    .padding(12)
                                    .frame(width: 150, height: 150)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.ultraThinMaterial)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 170)
                } else {
                    Text("No other recorded missions.")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.vertical, 16)
            .background(Color.black.ignoresSafeArea())
            .preferredColorScheme(.dark)
        }
        
    }

#Preview {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    let missions: [Mission] = Bundle.main.decode("missions")
    AstronautView(mission: missions[5], astronauts: astronauts, astronaut: astronauts["armstrong"]!)
}
