//
//  SwiftUIView.swift
//  MoonShot
//
//  Created by Christian on 10/29/25.
//

import SwiftUI

struct ContentView: View {
    // Style of layout
    @State private var showingGrid = true
    
    // Loading Data
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts")
    let missions: [Mission] = Bundle.main.decode("missions")
    
    // Layout
    let layout = [
        GridItem(.adaptive(minimum: 150), alignment: .center)
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                Group {
                    if showingGrid {
                        ScrollView {
                            // Header
                            VStack {
                                Image("nasa")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: 200)
                                Text("Moon Missions")
                                    .font(.title.bold())

                                Picker("Layout", selection: $showingGrid) {
                                    Text("Grid").tag(true)
                                    Text("List").tag(false)
                                }
                                .pickerStyle(.segmented)
                                .tint(.white) // so it’s visible on dark bg
                                .scaleEffect(1.1)
                                .frame(width: 180)
                                .padding(3)
                                .background(.ultraThinMaterial)
                                .clipShape(Capsule())
                                
                            }
                            .padding(.bottom, 13)
                            .foregroundStyle(.white)

                            // Grid
                            LazyVGrid(columns: layout, spacing: 16) {
                                ForEach(missions) { mission in
                                    NavigationLink(value: mission) {
                                        VStack(spacing: 6) {
                                            Image(mission.image)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 100)
                                                .shadow(radius: 3, y: 2)
                                                .padding(.bottom, 10)

                                            Text(mission.displayName)
                                                .font(.title3.bold())
                                                .foregroundStyle(.white)
                                                .lineLimit(1)
                                                .minimumScaleFactor(0.7)
                                                .padding(.bottom, -4)

                                            Text(mission.formattedLaunchDate)
                                                .font(.subheadline.bold())
                                                .foregroundStyle(.white.opacity(0.9))
                                        }
                                    }
                                    .frame(width: 160, height: 180)
                                    .background(.ultraThinMaterial)
                                    .clipShape(RoundedRectangle(cornerRadius: 18))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 16)
                                            .stroke(.ultraThinMaterial, lineWidth: 1)
                                    )
                                }
                            }
                            .padding(.horizontal)
                        }
                    } else {
                        // Header (same as grid)
                        VStack {
                            Image("nasa")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 200)
                            Text("Moon Missions")
                                .font(.title.bold())
                                .foregroundStyle(.white)

                            Picker("Layout", selection: $showingGrid) {
                                Text("Grid").tag(true)
                                Text("List").tag(false)
                            }
                            .pickerStyle(.segmented)
                            .tint(.white) // so it’s visible on dark bg
                            .scaleEffect(1.1)
                            .frame(width: 180)
                            .padding(3)
                            .background(.ultraThinMaterial)
                            .clipShape(Capsule())
                        }

                        // List
                        List(missions) { mission in
                            NavigationLink(value: mission) {
                                HStack {
                                    Text(mission.displayName)
                                        .foregroundStyle(.white)
                                        .font(.title3)
                                    Spacer()
                                }
                                .padding(16)
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.white.opacity(0.2), lineWidth: 1)
                                )
                                .contentShape(RoundedRectangle(cornerRadius: 10))
                            }
                            .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                        .scrollContentBackground(.hidden)
                        .background(Color.black)
                    }
                }
            }
            .background(Color.black.ignoresSafeArea())
            .navigationTitle("Moon Missions")
            // .toolbar(.hidden, for: .navigationBar) // keep visible while testing
            .navigationDestination(for: Mission.self) { mission in
                MissionView(mission: mission, astronauts: astronauts)
            }
        }
    }
                
    }

#Preview {
    ContentView()
}
