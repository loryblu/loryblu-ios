import SwiftUI

struct PasswordRulesView: View {
    let password: String

    private var containsSize: Bool {
        ValidateRules.validateSize(password: password)
    }

    private var containsUppercase: Bool {
        ValidateRules.validateUppercase(password: password)
    }

    private var containsLowercase: Bool {
        ValidateRules.validateLowercase(password: password)
    }

    private var containsNumber: Bool {
        ValidateRules.validateNumber(password: password)
    }

    private var containsSpecial: Bool {
        ValidateRules.validateSpecial(password: password)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
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
        PasswordRulesView(password: "Scp12%jdhj")
    }
}
