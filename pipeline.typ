#set page(width: auto, height: auto, margin: 0.5cm)
#set text(font: ("Helvetica", "Arial"))

#let accent-blue = rgb("#2b6cb0")
#let accent-green = rgb("#38a169")
#let accent-purple = rgb("#805ad5")
#let accent-orange = rgb("#dd6b20")
#let accent-red = rgb("#e53e3e")
#let gray-light = rgb("#edf2f7")
#let gray-border = rgb("#cbd5e0")
#let gray-muted = rgb("#718096")
#let dark-text = rgb("#1a202c")

// =========== Helper ===========
#let boxed(content, fill: white, stroke: accent-blue) = block(
  width: 100%, height: 100%,
  fill: fill, stroke: 1.5pt + stroke,
  radius: 6pt,
  inset: 6pt,
  align(center + horizon, content)
)

// =========== Title ===========
#align(center)[
  #text(size: 18pt, weight: "bold")[CapsBench Evaluation Pipeline]
  #linebreak()
  #text(size: 9pt, fill: gray-muted)[200 images · 2,471 yes-no questions · 17 categories]
]

#v(8pt)

// =========== Phase 1 ===========
#block(
  width: 100%,
  fill: rgb("#ebf8ff"),
  stroke: 1pt + accent-blue,
  radius: 8pt,
  inset: 8pt,
  [
    #text(size: 11pt, weight: "bold", fill: accent-blue)[Phase 1: Benchmark Construction]

    #v(6pt)
    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 8pt,
      // Step 1
      boxed[
        #text(size: 10pt, weight: "bold", fill: accent-blue)[① Image Collection]
        #linebreak()
        #text(size: 7.5pt)[200 images]
        #linebreak()
        #text(size: 7.5pt)[9 diverse types]
      ],
      // Step 2
      boxed[
        #set text(fill: dark-text)
        #text(size: 10pt, weight: "bold")[② QA Pair Generation]
        #linebreak()
        #text(size: 7.5pt, fill: accent-orange)["Based on the image" (Sec 4.2)]
        #linebreak()
        #text(size: 7.5pt)[~12 questions/image, 2,471 total]
      ],
      // Step 3
      boxed[
        #text(size: 10pt, weight: "bold", fill: accent-purple)[③ 17-Category Tagging]
        #linebreak()
        #text(size: 7.5pt, fill: accent-purple)[per question]
      ],
    )

    #v(4pt)
    // Arrows between steps (simulated with centered text)
    #align(center, text(size: 11pt, fill: accent-blue)[→  →  →])

    // === Ambiguity ===
    #v(6pt)
    #text(size: 9pt, weight: "bold", fill: accent-red)[⚠️ Ambiguity in QA Generation]

    #v(4pt)
    #grid(
      columns: (1fr, 1fr),
      gutter: 8pt,
      // Option A
      boxed(fill: rgb("#fff5f5"), stroke: accent-red)[
        #set text(fill: accent-red)
        #text(size: 8.5pt, weight: "bold")[Reading A: VLM → QA from image]
        #linebreak()
        #text(size: 7pt)[Supported by: "Based on the image" (Sec 4.2)]
      ],
      // Option B
      boxed(fill: rgb("#fffaf0"), stroke: accent-orange)[
        #set text(fill: accent-orange)
        #text(size: 8.5pt, weight: "bold")[Reading B: Caption → QA (like DPG Hard)]
        #linebreak()
        #text(size: 7pt)[Supported by: "parallels how we constructed CapsBench"]
      ],
    )

    // === Categories ===
    #v(6pt)
    #text(size: 8pt, weight: "bold", fill: accent-purple)[17 Evaluation Categories]
    #v(2pt)

    #let cat-row(items) = {
      for item in items {
        let (name, bg, fg) = item
        box(
          width: 1.1in, height: 0.28in,
          fill: bg, stroke: 0.5pt + fg,
          radius: 3pt,
          inset: 2pt,
          align(center, text(size: 6.5pt, fill: fg, name))
        )
        h(2pt)
      }
    }

    #cat-row(( 
      ("General", rgb("#bee3f8"), accent-blue),
      ("Image Type", rgb("#bee3f8"), accent-blue),
      ("Text", rgb("#bee3f8"), accent-blue),
      ("Color", rgb("#bee3f8"), accent-blue),
      ("Position", rgb("#bee3f8"), accent-blue),
      ("Relation", rgb("#bee3f8"), accent-blue),
      ("Rel. Pos.", rgb("#bee3f8"), accent-blue),
    ))
    #v(2pt)
    #cat-row((
      ("Entity", rgb("#c6f6d5"), accent-green),
      ("Entity Size", rgb("#c6f6d5"), accent-green),
      ("Entity Shape", rgb("#c6f6d5"), accent-green),
      ("Count", rgb("#c6f6d5"), accent-green),
      ("Emotion", rgb("#c6f6d5"), accent-green),
      ("Blur", rgb("#fed7d7"), accent-red),
      ("Img Artifacts", rgb("#fed7d7"), accent-red),
    ))
    #v(2pt)
    #cat-row((
      ("Proper Noun", rgb("#feebc8"), accent-orange),
      ("Color Palette", rgb("#e9d8fd"), accent-purple),
      ("Color Grading", rgb("#e9d8fd"), accent-purple),
    ))
  ]
)

