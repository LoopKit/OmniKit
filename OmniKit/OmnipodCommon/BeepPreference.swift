//
//  BeepPreference.swift
//  OmniKit
//
//  Created by Pete Schwamb on 2/14/22.
//  Copyright © 2022 LoopKit Authors. All rights reserved.
//

import Foundation
import SwiftUI

public enum BeepPreference: Int, CaseIterable {
    case silent
    case manualCommands
    case extended

    public var title: String {
        switch self {
        case .silent:
            return LocalizedString("Disabled", comment: "Title string for BeepPreference.silent")
        case .manualCommands:
            return LocalizedString("Enabled", comment: "Title string for BeepPreference.manualCommands")
        case .extended:
            return LocalizedString("Extended", comment: "Title string for BeepPreference.extended")
        }
    }

    public var description: String {
        // Cannot figure out how to get appName here
        // @Environment(\.appName) var appName
        // ToDo - insert the appName properly
        let appName: String = "the app"

        switch self {
        case .silent:
            return LocalizedString("No confidence reminders are used.", comment: "Description for BeepPreference.silent")
        case .manualCommands:
            return String(format: LocalizedString("Confidence reminders will sound for commands you initiate, like bolus, cancel bolus, suspend, resume, save notification reminders, etc. When %1$@ automatically adjusts delivery, no confidence reminders are used.", comment: "Description for BeepPreference.manualCommands (1: appName)"), appName)
        case .extended:
            return String(format: LocalizedString("Confidence reminders will sound when %1$@ automatically adjusts delivery as well as for commands you initiate.", comment: "Description for BeepPreference.extended (1: appName)"), appName)
        }
    }

    var shouldBeepForManualCommand: Bool {
        return self == .extended || self == .manualCommands
    }

    var shouldBeepForAutomaticCommands: Bool {
        return self == .extended
    }

    func shouldBeepForCommand(automatic: Bool) -> Bool {
        if automatic {
            return shouldBeepForAutomaticCommands
        } else {
            return shouldBeepForManualCommand
        }
    }
}
