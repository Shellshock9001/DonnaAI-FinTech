# Liquidity AI — Task 1.1: Core Entity Schema

---

## 1. Introduction

This repository documents the design and implementation of the Core Entity Schema for **Liquidity AI**, a CRM-style financial intelligence platform. The schema forms the data foundation for tracking investment firms, contacts, funds, and deals across the private markets ecosystem.

The schema is implemented in PostgreSQL across two migrations. Migration 001 establishes four core entity tables. Migration 002 introduces two taxonomy lookup tables and two junction tables that classify firms by investor type and industry vertical. All design decisions align with the Task 1.1 specification provided by the project team.

---

## 2. Schema Architecture Overview

The schema is organized into three categories of tables:

| Category | Tables | Description |
|---|---|---|
| Core entity tables (4) | `firms`, `contacts`, `funds`, `deals` | Each represents a primary business entity |
| Taxonomy tables (2) | `investor_categories`, `industry_verticals` | Controlled lookup lists used to classify firms |
| Junction tables (2) | `firm_investor_types`, `firm_industries` | Resolve many-to-many relationships between firms and taxonomy |

| Table | Type | Row Represents | Key Relationships |
|---|---|---|---|
| `firms` | Core | An investment firm or organization | Parent of contacts, funds, and deals |
| `contacts` | Core | An individual person at a firm | Belongs to one firm via `firm_id` |
| `funds` | Core | An investment vehicle | Managed by one firm; optionally linked to deals |
| `deals` | Core | A financial transaction | References a firm and optionally a fund |
| `investor_categories` | Taxonomy | An investor type label | Linked to firms via `firm_investor_types` |
| `industry_verticals` | Taxonomy | A sector or sub-sector | Hierarchical (self-referencing); linked to firms via `firm_industries` |
| `firm_investor_types` | Junction | Firm ↔ investor category | Connects firms ↔ investor_categories (M:M) |
| `firm_industries` | Junction | Firm ↔ industry vertical | Connects firms ↔ industry_verticals (M:M) |

Every core table includes a standard set of audit fields:

- **`created_at` / `updated_at`:** `TIMESTAMPTZ` columns that auto-populate to `NOW()`, providing a full audit trail of when each record was created or last modified.

---

## 3. Entity Relationship Diagram

![ERD Diagram](./migrations/New%20ERD%20Diagram.png)