#v(6pt)
#align(center, text(size: 16pt, fill: accent-blue)[↓])
#v(6pt)

// =========== Phase 2 ===========
#block(
  width: 100%,
  fill: rgb("#f0fff4"),
  stroke: 1pt + accent-green,
  radius: 8pt,
  inset: 8pt,
  [
    #text(size: 11pt, weight: "bold", fill: accent-green)[Phase 2: Caption Evaluation]

    #v(6pt)
    #grid(
      columns: (1fr, 1.8fr, 1.2fr, 1fr),
      gutter: 6pt,
      // Step 4: Input
      boxed[
        #text(size: 10pt, weight: "bold", fill: accent-blue)[Candidate Caption]
        #linebreak()
        #text(size: 7pt)[from model under test]
      ],
      // Step 5: LLM answers
      boxed[
        #text(size: 10pt, weight: "bold", fill: dark-text)[④ LLM Answers Questions]
        #linebreak()
        #text(size: 7.5pt, fill: accent-orange)[Claude-3.5 Sonnet]
        #linebreak()
        #text(size: 7pt)[Caption only · Yes / No / N/A]
      ],
      // Step 6: Consensus
      boxed[
        #text(size: 10pt, weight: "bold", fill: accent-purple)[⑤ Consensus (3×)]
        #linebreak()
        #text(size: 7pt)[Majority vote per question]
      ],
      // Step 7: Score
      boxed[
        #text(size: 10pt, weight: "bold", fill: accent-green)[⑥ Accuracy Score]
        #linebreak()
        #text(size: 7pt)[Per-category + combined]
      ],
    )
    #align(center, text(size: 11pt, fill: accent-green)[→  →  →])

    // Results
    #v(8pt)
    #text(size: 10pt, weight: "bold")[Results (Section 7, Claude-3.5 Sonnet as judge):]
    #v(4pt)

    #grid(
      columns: (1fr, 1fr, 1fr),
      gutter: 6pt,
      boxed(fill: rgb("#c6f6d5"), stroke: accent-green)[
        #text(size: 10pt, weight: "bold", fill: accent-green)[PG Captioner]
        #linebreak()
        #text(size: 11pt, weight: "bold", fill: accent-green)[72.19%]
      ],
      boxed(fill: rgb("#e9d8fd"), stroke: accent-purple)[
        #text(size: 10pt, weight: "bold", fill: accent-purple)[Claude-3.5 Sonnet]
        #linebreak()
        #text(size: 11pt, weight: "bold", fill: accent-purple)[71.78%]
      ],
      boxed(fill: rgb("#feebc8"), stroke: accent-orange)[
        #text(size: 10pt, weight: "bold", fill: accent-orange)[GPT-4o]
        #linebreak()
        #text(size: 11pt, weight: "bold", fill: accent-orange)[70.66%]
      ],
    )

    #v(4pt)
    #text(size: 7.5pt, fill: gray-muted)[
      Weaknesses: entity shape, entity size, visual artifacts — poorly captured by all models
      #linebreak()
      Caption length does NOT strongly correlate with CapsBench score
    ]
  ]
)

#v(6pt)
#text(size: 7pt, fill: gray-muted)[
  Image types: film scenes, cartoon scenes, movie posters, invitations, ads, casual/street/landscape/interior photography
  #linebreak()
  Inspired by DSG (Davidsonian Scene Graph) and DPG-Bench. "Reversed" direction: caption evaluation instead of image evaluation.
]
