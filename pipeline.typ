#import "@preview/cetz:0.5.0"
#set page(width: auto, height: auto, margin: 10pt)

#cetz.canvas(length: 0.9cm, {
  import cetz.draw: *

  // ---- Colors ----
  let c-blue = rgb("#2b6cb0")
  let c-green = rgb("#38a169")
  let c-purple = rgb("#805ad5")
  let c-orange = rgb("#dd6b20")
  let c-red = rgb("#e53e3e")
  let c-muted = rgb("#718096")
  let c-dark = rgb("#1a202c")

  // ---- Styles ----
  let box1(center, w, h, fill: white, stroke: c-blue) = {
    rect((center.at(0) - w/2, center.at(1) - h/2),
         (center.at(0) + w/2, center.at(1) + h/2),
         fill: fill, stroke: 1.2pt + stroke)
  }
  let txt(at, body, size: 8pt, fill: c-dark, weight: "regular") = {
    content(at, text(size: size, fill: fill, weight: weight)[#body])
  }

  // ================================================================
  // TITLE
  // ================================================================
  txt((10, 0.8), [CapsBench Evaluation Pipeline], size: 16pt, weight: "bold")
  txt((10, 1.6), [200 images · 2,471 yes-no questions · 17 categories], size: 7.5pt, fill: c-muted)

  // ================================================================
  // PHASE 1: BENCHMARK CONSTRUCTION
  // ================================================================
  let y0 = 2.5

  // Phase 1 background
  rect((0.3, y0 - 0.2), (19.7, y0 + 5.0), fill: rgb("#ebf8ff"), stroke: 1pt + c-blue)
  txt((0.6, y0), [Phase 1: Benchmark Construction], size: 9pt, weight: "bold", fill: c-blue)

  // -- Row 1: Steps 1→2→3 --
  let rowY = y0 + 0.8

  // Step 1
  box1((3.0, rowY + 0.5), 5.0, 1.8)
  txt((3.0, rowY + 1.0), [① Image Collection], size: 8.5pt, weight: "bold", fill: c-blue)
  txt((3.0, rowY + 0.4), [200 images from 9 diverse types:], size: 6.5pt)
  txt((3.0, rowY + 0.1), [film, cartoon, poster, ad, photography...], size: 6pt, fill: c-muted)

  // Arrow 1→2
  line((5.6, rowY + 0.5), (7.4, rowY + 0.5), stroke: c-blue, mark: (end: ">"))

  // Step 2
  box1((9.8, rowY + 0.5), 4.4, 2.0, stroke: c-orange)
  txt((9.8, rowY + 1.0), [② QA Pair Generation], size: 8.5pt, weight: "bold")
  txt((9.8, rowY + 0.5), ["Based on the image" — Sec 4.2], size: 6.5pt, fill: c-orange)
  txt((9.8, rowY + 0.1), [~12 questions/image · 2,471 total], size: 6.5pt)
  txt((9.8, rowY - 0.3), [Yes/No format · most answers are "yes"], size: 6pt, fill: c-muted)

  // Arrow 2→3
  line((12.1, rowY + 0.5), (13.9, rowY + 0.5), stroke: c-blue, mark: (end: ">"))

  // Step 3
  box1((16.2, rowY + 0.5), 4.2, 1.5, stroke: c-purple)
  txt((16.2, rowY + 0.9), [③ Category Tagging], size: 8.5pt, weight: "bold", fill: c-purple)
  txt((16.2, rowY + 0.3), [17 categories per question], size: 6.5pt, fill: c-purple)

  // -- Row 2: Ambiguity --
  let ambY = y0 + 3.2
  txt((0.6, ambY + 0.6), [⚠️ Ambiguity in QA Generation], size: 7.5pt, weight: "bold", fill: c-red)

  box1((5.3, ambY), 9.8, 1.2, fill: rgb("#fff5f5"), stroke: c-red)
  txt((5.3, ambY + 0.35), [Reading A: VLM looks at image directly], size: 7pt, weight: "bold", fill: c-red)
  txt((5.3, ambY - 0.15), [Supported by: "Based on the image" (Sec 4.2)], size: 6pt, fill: c-red)

  box1((15.3, ambY), 8.8, 1.2, fill: rgb("#fffaf0"), stroke: c-orange)
  txt((15.3, ambY + 0.35), [Reading B: Caption → QA (like DPG-Bench Hard)], size: 7pt, weight: "bold", fill: c-orange)
  txt((15.3, ambY - 0.15), [Supported by: "parallels how we constructed CapsBench"], size: 6pt, fill: c-orange)

  // -- Row 3: 17 Category Tags --
  let catY = ambY - 1.0
  txt((0.6, catY + 0.3), [17 Categories:], size: 7pt, weight: "bold", fill: c-purple)

  let cats = (
    ("General", c-blue), ("Image Type", c-blue), ("Text", c-blue),
    ("Color", c-blue), ("Position", c-blue), ("Relation", c-blue),
    ("Rel. Position", c-blue),
    ("Entity", c-green), ("Entity Size", c-green), ("Entity Shape", c-green),
    ("Count", c-green), ("Emotion", c-green),
    ("Blur", c-red), ("Artifacts", c-red),
    ("Proper N.", c-orange), ("Color Pal.", c-purple), ("Color Grad.", c-purple),
  )

  let cx = 1.8
  for (name, color) in cats {
    rect((cx - 0.75, catY - 0.15), (cx + 0.75, catY + 0.15), fill: none, stroke: color)
    txt((cx, catY), name, size: 5.5pt, fill: color)
    cx += 1.6
    if cx > 18.5 { cx = 1.8; catY -= 0.35 }
  }

  // ================================================================
  // PHASE 2: CAPTION EVALUATION
  // ================================================================
  let y2 = catY - 1.5

  // Big arrow
  line((10.0, y2 + 1.5), (10.0, y2 + 0.8), stroke: c-blue, mark: (end: ">"))

  // Phase 2 background
  rect((0.3, y2 - 0.2), (19.7, y2 + 4.5), fill: rgb("#f0fff4"), stroke: 1pt + c-green)
  txt((0.6, y2), [Phase 2: Caption Evaluation], size: 9pt, weight: "bold", fill: c-green)

  // -- Eval Steps --
  let evY = y2 + 1.0

  // Step 4
  box1((2.5, evY + 0.3), 3.8, 1.4)
  txt((2.5, evY + 0.7), [Candidate Caption], size: 8pt, weight: "bold", fill: c-blue)
  txt((2.5, evY + 0.1), [from model under test], size: 6pt, fill: c-muted)

  line((4.5, evY + 0.3), (5.3, evY + 0.3), stroke: c-green, mark: (end: ">"))

  // Step 5
  box1((7.6, evY + 0.3), 5.4, 1.6, stroke: c-orange)
  txt((7.6, evY + 0.7), [④ LLM Answers Questions], size: 8pt, weight: "bold")
  txt((7.6, evY + 0.25), [Claude-3.5 Sonnet · Caption Only], size: 6.5pt, fill: c-orange)
  txt((7.6, evY - 0.15), [Output: Yes / No / N/A], size: 6pt, fill: c-muted)

  line((10.4, evY + 0.3), (11.2, evY + 0.3), stroke: c-green, mark: (end: ">"))

  // Step 6
  box1((13.0, evY + 0.3), 3.2, 1.4, stroke: c-purple)
  txt((13.0, evY + 0.7), [⑤ Consensus (3×)], size: 8pt, weight: "bold", fill: c-purple)
  txt((13.0, evY + 0.1), [Majority vote], size: 6pt, fill: c-muted)

  line((14.7, evY + 0.3), (15.5, evY + 0.3), stroke: c-green, mark: (end: ">"))

  // Step 7
  box1((17.5, evY + 0.3), 3.6, 1.4, stroke: c-green)
  txt((17.5, evY + 0.7), [⑥ Accuracy Score], size: 8pt, weight: "bold", fill: c-green)
  txt((17.5, evY + 0.1), [Per-category + combined], size: 6pt, fill: c-muted)

  // -- Results --
  let resY = evY - 1.2
  txt((0.6, resY + 0.6), [Results (Claude-3.5 Sonnet as judge):], size: 8pt, weight: "bold")

  box1((3.8, resY), 6.8, 1.0, fill: rgb("#c6f6d5"), stroke: c-green)
  txt((3.8, resY + 0.3), [PG Captioner], size: 7.5pt, weight: "bold", fill: c-green)
  txt((3.8, resY - 0.15), [72.19%], size: 10pt, weight: "bold", fill: c-green)

  box1((12.2, resY), 6.8, 1.0, fill: rgb("#e9d8fd"), stroke: c-purple)
  txt((12.2, resY + 0.3), [Claude-3.5 Sonnet], size: 7.5pt, weight: "bold", fill: c-purple)
  txt((12.2, resY - 0.15), [71.78%], size: 10pt, weight: "bold", fill: c-purple)

  box1((20.6, resY), 6.2, 1.0, fill: rgb("#feebc8"), stroke: c-orange)
  txt((20.6, resY + 0.3), [GPT-4o], size: 7.5pt, weight: "bold", fill: c-orange)
  txt((20.6, resY - 0.15), [70.66%], size: 10pt, weight: "bold", fill: c-orange)

  let noteY = resY - 0.9
  txt((0.6, noteY + 0.3), [Weak: entity shape, size, visual artifacts — poorly captured. Length ≠ score.], size: 6.5pt, fill: c-muted)

  // footnotes
  let footY = noteY - 0.7
  txt((0.6, footY), [Nine image types: film, cartoon, movie poster, invitation, advertisement, casual, street, landscape, interior photography. | Inspired by DSG + DPG-Bench.], size: 5.5pt, fill: c-muted)
})
