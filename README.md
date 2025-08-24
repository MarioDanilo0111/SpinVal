# SpinVal (Vinyl Analyzer MVP)

**One‑liner:** “Vinyl analyzer MVP – scan inner label → extract text → show result.”

## Sprint Goal (Sprint 1)

Enable user to run a blank SwiftUI app on iOS 17 simulator as a clean baseline for future work.  
Next sprint will add camera capture → OCR → display.

## Roadmap (short)

- **Phase 1 – MVP:** Camera capture, OCR/barcode, parse catalog no., Discogs/MusicBrainz lookups, price band.
- **Phase 2 – Collection:** Save scans locally, “My Collection”, export/share.
- **Phase 3 – Condition:** Scratch/sleeve detection, confidence scoring.
- **Phase 4 – Biz:** Freemium, premium valuation PDF, links to Discogs/eBay.

## Tech

- **iOS 17**, SwiftUI, AVFoundation, Vision.
- Storage: Core Data (planned).
- Providers: Discogs, MusicBrainz, eBay (planned).

## Run

Open in Xcode 15+, select iPhone simulator, **Run**.
