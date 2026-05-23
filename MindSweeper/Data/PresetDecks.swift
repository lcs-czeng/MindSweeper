//
//  PresetDecks.swift
//  MindSweeper
//
//  Created by Yuk Yeung Chao on 2026-05-23.
//

import Foundation

extension DeckManager {

    static let mathCards: [Card] = [
        Card(question: "What is 12 × 12?", answer: "144"),
        Card(question: "What is the square root of 81?", answer: "9"),
        Card(question: "What is 15% of 200?", answer: "30"),
        Card(question: "Solve: 3x = 27", answer: "9"),
        Card(question: "What is 2⁸?", answer: "256"),
        Card(question: "What is the area of a circle with radius 5? (use π ≈ 3.14)", answer: "78.5"),
        Card(question: "What is the perimeter of a square with side 7?", answer: "28"),
        Card(question: "What is 3/4 as a decimal?", answer: "0.75"),
        Card(question: "What is the LCM of 4 and 6?", answer: "12"),
        Card(question: "What is the GCF of 18 and 24?", answer: "6"),
        Card(question: "What is 7² − 5²?", answer: "24"),
        Card(question: "What is 1000 ÷ 25?", answer: "40"),
    ]

    static let historyCards: [Card] = [
        Card(question: "In what year did World War II end?", answer: "1945"),
        Card(question: "Who was the first President of the United States?", answer: "george washington"),
        Card(question: "In what year did the Berlin Wall fall?", answer: "1989"),
        Card(question: "What ancient wonder was located in Alexandria?", answer: "lighthouse"),
        Card(question: "Who wrote the Declaration of Independence?", answer: "thomas jefferson"),
        Card(question: "In what year did Canada become a country?", answer: "1867"),
        Card(question: "What empire did Julius Caesar lead?", answer: "roman"),
        Card(question: "In what year did the Titanic sink?", answer: "1912"),
        Card(question: "What war was fought between the North and South of the USA?", answer: "civil war"),
        Card(question: "Who was the first person to walk on the moon?", answer: "neil armstrong"),
        Card(question: "What city was the first atomic bomb dropped on?", answer: "hiroshima"),
        Card(question: "In what year did the French Revolution begin?", answer: "1789"),
    ]

    static let scienceCards: [Card] = [
        Card(question: "What is the chemical symbol for gold?", answer: "au"),
        Card(question: "How many bones are in the adult human body?", answer: "206"),
        Card(question: "What planet is closest to the Sun?", answer: "mercury"),
        Card(question: "What is the powerhouse of the cell?", answer: "mitochondria"),
        Card(question: "What gas do plants absorb from the air?", answer: "carbon dioxide"),
        Card(question: "What is the atomic number of oxygen?", answer: "8"),
        Card(question: "What force keeps planets in orbit?", answer: "gravity"),
        Card(question: "What is the speed of light in km/s (approx)?", answer: "300000"),
        Card(question: "What is the most abundant gas in Earth's atmosphere?", answer: "nitrogen"),
        Card(question: "What organ pumps blood through the body?", answer: "heart"),
        Card(question: "What is H₂O commonly known as?", answer: "water"),
        Card(question: "What layer of the Earth do we live on?", answer: "crust"),
    ]

    static let vocabCards: [Card] = [
        Card(question: "What does 'benevolent' mean?", answer: "kind"),
        Card(question: "What is a synonym for 'verbose'?", answer: "wordy"),
        Card(question: "What does 'ambiguous' mean?", answer: "unclear"),
        Card(question: "What is an antonym for 'loquacious'?", answer: "quiet"),
        Card(question: "What does 'ephemeral' mean?", answer: "short-lived"),
        Card(question: "What does 'pragmatic' mean?", answer: "practical"),
        Card(question: "What is a synonym for 'melancholy'?", answer: "sadness"),
        Card(question: "What does 'ubiquitous' mean?", answer: "everywhere"),
        Card(question: "What does 'candid' mean?", answer: "honest"),
        Card(question: "What is an antonym for 'diligent'?", answer: "lazy"),
        Card(question: "What does 'tenacious' mean?", answer: "persistent"),
        Card(question: "What does 'eloquent' mean?", answer: "well-spoken"),
    ]
}