> ERD created with [dbdiagram.io](https://dbdiagram.io)

**Core entity relationships:**

```
firms  ──────────────────< contacts         one firm has many contacts
firms  ──────────────────< funds            one firm has many funds
firms  ──────────────────< deals            one firm has many deals
funds  ──────────────────○ deals            one fund has zero or more deals
```

**Taxonomy relationships (via junction tables):**

```
firms  ──< firm_investor_types >── investor_categories
           (a firm can belong to multiple investor categories, e.g. "VC" + "Family Office")

firms  ──< firm_industries >── industry_verticals
           (a firm can focus on multiple industries, one marked as primary)
```

**Self-referencing hierarchy:**

```
industry_verticals
  └── parent_id → industry_verticals.id

  e.g.  Technology  (parent_id = NULL)
          └── AI/ML  (parent_id → Technology)
```

---

## 4. Core Entity Tables

### 4.1 `firms`

The `firms` table is the central hub of the schema. Every investment firm, family office, hedge fund, or institutional investor is stored here as a single row. Most other tables reference `firms` via foreign keys, making it the most connected entity in the data model.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | TEXT | PRIMARY KEY | Unique identifier for the firm. |
| `legal_name` | TEXT | NOT NULL | The firm's official registered name, e.g. `'Sequoia Capital Operations LLC'`. |
| `firm_name` | TEXT | NOT NULL | A shorter, human-friendly display name, e.g. `'Sequoia Capital'`. |
| `firm_type` | TEXT | DEFAULT `''` | Classifies the firm, e.g. `'venture_capital'`, `'private_equity'`, `'family_office'`. |
| `website` | TEXT | DEFAULT `''` | Official website URL. |
| `hq_city` | TEXT | DEFAULT `''` | City where the firm is headquartered. |
| `hq_state` | TEXT | DEFAULT `''` | State/province of the headquarters. |
| `hq_country` | TEXT | DEFAULT `''` | Country of the headquarters. Indexed for geography-based filtering. |
| `geography_focus` | JSONB | DEFAULT `'[]'` | JSON array of geographic regions the firm targets. JSONB enables GIN indexing for fast array queries. |
| `aum_range` | TEXT | DEFAULT `''` | Assets Under Management band, e.g. `'$1B–5B'`. Stored as a text band to handle estimated or redacted figures. |
| `check_size_min` | NUMERIC | NULLABLE | Minimum typical check size. NUMERIC ensures exact decimal precision for financial figures. |
| `check_size_max` | NUMERIC | NULLABLE | Maximum typical check size. |
| `stage_preferences` | JSONB | DEFAULT `'[]'` | JSON array of investment stages the firm targets, e.g. `["Seed", "Series A"]`. GIN-indexed. |
| `deal_type_preferences` | JSONB | DEFAULT `'[]'` | JSON array of preferred deal types, e.g. `["buyout", "growth_equity"]`. GIN-indexed. |
| `year_founded` | INTEGER | NULLABLE | Year the firm was founded. Nullable when this information is not publicly available. |
| `description` | TEXT | DEFAULT `''` | Free-text description or bio of the firm. |
| `logo_url` | TEXT | DEFAULT `''` | URL of the firm's logo for UI display. |
| `crm_status` | TEXT | NOT NULL, CHECK `('prospect','contacted','active','inactive')` | CRM pipeline state. CHECK constraint enforces valid values only. |
| `internal_score` | INTEGER | NOT NULL, CHECK `0–100` | Internal prioritization score. CHECK constraint enforces the valid range. |
| `source_links` | JSONB | DEFAULT `'[]'` | JSON array of source URLs for data provenance, e.g. PitchBook or SEC EDGAR links. |
| `notes` | TEXT | DEFAULT `''` | Free-text internal notes. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Timestamp of record creation. Timezone-aware for global data. |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Timestamp of last update. Should be refreshed on every UPDATE operation. |

**Indexes**

| Index Name | Type | Purpose |
|---|---|---|
| `idx_firms_crm_status` | B-Tree | Supports fast filtering of firms by pipeline stage. |
| `idx_firms_internal_score` | B-Tree | Supports sorting and filtering by prioritization score. |
| `idx_firms_hq_country` | B-Tree | Enables efficient filtering of firms by country. |
| `idx_firms_geography_focus` | GIN | Enables fast containment queries on the geography JSONB array. |
| `idx_firms_stage_preferences` | GIN | Enables fast containment queries on stage preferences. |
| `idx_firms_deal_type_preferences` | GIN | Enables fast containment queries on deal type preferences. |

---

### 4.2 `contacts`

The `contacts` table stores individual people associated with a firm — partners, analysts, executives, or any relevant individual. Each row represents one person and is linked to their firm via `firm_id`.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | TEXT | PRIMARY KEY | Unique identifier for the contact. |
| `firm_id` | TEXT | NOT NULL, FK → `firms`, ON DELETE CASCADE | References the firm this contact belongs to. CASCADE on delete removes the contact if the firm is deleted. |
| `first_name` | TEXT | NOT NULL | Contact's first name. |
| `last_name` | TEXT | NOT NULL | Contact's last name. |
| `title` | TEXT | DEFAULT `''` | Current job title, e.g. `'Managing Partner'`, `'CFO'`. |
| `email` | TEXT | DEFAULT `''` | Contact email address. |
| `phone` | TEXT | DEFAULT `''` | Contact phone number. |
| `linkedin_url` | TEXT | DEFAULT `''` | LinkedIn profile URL for data enrichment and manual verification. |
| `is_primary` | BOOLEAN | NOT NULL, DEFAULT `FALSE` | Flags whether this is the primary contact at the firm. |
| `department` | TEXT | DEFAULT `''` | Department or team the contact belongs to. |
| `notes` | TEXT | DEFAULT `''` | Free-text internal notes. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record creation timestamp. |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record last-updated timestamp. |

**Indexes**

| Index Name | Type | Purpose |
|---|---|---|
| `idx_contacts_firm_id` | B-Tree | Supports FK lookups and queries like 'show all contacts at firm X'. |
| `idx_contacts_email` | B-Tree | Supports fast lookup by email address. |
| `idx_contacts_is_primary` | B-Tree | Composite index on `(firm_id, is_primary)` for efficiently finding the primary contact at a firm. |

---

### 4.3 `funds`

The `funds` table stores individual investment vehicles. Each row represents one distinct fund (e.g. `'Andreessen Horowitz Fund IV'`). A fund is managed by one firm and can be optionally linked to deals.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | TEXT | PRIMARY KEY | Unique identifier for the fund. |
| `firm_id` | TEXT | NOT NULL, FK → `firms`, ON DELETE CASCADE | References the firm managing this fund. CASCADE on delete removes the fund if the firm is deleted. |
| `fund_name` | TEXT | NOT NULL | Full name of the fund. |
| `vintage_year` | INTEGER | NULLABLE | The year the fund held its first close. A standard industry metric used to compare fund performance across cohorts. |
| `fund_size` | NUMERIC | NULLABLE | Total committed capital. NUMERIC type provides exact decimal precision for financial figures. Nullable when fund size is not publicly disclosed. |
| `currency` | TEXT | NOT NULL, DEFAULT `'USD'` | Currency of the `fund_size` figure. Defaults to USD as the dominant currency in the target dataset. |
| `status` | TEXT | NOT NULL, CHECK `('active','closed','raising')` | Fund lifecycle state. CHECK constraint enforces valid values only. |
| `strategy` | TEXT | DEFAULT `''` | Free-text description of the fund's investment strategy. |
| `target_return` | NUMERIC | NULLABLE | Target return multiple or percentage. NUMERIC ensures exact precision. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record creation timestamp. |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record last-updated timestamp. |

**Indexes**

| Index Name | Type | Purpose |
|---|---|---|
| `idx_funds_firm_id` | B-Tree | Supports FK lookups and queries like 'show all funds managed by firm X'. |
| `idx_funds_status` | B-Tree | Supports filtering funds by lifecycle status. |
| `idx_funds_vintage_year` | B-Tree | Supports filtering and sorting funds by vintage cohort. |

---

### 4.4 `deals`

The `deals` table stores financial transactions — each row is one deal event such as a venture round, acquisition, or buyout. A deal references the firm involved and optionally the fund that deployed the capital.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | TEXT | PRIMARY KEY | Unique identifier for the deal. |
| `firm_id` | TEXT | NOT NULL, FK → `firms`, ON DELETE RESTRICT | References the firm associated with this deal. RESTRICT prevents a firm from being deleted while it still has deals. |
| `fund_id` | TEXT | FK → `funds`, ON DELETE SET NULL | References the fund that deployed capital in this deal. SET NULL preserves the deal record if the fund is removed. |
| `deal_name` | TEXT | NOT NULL | Name or label for the deal. |
| `target_company` | TEXT | DEFAULT `''` | Name of the company receiving investment. Stored as denormalized text to preserve historical accuracy. |
| `deal_type` | TEXT | DEFAULT `''` | Category of the transaction: `'venture'`, `'buyout'`, `'acquisition'`, `'ipo'`, etc. |
| `deal_size` | NUMERIC | NULLABLE | Deal amount. NUMERIC ensures exact precision. Nullable when the amount is undisclosed. |
| `deal_date` | DATE | NULLABLE | Date the deal was announced or closed. DATE type (not TIMESTAMP) since only the calendar date is typically known for deals. |
| `stage` | TEXT | DEFAULT `''` | Round stage label, e.g. `'Seed'`, `'Series A'`, `'Growth'`. |
| `sector` | TEXT | DEFAULT `''` | Primary industry sector of the target company. |
| `status` | TEXT | NOT NULL, CHECK `('announced','closed','rumored')` | Deal status. CHECK constraint enforces valid values only. |
| `source_url` | TEXT | DEFAULT `''` | URL of the source article or filing for this deal. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record creation timestamp. |
| `updated_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record last-updated timestamp. |

**Indexes**

| Index Name | Type | Purpose |
|---|---|---|
| `idx_deals_firm_id` | B-Tree | Supports queries like 'show all deals for firm X'. |
| `idx_deals_fund_id` | B-Tree | Supports queries like 'show all deals funded by fund Y'. |
| `idx_deals_status` | B-Tree | Supports filtering deals by status. |
| `idx_deals_sector` | B-Tree | Supports filtering deals by sector. |
| `idx_deals_date` | B-Tree | Supports date-range queries on deal activity. |

---

## 5. Taxonomy & Junction Tables

Taxonomy tables provide controlled lookup lists for classifying firms. Junction tables resolve the many-to-many relationships between firms and those taxonomies. Both junction table foreign keys use `ON DELETE CASCADE` so that junction rows are automatically removed when either parent record is deleted, preventing orphaned records.

### 5.1 `investor_categories`

A controlled lookup table of investor type labels. Rows are seeded at migration time and are not expected to change frequently.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing integer ID. |
| `name` | TEXT | NOT NULL, UNIQUE | Display name, e.g. `'Venture Capital'`, `'Family Offices'`. |
| `slug` | TEXT | NOT NULL, UNIQUE | URL-safe identifier, e.g. `'venture-capital'`. Safe to reference in application code without hardcoding display strings. |
| `description` | TEXT | DEFAULT `''` | Plain-English description of the investor category. |
| `display_order` | INTEGER | NOT NULL, DEFAULT `0` | Controls the order in which categories appear in UI dropdowns. |

**Seeded categories (13 total):** Investors, Family Offices, Hedge Funds, Investment Banks, Banks, Private Equity, Independent Sponsors, Venture Capital, Institutional Investors, Search Funds, Allocators, Private Investors, Angel Investors.

---

### 5.2 `industry_verticals`

A hierarchical lookup table of sectors and sub-sectors. A `parent_id` of `NULL` denotes a top-level sector; a set `parent_id` denotes a sub-sector beneath it. This self-referencing structure supports a two-level sector/sub-sector hierarchy.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `id` | SERIAL | PRIMARY KEY | Auto-incrementing integer ID. |
| `name` | TEXT | NOT NULL, UNIQUE | Display name, e.g. `'Technology'`, `'AI/ML'`. |
| `slug` | TEXT | NOT NULL, UNIQUE | URL-safe identifier, e.g. `'ai-ml'`. |
| `parent_id` | INTEGER | FK → `industry_verticals`, ON DELETE SET NULL | Self-referencing FK. NULL = top-level sector. Set = sub-sector of a parent. |
| `display_order` | INTEGER | NOT NULL, DEFAULT `0` | Controls the display order in UI components. |

**Seeded verticals (27 top-level sectors):** Technology, Software/SaaS, AI/ML, Healthcare, Biotech/Life Sciences, Fintech, Real Estate, Consumer, and more.

---

### 5.3 `firm_investor_types`

Resolves the many-to-many relationship between firms and investor categories. A firm can belong to multiple investor categories simultaneously (e.g. a firm classified as both `'Venture Capital'` and `'Family Office'`).

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `firm_id` | TEXT | PK component, FK → `firms`, CASCADE | References the firm. Cascades on delete. |
| `category_id` | INTEGER | PK component, FK → `investor_categories`, CASCADE | References the investor category. Cascades on delete. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record creation timestamp. |

**Composite PK:** `(firm_id, category_id)` — prevents a firm from being assigned the same investor category twice.

---

### 5.4 `firm_industries`

Resolves the many-to-many relationship between firms and industry verticals. A firm can focus on multiple industries, with one marked as primary via the `is_primary` flag.

| Field | Data Type | Constraints | Purpose / Notes |
|---|---|---|---|
| `firm_id` | TEXT | PK component, FK → `firms`, CASCADE | References the firm. Cascades on delete. |
| `industry_id` | INTEGER | PK component, FK → `industry_verticals`, CASCADE | References the industry vertical. Cascades on delete. |
| `is_primary` | BOOLEAN | NOT NULL, DEFAULT `FALSE` | Flags whether this is the firm's primary industry focus. |
| `created_at` | TIMESTAMPTZ | NOT NULL, DEFAULT `NOW()` | Record creation timestamp. |

**Composite PK:** `(firm_id, industry_id)` — enforces one entry per firm per industry vertical.

---

## 6. Key Design Decisions

### 6.1 TEXT Primary Keys
All core entity primary keys use `TEXT` type. This supports external ID ingestion from data providers (e.g. PitchBook, SEC EDGAR) and avoids auto-increment integer IDs, which can expose record counts and create merge conflicts in multi-source ingestion scenarios.

### 6.2 JSONB for Multi-Value Fields
Fields such as `geography_focus`, `stage_preferences`, `deal_type_preferences`, and `source_links` use the `JSONB` data type rather than plain `TEXT`. JSONB stores data in a parsed binary format that supports GIN indexing, enabling efficient containment queries (e.g. `stage_preferences @> '["Series A"]'`) without requiring separate junction tables for every preference dimension.

### 6.3 ON DELETE Behaviour — RESTRICT vs SET NULL vs CASCADE
Three deletion strategies are applied deliberately:
- **`ON DELETE CASCADE`** is used on `contacts.firm_id`, `funds.firm_id`, and all junction table FKs. Child records with no independent meaning are automatically cleaned up when their parent is deleted.
- **`ON DELETE SET NULL`** is used on `deals.fund_id`. A deal record is preserved even if its linked fund is removed — the deal retains its historical value without the fund reference.
- **`ON DELETE RESTRICT`** is used on `deals.firm_id`. A firm cannot be deleted while it still has associated deals, protecting data integrity and forcing explicit resolution before deletion.

### 6.4 Composite Primary Keys on Junction Tables
Junction tables use composite primary keys rather than surrogate integer IDs. This enforces uniqueness at the database level, eliminating an entire class of application-level bug where duplicate associations could otherwise be inserted.

### 6.5 CHECK Constraints for Controlled Fields
`crm_status`, `funds.status`, and `deals.status` are constrained to explicit allowed value sets via `CHECK` constraints. `internal_score` is bounded `0–100` by a `CHECK` constraint. This enforces valid state directly in the schema rather than relying solely on application-layer validation.

### 6.6 NUMERIC for Financial Figures
`check_size_min`, `check_size_max`, `fund_size`, `target_return`, and `deal_size` use PostgreSQL's `NUMERIC` type rather than `FLOAT` or `DOUBLE PRECISION`. `NUMERIC` stores exact decimal values with no floating-point rounding error — a critical property for financial data where precision errors can compound into significant discrepancies in aggregations and reports.

### 6.7 Hierarchical Taxonomy via Self-Referencing FK
`industry_verticals` uses a `parent_id` self-reference to model a two-level sector hierarchy without requiring a separate table. `parent_id IS NULL` denotes a top-level sector; a set `parent_id` denotes a sub-sector. `ON DELETE SET NULL` on this FK ensures sub-sectors are not deleted if their parent sector is removed — they simply become top-level entries.

---

## 7. Repository Structure

```
Liquidity-AI-Task-1.1/
└── migrations/
    ├── 001_create_schema.sql     # Core entity tables: firms, contacts, funds, deals
    ├── 002_taxonomy.sql          # Taxonomy + junction tables with seeded lookup data
    └── New ERD Diagram.png       # Entity relationship diagram
```

---

## 8. Conclusion

The Task 1.1 Core Entity Schema provides a normalized, extensible PostgreSQL foundation for the Liquidity AI platform. The eight-table design cleanly separates core entities from taxonomy and relationship data, applies appropriate deletion strategies to preserve data integrity, and uses JSONB with GIN indexing to support the multi-dimensional filtering that is central to the CRM use case.

All fields include sensible defaults, audit timestamps, and CHECK constraints to support the downstream data ingestion pipeline. The schema is ready for seed data loading and subsequent Phase 1 tasks.

---
