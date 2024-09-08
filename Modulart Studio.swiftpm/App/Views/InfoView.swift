import SwiftUI

struct InfoView: View {
    
    
    
    //MARK: - Properties
    
    private let introduction = try? AttributedString(markdown: """
When dividing two integers, we have an equation that looks like the following:

_`A / B = Q + R`_
_`A`_ is the dividend
_`B`_ is the divisor
_`Q`_ is the quotient
_`R`_ is the remainder

Occasionally, we are only interested in getting the remainder of the division. For these cases, we can use the modulo operator, noted (_`mod`_).

_`A mod B = R`_
_`B`_ is the modulus
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let congruence = try? AttributedString(markdown: """
In modular arithmetic, for a positive integer _`N`_, an integer _`A`_ is said to be congruent to an integer _`B`_ modulo _`N`_ if the difference _`(A − B)`_ is a multiple of _`N`_:
_`A − B = K * N`_ with _`K`_ an integer.

We denote the congruence relation like the following:
_`A ≡ B (mod N)`_
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let clock = try? AttributedString(markdown: """
A commonplace example of modular arithmetic is the 12-hour clock where, every 12 hours, numbers "wrap around".

If the time is 7:00 now, what time will it be 8 hours later?
_`(7 + 8) mod 12 = 3`_
_`(7 + 8) mod 24 = 15`_
Therefore, it will be 3:00 on the 12-hour clock or 15:00 on the 24-hour one.

We can thus determine congruence between the hour on the 12-hour clock with the hour on the 24-hour clock:
_`3 ≡ 15 (mod 12)`_
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let unitCircle1 = try? AttributedString(markdown: """
By relating points on a unit circle, we can visualize differently modular multiplication. In the figure below, _`B`_ and _`N`_ remain constant at _`B = 2`_ and _`N = 10`_ while we increment A from zero. For each _`A`_, we take the result of _`AB mod n`_. Then, we trace a line from A on the unit circle to that product.
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let unitCircle2 = try? AttributedString(markdown: """
For all _`A`_ and _`B = 2`_, increasing the modulus reveals better and better approximations of a cardioid.
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let mandelbrot = try? AttributedString(markdown: """
The Mandelbrot set, first defined in 1978, is a set of complex numbers _`c`_ for which the function _`f_c(z) = z² + c`_ does not diverge to infinity when iterated from _`z = 0`_.

The resulting cardioid for _`B = 2`_ can occur in many places, one of those being the main continent in the Mandelbrot set. The nephroid for _`B = 3`_ and other subsequent shapes can also occur in the Multibrot set with _`f_c(z) = zᴮ + c`_.
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    private let programming = try? AttributedString(markdown: """
Many programming languages and calculators have a _`mod`_ operator, typically represented with the _`%`_ symbol. However, some languages use the symbol as a remainder operator rather than a modulus operator. Unlike the latter, the former operator may return a negative value.
""", options: .init(interpretedSyntax: .inlineOnlyPreservingWhitespace))
    
    
    
    //MARK: - Body
    
    var body: some View {
        ZStack {
            Color.background
                .ignoresSafeArea()
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .leading, spacing: 30) {
                    Text("Modular Multiplication")
                        .font(.title)
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Introduction")
                            .font(.headline)
                        Text(introduction ?? "")
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Congruence")
                            .font(.headline)
                        Text(congruence ?? "")
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Visualizing Modulus: Clock")
                            .font(.headline)
                        Text(clock ?? "")
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Visualizing Modulus: Unit Circle")
                            .font(.headline)
                        Text(unitCircle1 ?? "")
                        HStack {
                            Spacer()
                            Image("Info Figures/Figure 1")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .padding(.vertical)
                        Text(unitCircle2 ?? "")
                        HStack {
                            Spacer()
                            Image("Info Figures/Figure 2")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .padding(.vertical)
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Mandelbrot Set")
                            .font(.headline)
                        Text(mandelbrot ?? "")
                        HStack {
                            Spacer()
                            Image("Info Figures/Figure 3")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                            Image("Info Figures/Figure 4")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .padding()
                        HStack {
                            Spacer()
                            Image("Info Figures/Figure 5")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                            Image("Info Figures/Figure 6")
                                .resizable()
                                .scaledToFit()
                            Spacer()
                        }
                        .padding()
                    }
                    VStack(alignment: .leading, spacing: 15) {
                        Text("Programming Languages and Calculators")
                            .font(.headline)
                        Text(programming ?? "")
                    }
                    Spacer()
                }
                .frame(maxWidth: 500)
                .padding()
            }
        }
        .lineLimit(nil)
        .multilineTextAlignment(.leading)
        .navigationTitle("Learn More")
    }
    
}
