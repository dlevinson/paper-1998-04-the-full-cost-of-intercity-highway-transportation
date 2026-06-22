# The Full Cost of Intercity Highway Transportation

## Contribution

This paper develops a comprehensive full-cost model for intercity highway travel, distinguishing private and social, average and marginal, and short- and long-run costs. Its component estimates cover vehicles, infrastructure, travel time, congestion, noise, crashes, and pollution and reveal free-flow travel time as the largest cost category.

## Bibliographic Information

- Row ID: `paper-1998-04`
- Citation: Levinson, David M., and David Gillen. (1998). "The Full Cost of Intercity Highway Transportation." Transportation Research Part D: Transport and Environment 3(4):207-223. https://doi.org/10.1016/S1361-9209(97)00037-0
- Audit timestamp: 2026-05-17 06:30:32 AEST

## Package Status

This package has been rebuilt from the paper outward. The article estimates component-by-component full costs for intercity highway transportation: user costs, infrastructure costs, free-flow and congested time costs, accident costs, highway noise costs, and pollution costs. The package stages the highway-specific Full Cost Project C4 Highway and HIGHWAYS archive materials that correspond to those calculations.

The package is treated as `UPLOADED` because the staged materials are aggregate/model/statistical inputs, legacy scripts/control files, and derived workbooks; no human-subject microdata or confidential records were found in the selected payload. Repository-level provenance wording should still identify public/statistical sources such as FHWA Highway Statistics, BLS/Census wage and bond inputs, AAA operating-cost assumptions, NHTSA/FHWA crash-cost sources, and published environmental/noise studies.

Shared Full Cost social-cost report/model files are not duplicated here. Those files live under `_shared_sources/full-cost-intercity-transportation-1996/`; this package keeps only pointer documentation plus the paper-specific highway C4/HIGHWAYS materials.

The package/source boundary was rechecked on 2026-05-17. A checksum pass confirmed that 90 included files in `SOURCE_FILE_REVIEW.csv` byte-match their source-folder originals, with no failures. CSV sidecar inspection confirmed readable converted exports for the DataMaster workbook, depreciation model, HWY92 master and VMT tables, and Highway Statistics workbooks.

## Contents

- `paper/`: final/published paper PDF copied for reference.
- `data/highway_full_cost_model/original_legacy/`: selected original legacy highway model/data files from the Full Cost Project and HIGHWAYS archive.
- `data/highway_full_cost_model/modernized_xlsx/`: LibreOffice `.xlsx` conversions where legacy spreadsheets/Lotus worksheets could be opened.
- `data/highway_full_cost_model/csv_exports/`: CSV exports of nonempty sheets from the modernized workbooks.
- `code/legacy_statistical_controls/` and `code/legacy_awk_scripts/`: original statistical control and AWK script files.
- `documentation/full_cost_report/`: highway chapter/workpaper source documents from the Full Cost study.
- `documentation/legacy_text_extracts/`: text extracts from selected legacy Word documents for easier review.
- `data/DEDUP_POINTER_MANIFEST.csv`: social-cost/report files removed from this package because they are available through the shared Full Cost source.

## Exclusions

The source folders also contain letters, backup variants, email/search/correspondence folders, air/rail/HSR materials, and non-highway report chapters. Those are intentionally excluded from this paper package.

## Remaining Work

No further hard-drive search is expected for this paper. Before public upload, write concise provenance/license notes for the public/statistical source inputs. The shared Full Cost social-cost model/report boundary has already been deduplicated to `_shared_sources/full-cost-intercity-transportation-1996/`.

<!-- package-hardening-status:start -->
## Package Hardening Status

Generated: 2026-05-20 15:23:47 AEST

- Pipeline: `UPLOADED`
- Sidecars added/updated: `PACKAGE_STATUS.md`, `PACKAGE_MANIFEST.csv`, `LICENSE_STATUS.md`.
- Paper reference copies are for local audit convenience and are not public-upload assets without rights review.
- Final GitHub upload should use the manifest include statuses and the license-status note.
<!-- package-hardening-status:end -->
