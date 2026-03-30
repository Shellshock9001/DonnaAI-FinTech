-- =============================================================
-- Migration 001: Core Entity Tables
-- =============================================================

-- =============================================================
-- TABLE: firms
-- =============================================================
CREATE TABLE IF NOT EXISTS firms (
    id TEXT PRIMARY KEY,           
    legal_name TEXT NOT NULL,
    firm_name TEXT NOT NULL,
    firm_type TEXT DEFAULT '',
    website TEXT DEFAULT '',
    hq_city TEXT DEFAULT '',
    hq_state TEXT DEFAULT '',
    hq_country TEXT DEFAULT '',
    geography_focus JSONB DEFAULT '[]',                              
    aum_range TEXT DEFAULT '',                              
    check_size_min NUMERIC,
    check_size_max NUMERIC,
    stage_preferences JSONB DEFAULT '[]',                              
    deal_type_preferences JSONB DEFAULT '[]',                              
    year_founded INTEGER,
    description TEXT DEFAULT '',
    logo_url TEXT DEFAULT '',
    crm_status TEXT NOT NULL DEFAULT 'prospect' CHECK (crm_status IN ('prospect','contacted','active','inactive')),
    internal_score INTEGER NOT NULL DEFAULT 0 CHECK (internal_score BETWEEN 0 AND 100),
    source_links JSONB DEFAULT '[]',                              
    notes TEXT DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE INDEX IF NOT EXISTS idx_firms_crm_status ON firms (crm_status);
CREATE INDEX IF NOT EXISTS idx_firms_internal_score ON firms (internal_score);
CREATE INDEX IF NOT EXISTS idx_firms_hq_country ON firms (hq_country);
CREATE INDEX IF NOT EXISTS idx_firms_geography_focus ON firms USING GIN (geography_focus);
CREATE INDEX IF NOT EXISTS idx_firms_stage_preferences ON firms USING GIN (stage_preferences);
CREATE INDEX IF NOT EXISTS idx_firms_deal_type_preferences ON firms USING GIN (deal_type_preferences);



-- =============================================================
-- TABLE: contacts
-- =============================================================
CREATE TABLE IF NOT EXISTS contacts (
    id TEXT PRIMARY KEY,                                 
    firm_id TEXT NOT NULL REFERENCES firms (id) ON DELETE CASCADE,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    title TEXT DEFAULT '',
    email TEXT DEFAULT '',
    phone TEXT DEFAULT '',
    linkedin_url TEXT DEFAULT '',
    is_primary BOOLEAN NOT NULL DEFAULT FALSE,                    
    department TEXT DEFAULT '',
    notes TEXT DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
 
CREATE INDEX IF NOT EXISTS idx_contacts_firm_id ON contacts (firm_id);
CREATE INDEX IF NOT EXISTS idx_contacts_email ON contacts (email);
CREATE INDEX IF NOT EXISTS idx_contacts_is_primary ON contacts (firm_id, is_primary);
 

-- =============================================================
-- TABLE: funds
-- =============================================================
CREATE TABLE IF NOT EXISTS funds (
    id TEXT PRIMARY KEY,                 
    firm_id TEXT NOT NULL REFERENCES firms (id) ON DELETE CASCADE,
    fund_name TEXT NOT NULL,
    vintage_year INTEGER,
    fund_size NUMERIC,
    currency TEXT NOT NULL DEFAULT 'USD',
    status TEXT NOT NULL DEFAULT 'active' CHECK (status IN ('active','closed','raising')),
    strategy TEXT DEFAULT '',
    target_return NUMERIC,                                
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
 
CREATE INDEX IF NOT EXISTS idx_funds_firm_id ON funds (firm_id);
CREATE INDEX IF NOT EXISTS idx_funds_status ON funds (status);
CREATE INDEX IF NOT EXISTS idx_funds_vintage_year ON funds (vintage_year);

 
-- =============================================================
-- TABLE: deals
-- =============================================================
CREATE TABLE IF NOT EXISTS deals (
    id TEXT PRIMARY KEY,                               
    firm_id TEXT NOT NULL REFERENCES firms (id) ON DELETE RESTRICT,
    fund_id TEXT REFERENCES funds (id) ON DELETE SET NULL, 
    deal_name TEXT NOT NULL,
    target_company TEXT DEFAULT '',
    deal_type TEXT DEFAULT '',                                
    deal_size NUMERIC,
    deal_date DATE,
    stage TEXT DEFAULT '',
    sector TEXT DEFAULT '',
    status TEXT NOT NULL DEFAULT 'announced' CHECK (status IN ('announced','closed','rumored')),
    source_url TEXT DEFAULT '',
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
 
CREATE INDEX IF NOT EXISTS idx_deals_firm_id ON deals (firm_id);
CREATE INDEX IF NOT EXISTS idx_deals_fund_id ON deals (fund_id);
CREATE INDEX IF NOT EXISTS idx_deals_status ON deals (status);
CREATE INDEX IF NOT EXISTS idx_deals_sector ON deals (sector);
CREATE INDEX IF NOT EXISTS idx_deals_date ON deals (deal_date);