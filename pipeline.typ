#import "@preview/cetz:0.5.0"
#set page(width: auto, height: auto, margin: 8pt)

#cetz.canvas(length: 1cm, {
  import cetz.draw: *

  // ---- Colors ----
  let c-blue = rgb("#2b6cb0")
  let c-green = rgb("#38a169")
  let c-purple = rgb("#805ad5")
  let c-orange = rgb("#dd6b20")
  let c-red = rgb("#e53e3e")
  let c-muted = rgb("#718096")
  let c-dark = rgb("#1a202c")

  // ---- Title ----
  content((8, -0.3), [
    #text(size: 16pt, weight: "bold")[CapsBench Evaluation Pipeline]
  ])
  content((8, -1.0), text(size: 8pt, fill: c-muted)[200 images · 2,471 yes-no questions · 17 categories])

  // ===================================================
  // PHASE 1 BACKGROUND
  // ===================================================
  rect((0.5, -1.7), (15.5, -8.5), fill: rgb("#ebf8ff"), stroke: 1pt + c-blue)
  content((0.8, -2.0), text(size: 10pt, weight: "bold", fill: c-blue)[Phase 1: Benchmark Construction])

  // Step 1: Image Curation
  rect((1.0, -2.8), (3.5, -4.2), fill: white, stroke: c-blue)
  content((2.75, -3.15), text(size: 10pt, weight: "bold", fill: c-blue)[① Image Collection])
  content((2.75, -3.55), text(size: 8pt)[200 images · 9 diverse types])

  // Arrow 1→2
  line((4.5, -3.5), (5.3, -3.5), stroke: c-blue, mark: (end: "stealth"))

  // Step 2: QA Generation
  rect((5.3, -2.8), (9.0, -4.5), fill: white, stroke: c-orange)
  content((7.15, -3.1), text(size: 10pt, weight: "bold")[② QA Pair Generation])
  content((7.15, -3.5), text(size: 7.5pt, fill: c-orange)["Based on the image" (Sec 4.2)])
  content((7.15, -3.9), text(size: 7.5pt)[~12 questions/image · 2,471 total])
  content((7.15, -4.2), text(size: 7pt, fill: c-muted)[Yes/No questions, majority are "yes"])

  // Arrow 2→3
  line((9.0, -3.5), (10.0, -3.5), stroke: c-blue, mark: (end: "stealth"))

  // Step 3: Categories
  rect((10.0, -2.8), (13.5, -4.2), fill: white, stroke: c-purple)
  content((11.75, -3.15), text(size: 10pt, weight: "bold", fill: c-purple)[③ 17-Category Tagging])
  content((11.75, -3.55), text(size: 8pt, fill: c-purple)[per question])
  content((11.75, -3.9), text(size: 7pt, fill: c-muted)[General · Color · Entity · ...])

  // ---- Ambiguity box ----
  content((1.0, -4.9), text(size: 9pt, weight: "bold", fill: c-red)[⚠️ Ambiguity in QA Generation])

  rect((1.0, -5.3), (6.5, -6.3), fill: rgb("#fff5f5"), stroke: c-red)
  content((4.25, -5.55), text(size: 8.5pt, weight: "bold", fill: c-red)[Reading A: VLM looks at image directly])
  content((4.25, -5.9), text(size: 7pt, fill: c-red)[Supported by: "Based on the image" (Sec 4.2)])

  rect((8.0, -5.3), (14.0, -6.3), fill: rgb("#fffaf0"), stroke: c-orange)
  content((11.0, -5.55), text(size: 8.5pt, weight: "bold", fill: c-orange)[Reading B: Caption → QA (like DPG-Hard)])
  content((11.0, -5.9), text(size: 7pt, fill: c-orange)[Supported by: "parallels how we constructed CapsBench"])

  // ---- Category tags ----
  content((0.8, -6.7), text(size: 8pt, weight: "bold", fill: c-purple)[17 Evaluation Categories])

  let cats = (
    ("General", "#bee3f8", c-blue), ("Image Type", "#bee3f8", c-blue), ("Text", "#bee3f8", c-blue),
    ("Color", "#bee3f8", c-blue), ("Position", "#bee3f8", c-blue), ("Relation", "#bee3f8", c-blue),
    ("Rel. Pos.", "#bee3f8", c-blue),
    ("Entity", "#c6f6d5", c-green), ("Entity Size", "#c6f6d5", c-green), ("Entity Shape", "#c6f6d5", c-green),
    ("Count", "#c6f6d5", c-green), ("Emotion", "#c6f6d5", c-green),
    ("Blur", "#fed7d7", c-red), ("Img Artifacts", "#fed7d7", c-red),
    ("Proper Noun", "#feebc8", c-orange), ("Color Palette", "#e9d8fd", c-purple), ("Color Grading", "#e9d8fd", c-purple),
  )

  let (cx, cy) = (1.0, -7.1)
  for (name, bg, fg) in cats {
    if cx > 14.0 { cx = 1.0; cy -= 0.45 }
    rect((cx, cy), (cx + 1.5, cy - 0.35), fill: rgb(bg), stroke: fg)
    content((cx + 0.75, cy - 0.175), text(size: 6.5pt, fill: fg, name))
    cx += 1.7
  }

  // ---- Big arrow to Phase 2 ----
  line((8.0, -8.5), (8.0, -9.2), stroke: c-blue, mark: (end: "stealth"))

  // ===================================================
  // PHASE 2 BACKGROUND
  // ===================================================
  rect((0.5, -9.2), (15.5, -16.0), fill: rgb("#f0fff4"), stroke: 1pt + c-green)
  content((0.8, -9.5), text(size: 10pt, weight: "bold", fill: c-green)[Phase 2: Caption Evaluation])

  // Step 4: Input
  rect((1.0, -10.2), (3.0, -11.4), fill: white, stroke: c-blue)
  content((2.0, -10.5), text(size: 10pt, weight: "bold", fill: c-blue)[Candidate])
  content((2.0, -10.8), text(size: 10pt, weight: "bold", fill: c-blue)[Caption])
  content((2.0, -11.15), text(size: 7pt, fill: c-muted)[from model under test])

  line((3.0, -10.8), (4.0, -10.8), stroke: c-green, mark: (end: "stealth"))

  // Step 5: LLM QA
  rect((4.0, -10.0), (7.5, -11.6), fill: white, stroke: c-orange)
  content((5.75, -10.3), text(size: 10pt, weight: "bold")[④ LLM Answers Questions])
  content((5.75, -10.7), text(size: 8pt, fill: c-orange)[Claude-3.5 Sonnet])
  content((5.75, -11.0), text(size: 7.5pt)[Caption only · No image access])
  content((5.75, -11.35), text(size: 7.5pt)[Output: Yes / No / N/A])

  line((7.5, -10.8), (8.5, -10.8), stroke: c-green, mark: (end: "stealth"))

  // Step 6: Consensus
  rect((8.5, -10.2), (10.5, -11.4), fill: white, stroke: c-purple)
  content((9.5, -10.5), text(size: 10pt, weight: "bold", fill: c-purple)[⑤ Consensus])
  content((9.5, -10.9), text(size: 10pt, weight: "bold", fill: c-purple)[(3×)])
  content((9.5, -11.2), text(size: 7.5pt, fill: c-muted)[Majority vote per question])

  line((10.5, -10.8), (11.5, -10.8), stroke: c-green, mark: (end: "stealth"))

  // Step 7: Score
  rect((11.5, -10.2), (13.5, -11.4), fill: white, stroke: c-green)
  content((12.5, -10.5), text(size: 10pt, weight: "bold", fill: c-green)[⑥ Accuracy])
  content((12.5, -10.9), text(size: 10pt, weight: "bold", fill: c-green)[Score])
  content((12.5, -11.2), text(size: 7.5pt, fill: c-muted)[per-category])

  // ---- Results ----
  content((1.0, -12.2), text(size: 9pt, weight: "bold")[Results (Sec 7, Claude-3.5 Sonnet as judge):])

  rect((1.0, -12.7), (4.5, -13.4), fill: rgb("#c6f6d5"), stroke: c-green)
  content((2.75, -12.95), text(size: 9pt, weight: "bold", fill: c-green)[PG Captioner])
  content((2.75, -13.2), text(size: 11pt, weight: "bold", fill: c-green)[72.19%])

  rect((5.5, -12.7), (9.5, -13.4), fill: rgb("#e9d8fd"), stroke: c-purple)
  content((7.5, -12.95), text(size: 9pt, weight: "bold", fill: c-purple)[Claude-3.5 Sonnet])
  content((7.5, -13.2), text(size: 11pt, weight: "bold", fill: c-purple)[71.78%])

  rect((10.5, -12.7), (14.0, -13.4), fill: rgb("#feebc8"), stroke: c-orange)
  content((12.25, -12.95), text(size: 9pt, weight: "bold", fill: c-orange)[GPT-4o])
  content((12.25, -13.2), text(size: 11pt, weight: "bold", fill: c-orange)[70.66%])

  content((1.0, -14.0), text(size: 7.5pt, fill: c-muted)[Weaknesses: entity shape, entity size, visual artifacts — poorly captured by all models])
  content((1.0, -14.4), text(size: 7.5pt, fill: c-muted)[Caption length does NOT strongly correlate with CapsBench score])

  // ---- Footnotes ----
  content((1.0, -15.2), text(size: 6.5pt, fill: c-muted)[\* Image types: film scenes, cartoon scenes, movie posters, invitations, ads, casual/street/landscape/interior photography])
  content((1.0, -15.6), text(size: 6.5pt, fill: c-muted)[Inspired by DSG and DPG-Bench. "Reversed" direction: caption evaluation instead of image evaluation.])
})
