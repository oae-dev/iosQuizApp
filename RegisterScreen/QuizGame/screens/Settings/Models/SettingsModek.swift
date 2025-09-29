//
//  SettingsModek.swift
//  RegisterScreen
//
//  Created by Dev on 29/09/25.
//

import Foundation
import SwiftUI

struct SettingsItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let destination: AnyView
}
