-- =============================================================
-- Migration 002: Taxonomy Tables + Junction Tables
-- =============================================================

-- =============================================================
-- TABLE: investor_categories
-- =============================================================
CREATE TABLE IF NOT EXISTS investor_categories (
    id SERIAL  PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE,
    description TEXT DEFAULT '',
    display_order INTEGER NOT NULL DEFAULT 0
);

INSERT INTO investor_categories (name, slug, description, display_order) VALUES
    ('Investors',               'investors',               'General investment entities that do not fit a narrower category', 1),
    ('Family Offices',          'family-offices',          'Private wealth management firms serving ultra-high-net-worth families', 2),
    ('Hedge Funds',             'hedge-funds',             'Actively managed pooled investment vehicles using diverse strategies', 3),
    ('Investment Banks',        'investment-banks',        'Advisory and capital-markets firms; may co-invest on deals', 4),
    ('Banks',                   'banks',                   'Commercial and retail banks with direct lending or investment arms', 5),
    ('Private Equity',          'private-equity',          'Buyout, growth equity, and special-situations PE firms', 6),
    ('Independent Sponsors',    'independent-sponsors',    'Deal-by-deal sponsors who raise capital per transaction', 7),
    ('Venture Capital',         'venture-capital',         'Early-to-growth stage equity investors in high-growth startups', 8),
    ('Institutional Investors', 'institutional-investors', 'Pension funds, endowments, foundations, and sovereign wealth funds', 9),
    ('Search Funds',            'search-funds',            'Entrepreneur-led vehicles that acquire and operate a single business', 10),
    ('Allocators',              'allocators',              'Fund-of-funds and LP allocators that invest into other managers', 11),
    ('Private Investors',       'private-investors',       'High-net-worth individuals investing on a personal basis', 12),
    ('Angel Investors',         'angel-investors',         'Individual early-stage investors, typically pre-seed or seed', 13);


-- =============================================================
-- TABLE: industry_verticals
-- parent_id NULL  = top-level sector
-- parent_id SET   = sub-sector beneath a parent
-- =============================================================
CREATE TABLE IF NOT EXISTS industry_verticals (
    id SERIAL PRIMARY KEY,
    name TEXT NOT NULL UNIQUE,
    slug TEXT NOT NULL UNIQUE,
    parent_id INTEGER REFERENCES industry_verticals (id) ON DELETE SET NULL,
    display_order INTEGER NOT NULL DEFAULT 0
);

CREATE INDEX IF NOT EXISTS idx_industry_verticals_parent ON industry_verticals (parent_id);

-- ---- Top-level sectors ----
INSERT INTO industry_verticals (name, slug, parent_id, display_order) VALUES
    ('Technology',                'technology',              NULL,  1),
    ('Software/SaaS',             'software-saas',           NULL,  2),
    ('AI/ML',                     'ai-ml',                   NULL,  3),
    ('Healthcare',                'healthcare',              NULL,  4),
    ('Biotech/Life Sciences',     'biotech-life-sciences',   NULL,  5),
    ('Fintech',                   'fintech',                 NULL,  6),
    ('Real Estate',               'real-estate',             NULL,  7),
    ('Consumer',                  'consumer',                NULL,  8),
    ('Food & Beverage',           'food-beverage',           NULL,  9),
    ('Gaming',                    'gaming',                  NULL, 10),
    ('Media & Entertainment',     'media-entertainment',     NULL, 11),
    ('Industrials',               'industrials',             NULL, 12),
    ('Energy',                    'energy',                  NULL, 13),
    ('Infrastructure',            'infrastructure',          NULL, 14),
    ('Financial Services',        'financial-services',      NULL, 15),
    ('Transportation/Logistics',  'transportation-logistics',NULL, 16),
    ('Telecom',                   'telecom',                 NULL, 17),
    ('Hospitality',               'hospitality',             NULL, 18),
    ('Sports',                    'sports',                  NULL, 19),
    ('Education',                 'education',               NULL, 20),
    ('Agriculture',               'agriculture',             NULL, 21),
    ('Manufacturing',             'manufacturing',           NULL, 22),
    ('Cannabis',                  'cannabis',                NULL, 23),
    ('Crypto/Blockchain',         'crypto-blockchain',       NULL, 24),
    ('Defense/Government',        'defense-government',      NULL, 25),
    ('Retail/E-commerce',         'retail-ecommerce',        NULL, 26),
    ('Cleantech/Climate',         'cleantech-climate',       NULL, 27);


-- =============================================================
-- JUNCTION TABLE: firm_investor_types
-- Many-to-many: firms <-> investor_categories
-- =============================================================
CREATE TABLE IF NOT EXISTS firm_investor_types (
    firm_id TEXT NOT NULL REFERENCES firms (id) ON DELETE CASCADE,
    category_id INTEGER NOT NULL REFERENCES investor_categories (id) ON DELETE CASCADE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (firm_id, category_id)
);

CREATE INDEX IF NOT EXISTS idx_firm_investor_types_category ON firm_investor_types (category_id);


-- =============================================================
-- JUNCTION TABLE: firm_industries
-- Many-to-many: firms <-> industry_verticals
-- =============================================================
CREATE TABLE IF NOT EXISTS firm_industries (
    firm_id TEXT NOT NULL REFERENCES firms (id) ON DELETE CASCADE,
    industry_id INTEGER NOT NULL REFERENCES industry_verticals (id) ON DELETE CASCADE,
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,                       
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    PRIMARY KEY (firm_id, industry_id)
);

CREATE INDEX IF NOT EXISTS idx_firm_industries_industry ON firm_industries (industry_id);
CREATE INDEX IF NOT EXISTS idx_firm_industries_primary  ON firm_industries (firm_id, is_primary);