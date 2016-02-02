//: ## Understanding Unicode

let circledAWithAcute: Character = "\u{61}\u{301}\u{20DD}"

let circleCombinedAWithAcute: Character = "\u{E1}\u{20DD}"

circledAWithAcute == circleCombinedAWithAcute
