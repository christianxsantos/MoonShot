import SwiftUI

struct MissionView: View {
    let mission: Mission
    let astronauts: [String: Astronaut]

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Hero
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .shadow(radius: 6, y: 3)

                VStack(spacing: 4) {
                    Text(mission.displayName)
                        .font(.title2.bold())
                        .foregroundStyle(.white)
                    Text(mission.formattedLaunchDate)
                        .font(.title3)
                        .foregroundStyle(.secondary)         // <- use formatted date
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
                    .padding(.bottom,-8)

                // Description
                Text(mission.description)
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 20)
                    .multilineTextAlignment(.leading)

                Divider().overlay(Color.white.opacity(0.2))
                    .padding(.horizontal,50)
                    .padding(.top, 12)
                    .padding(.bottom, 12)
                
                Text("Crew")
                    .font(.title2.bold())
                    .foregroundStyle(LinearGradient(colors:[.gray,.white], startPoint: .topLeading, endPoint: .bottomTrailing))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.bottom,-12)

                // Crew scroller
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(mission.crew, id: \.name) { member in
                            if let astro = astronauts[member.name] {
                                NavigationLink {
                                    AstronautView(mission: mission, astronauts: astronauts, astronaut: astro)
                                } label: {
                                    VStack(spacing: 11) {
                                        Image(member.name)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 90)
                                            .clipShape(RoundedRectangle(cornerRadius: 12))
                                            .shadow(radius: 2, y: 1)
                                        VStack(spacing: 0){
                                            Text(astro.name)
                                                .font(.headline.bold())
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.7)
                                                .foregroundStyle(.white)
                                            
                                            Text(member.role)
                                                .font(.subheadline)
                                                .foregroundStyle(.secondary)
                                        }
                                        .foregroundStyle(.white)
                                    }
                                    
                                    .padding(12)
                                    .frame(width: 165, height: 180)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.ultraThinMaterial, lineWidth: 1)
                                    )
                                }
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                .frame(height: 200)
            }
            .padding(.vertical, 16)
            .padding(.bottom, 8)
        }
        .background(Color.black.ignoresSafeArea())
        .preferredColorScheme(.dark)
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    MissionView(mission: missions.first!, astronauts: astronauts)
}
