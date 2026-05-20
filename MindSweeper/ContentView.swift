//
//  ContentView.swift
//  MindSweeper
//
//  Created by 曾梓恒 on 5/20/26.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            FocusView()
                .tabItem {
                    Label("Focus", systemImage: "brain.head.profile")
                }
            TasksView()
                .tabItem {
                    Label("Tasks", systemImage: "checklist")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "chart.bar.fill")
                }
        }
    }
}

// MARK: - Placeholder Tabs

struct FocusView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: 64))
                    .foregroundStyle(.tint)
                Text("Focus Session")
                    .font(.title2)
                    .foregroundStyle(.secondary)
            }
            .navigationTitle("MindSweeper")
        }
    }
}

struct TasksView: View {
    var body: some View {
        NavigationStack {
            Text("Tasks go here")
                .foregroundStyle(.secondary)
                .navigationTitle("Tasks")
        }
    }
}

struct HistoryView: View {
    var body: some View {
        NavigationStack {
            Text("Session history goes here")
                .foregroundStyle(.secondary)
                .navigationTitle("History")
        }
    }
}

#Preview {
    ContentView()
}
