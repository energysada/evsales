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
