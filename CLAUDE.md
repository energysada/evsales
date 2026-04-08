# EV Sales Tracker (evsales.pages.dev)

## What this is

Monthly EV sales data tracker. Hard sales numbers only — no signals, no Google Trends, no app rankings. Latter stuff lives on `ev.energysada.com` (separate project) that tracks indicators for interest in EVs.

Using March 2026 as an example on how to do this monthly tracker.

## Key countries

US, China, Europe/ EU, Germany, UK, France, Norway, Netherlands, Sweden, Denmark, Spain, Italy, Canada, South Korea, Japan, Australia, India.

## Emerging markets (low priority)

Thailand, Brazil, Mexico, Vietnam, Philippines, Indonesia, New Zealand, Singapore, Ethiopia.

Not in particular order. But Southeast Asian and Latin American countries are low priority.

## Hard rule: only hard sales numbers

NO forecasts, NO estimates, NO projections. Only published actual sales/registration data from official industry bodies (KBA, SMMT, ANFAC, UNRAE, FCAI, KAIDA, FADA, CPCA, OFV, etc.) or their direct reporters. If a number says "expected", "estimated", "forecasted", or comes from a press release dated BEFORE the month ended — it doesn't count. The country stays Pending.

## What to track per country

-   **March data specifically** — not Feb, not Q1 proxies. If only Q1 or prior month exists, it goes in the Pending table with a note.
-   **Metric type**: EV means BEV + PHEV. Optionally can include FCEV, but very few sales in few countries. HEV or MHEV or HV are not in EV. Many sources mean only BEV by EV. So check for that and note it label correctly.
-   **YoY change** for current month specifically
-   **EV Market share** (% of total new car registrations): Common metric, report if available. But again check and label if, by EV, they mean BEV only share or BEV+PHEV share or BEV+PHEV+FCEV share. The latter two we can treat as EV shares.
-   **Two buckets of drivers influencing that month's sales:**
    -   **Short-term factors**: gas price spike (include magnitude, e.g. "+42.9% since Feb 28"), end-of-quarter delivery push, calendar effects (CNY timing), fiscal year-end rush
    -   **Structural changes**: new/removed subsidy (name it), VAT/tax discount changes, emission mandates changes (NVES, ZEV, NEV mandate), company car tax rules, registration tax exemptions changes

## Flag classification system

Each country gets one of four flags based on how its current month compares to its **own historical trajectory**, plus what's driving the move.

| Flag | Icon | Meaning |
|---|---|---|
| **Dark Green** | 🟢 ▲ | Above-trajectory growth, **clearly attributable to a fuel/energy crisis shock** — high confidence (e.g., country has high fuel exposure, large pump price rise, no other explanation) |
| **Light Green** | 🟢 ▲ | Above-trajectory growth, **likely fuel-shock-related but with confounders** — medium confidence (e.g., modest fuel price rise, no policy change, but other catalysts possible like brand price cuts) |
| **Yellow** | 🟡 ▲ | Growth in line with the existing trajectory, OR above-trajectory growth from a structural cause (new subsidy, fleet/tax policy, model launches) — not a fuel-shock spike |
| **Orange** | 🟠 ▼ | Drop in line with the existing trajectory — expected slowdown, decelerating from own trend, normalization. Not a new shock. |
| **Red** | 🔴 ▼ | Drop **beyond** trajectory — meaningfully worse than the trailing trend would predict. Signals a structural break or a one-month negative shock to investigate. |

### How to think about it

The trajectory is what we expected based on the trailing 3-6 months. Two questions:
1. **Is it above or below trajectory?** (above → green or yellow; below → orange or red)
2. **What's the cause?** Fuel shock vs structural vs trajectory continuation

### Decision tree

- **Growth ABOVE trajectory + clearly fuel/energy driven** (high fuel exposure, big pump price rise, no other explanation) → 🟢 **Dark Green**
- **Growth ABOVE trajectory + likely fuel-related but with confounders** (modest fuel rise, no policy change, but other plausible causes) → 🟢 **Light Green**
- **Growth ABOVE trajectory + driven by structural change** (new subsidy, tax reform, policy) → 🟡 **Yellow** (structural lift)
- **Growth IN LINE with trajectory** → 🟡 **Yellow** (continuation)
- **Drop IN LINE with trajectory** (continuing slowdown, decel from own pace) → 🟠 **Orange** (expected drop)
- **Drop BEYOND trajectory** (worse than expected, structural break, negative shock) → 🔴 **Red** (investigate)
- **Insufficient data, partial month, or saturated market** → no flag (trend context only)

### Important: green is RARE

Green is reserved for fuel-price-shock-driven monthly spikes only. If a country's growth surge is explained by a new subsidy, leasing reform, fleet tax change, model launches, or normal trajectory continuation, it's yellow — even if YoY is dramatic. The whole point of flagging is to surface what's driven by the energy environment vs what's just policy/momentum.

### Examples (March 2026)

- 🟢 **Dark Green Australia**: BEV +115% YoY, +20pp above trailing trend, fuel +43% — clear fuel-shock pop
- 🟢 **Light Green Sweden**: BEV +27% YoY vs +6% trailing (4-5x jump). No subsidy. Fuel only +7-8% (modest) — likely fuel-related but confounders possible (Tesla price cuts, etc.)
- 🟡 **France**: BEV +65% YoY but driven by leasing reform + company car tax change (structural, not fuel)
- 🟡 **Germany**: BEV +63% above trailing but mostly trajectory acceleration — not directly fuel-attributable
- 🟠 **US**: BEV ~−27% YoY but in line with the post-incentive ~−30% recent trajectory — expected drop
- 🟠 **China**: NEV −21% YoY in line with recent declining trajectory — calendar effect + sustained slowdown
- 🟠 **Spain**: BEV +41% YoY but trailing was +50%+ — decelerating from own trajectory
- 🔴 (none in March 2026): would require a worse-than-expected drop, e.g. a sudden shock

## Sources

Each country has its own official source (KBA, SMMT, CPCA, FADA, etc.). Multiple sources per country — list each as a separate row with date, linked name, and note. Add new sources as they publish.

## Data file

Save raw research to: `~/Library/CloudStorage/GoogleDrive-energysada@gmail.com/.shortcut-targets-by-id/1VsHTFQVv_fCHp83Cf4psemLKtzjGH2k3/Shared from work pc/fuel-prices-ev-interest/data/march-sales-watch-YYYY-MM-DD.md`

## Deploy

```         
cd ~/ev/evsales-site
/opt/homebrew/bin/wrangler pages deploy . --project-name evsales --commit-dirty=true
```

## Site structure

Single `index.html` with inline CSS/JS. Data is hardcoded in JS objects (STATUS, DETAIL, PENDING arrays). `news.json` is filtered to Market Data category only — sourced from `evinterest/data/news.json` but filtered.

## Style rules

-   No branding (no "energysada.com" in titles/headers/footers)
-   Deploy without asking every time
-   Brief language
