//
//  PasswordRulesView.swift
//  LoryBlu
//
//  Created by Suh on 21/07/23.
//

import SwiftUI

struct PasswordRulesView: View {
    let containsSize: Bool
    let containsUppercase: Bool
    let containsLowercase: Bool
    let containsNumber: Bool
    let containsSpecial: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(LBStrings.Rules.title)
                .foregroundColor(LBColor.text)
                .font(LBFont.bodyLittleSmall)
            LBLabel(title: LBStrings.Rules.rule1, type: check(rule: containsSize))
            LBLabel(title: LBStrings.Rules.rule2, type: check(rule: containsUppercase))
            LBLabel(title: LBStrings.Rules.rule3, type: check(rule: containsLowercase))
            LBLabel(title: LBStrings.Rules.rule4, type: check(rule: containsNumber))
            LBLabel(title: LBStrings.Rules.rule5, type: check(rule: containsSpecial))
        }
    }

    private func check(rule: Bool) -> LBLabel.TypeIcon {
        if rule {
            return .check
        }
        return .wrong
    }
}

struct PasswordRulesView_Previews: PreviewProvider {
    static var previews: some View {
        PasswordRulesView(
            containsSize: false,
            containsUppercase: true,
            containsLowercase: false,
            containsNumber: false,
            containsSpecial: true)
    }
}
