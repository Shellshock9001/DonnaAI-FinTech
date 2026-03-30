-- =============================================================================
-- seed_sample_data.sql — Liquidity AI Task 1.1 (PostgreSQL)
-- Firms are capital providers only (no portfolio-company rows in `firms`).
-- SEC links in source_links / deal source_url use EDGAR company pages (CIK) where mapped.
-- Regenerated from legacy: scripts/port_legacy_seed.py — then run scripts/patch_seed_capital_providers.py
-- Prerequisites: migrations/new_001_core_entities.sql then new_002_taxonomy_tables.sql
-- =============================================================================

BEGIN;

-- Firms
INSERT INTO firms (
  id, legal_name, firm_name, firm_type, website,
  hq_city, hq_state, hq_country, geography_focus, aum_range,
  check_size_min, check_size_max, stage_preferences, deal_type_preferences, year_founded,
  description, logo_url, crm_status, internal_score, source_links, notes
) VALUES
  ('a1b2c3d4-0001-0001-0001-000000000001', 'Sequoia Capital Operations LLC', 'Sequoia Capital', 'investor', 'https://www.sequoiacap.com', 'Menlo Park', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', 300000000.0, 6869866984.0, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1972, 'Global venture capital firm founded in 1972 by Don Valentine. Early backer of Apple, Atari, Google, YouTube, Instagram, WhatsApp, Airbnb, and Stripe. Manages a suite of venture, growth, and crossover funds.', '', 'active', 95, '["https://www.sequoiacap.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001415312&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/sequoia-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0002-0002-0002-000000000002', 'Andreessen Horowitz LLC', 'Andreessen Horowitz', 'investor', 'https://a16z.com', 'Menlo Park', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', 25000000.0, 8589661278.0, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2009, 'Venture capital firm (a16z) founded in 2009 by Marc Andreessen and Ben Horowitz. Over $90B under management across funds dedicated to venture, growth, bio, and crypto. Pioneered the platform model in VC.', '', 'active', 95, '["https://a16z.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001639920&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/andreessen-horowitz"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0003-0003-0003-000000000003', 'Blackstone Inc.', 'Blackstone', 'investor', 'https://www.blackstone.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1985, 'World''s largest alternative investment firm with $1.2 trillion AUM (as of Q3 2025). Founded in 1985 by Stephen Schwarzman. Strategies include private equity, real estate, credit, hedge fund solutions, and infrastructure.', '', 'active', 95, '["https://www.blackstone.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001393818&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/blackstone"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0004-0004-0004-000000000004', 'KKR & Co. Inc.', 'KKR', 'investor', 'https://www.kkr.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', 5300000000.0, 5300000000.0, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1976, 'Global alternative asset manager founded in 1976 by Henry Kravis and George Roberts. Pioneer of the leveraged buyout. Invests across private equity, credit, real estate, and infrastructure globally.', '', 'active', 95, '["https://www.kkr.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001404912&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/kkr"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0005-0005-0005-000000000005', 'Tiger Global Management LLC', 'Tiger Global', 'investor', 'https://www.tigerglobal.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', 3400000000.0, 3400000000.0, '["growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2001, 'Investment firm founded in 2001 with $25M seed from Julian Robertson (Tiger Management). Runs both a hedge fund and a private investment vehicle. Among the most prolific venture investors globally in tech and fintech.', '', 'active', 90, '["https://www.tigerglobal.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001167483&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/tiger-global-management"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0006-0006-0006-000000000006', 'Citadel LLC', 'Citadel', 'investor', 'https://www.citadel.com', 'Miami', 'FL', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["growth"]'::jsonb, '["equity", "debt", "credit"]'::jsonb, 1990, 'Global alternative investment firm founded in 1990 by Ken Griffin. Over 2,500 professionals. Runs multi-strategy hedge funds and Citadel Securities, a leading market maker. Global HQ established in Miami in 2022.', '', 'active', 95, '["https://www.citadel.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001423053&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/citadel-llc"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0007-0007-0007-000000000007', 'Bridgewater Associates LP', 'Bridgewater Associates', 'investor', 'https://www.bridgewater.com', 'Westport', 'CT', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["growth"]'::jsonb, '["equity", "debt", "credit"]'::jsonb, 1975, 'World''s largest hedge fund by AUM, founded in 1975 by Ray Dalio. Known for Pure Alpha and All Weather macro strategies. Manages assets for sovereign wealth funds, pension funds, central banks, and endowments.', '', 'active', 95, '["https://www.bridgewater.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001350694&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/bridgewater-associates"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0016-0016-0016-000000000016', 'Franklin Resources Inc.', 'Franklin Templeton', 'investor', 'https://www.franklintempleton.com', 'San Mateo', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', 200000000.0, 1000000000.0, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1947, 'Global investment management organization with over $1.5T AUM. Has been an active crossover investor in late-stage private technology rounds including Databricks and Canva.', '', 'active', 90, '["https://www.franklintempleton.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000038777&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/franklin-templeton"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0017-0017-0017-000000000017', 'SoftBank Group Corp.', 'SoftBank', 'investor', 'https://www.softbank.jp', 'Tokyo', '', 'Japan', '["Japan"]'::jsonb, '$10B+', 639000000.0, 639000000.0, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1981, 'Japanese multinational conglomerate and one of the world''s largest technology investors. Operates the SoftBank Vision Fund (SVF1 $100B, SVF2). Invested in Uber, WeWork, Alibaba, Klarna, DoorDash, and hundreds of others.', '', 'active', 90, '["https://www.softbank.jp", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001082504&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/softbank"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0018-0018-0018-000000000018', 'Berkshire Hathaway Inc.', 'Berkshire Hathaway', 'investor', 'https://www.berkshirehathaway.com', 'Omaha', 'NE', 'USA', '["USA"]'::jsonb, '$10B+', 750000000.0, 750000000.0, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1955, 'Holding company run by Warren Buffett and Charlie Munger (until 2023). Primarily known for value investing and insurance. Took a notable stake in Nubank at $30B valuation via Series G extension.', '', 'active', 95, '["https://www.berkshirehathaway.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001067983&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/berkshire-hathaway"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0020-0020-0020-000000000020', 'Apollo Global Management Inc.', 'Apollo', 'investor', 'https://www.apollo.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1990, 'Global alternative asset manager with $696B AUM (2024 annual report). Founded in 1990 by Leon Black, Josh Harris, and Marc Rowan. Strategies span private equity, credit, and real estate. NYSE: APO, CIK 0001411579.', '', 'active', 95, '["https://www.apollo.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001411579&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/apollo-global-management"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0021-0021-0021-000000000021', 'The Carlyle Group Inc.', 'Carlyle', 'investor', 'https://www.carlyle.com', 'Washington', 'DC', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1987, 'Global alternative asset manager with $426B AUM (2024 10-K). Founded in 1987 by David Rubenstein, William Conway Jr., and Daniel D''Aniello. Strategies include PE, credit, infrastructure, and real estate. NASDAQ: CG, CIK 0001403161.', '', 'active', 95, '["https://www.carlyle.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001403161&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/the-carlyle-group"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0022-0022-0022-000000000022', 'TPG Inc.', 'TPG', 'investor', 'https://www.tpg.com', 'Fort Worth', 'TX', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1992, 'Global alternative asset management firm with $224B AUM (2024 annual report). Co-founded in 1992 by David Bonderman and James Coulter. Strategies include private equity, growth, impact (Rise), and real estate. NASDAQ: TPG, CIK 0001836935.', '', 'active', 95, '["https://www.tpg.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001836935&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/tpg-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0023-0023-0023-000000000023', 'Warburg Pincus LLC', 'Warburg Pincus', 'investor', 'https://www.warburgpincus.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1966, 'Global private equity and growth equity firm with approximately $83B AUM. Founded in 1966. Has invested in over 1,000 companies across more than 40 countries. Known for growth equity investing globally.', '', 'active', 90, '["https://www.warburgpincus.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001006438&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/warburg-pincus"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0024-0024-0024-000000000024', 'Advent International Corporation', 'Advent International', 'investor', 'https://www.adventinternational.com', 'Boston', 'MA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 1984, 'International private equity firm with approximately $93B AUM. Founded in 1984. Operates across North America, Europe, Latin America, and Asia-Pacific. Known for deep sector expertise and international PE investing.', '', 'active', 90, '["https://www.adventinternational.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000927720&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/advent-international"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0025-0025-0025-000000000025', 'Bain Capital LLC', 'Bain Capital', 'investor', 'https://www.baincapital.com', 'Boston', 'MA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "debt", "mezz"]'::jsonb, 1984, 'Global alternative investment firm with approximately $185B AUM. Founded in 1984, spun out of Bain & Company. Strategies span private equity, venture capital, credit, and public equity. Backed companies including Staples, Dunkin'', and Hospital Corporation of America.', '', 'active', 90, '["https://www.baincapital.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001302839&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/bain-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0026-0026-0026-000000000026', 'Benchmark Capital Management Co. LLC', 'Benchmark', 'investor', 'https://www.benchmark.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1995, 'Early-stage venture capital firm founded in 1995. Backed Uber, Twitter, Snapchat, Instagram, eBay, Yelp, WeWork, and Dropbox. Operates with a small equal-partnership model with no hierarchy among partners.', '', 'active', 90, '["https://www.benchmark.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000885725&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/benchmark-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0027-0027-0027-000000000027', 'General Catalyst Group Management LLC', 'General Catalyst', 'investor', 'https://www.generalcatalyst.com', 'Cambridge', 'MA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2000, 'Venture capital firm with approximately $25B AUM. Founded in 2000 in Cambridge, MA. Investments span early to growth stages. Portfolio includes Airbnb, Stripe, Snap, HubSpot, Warby Parker, and Figma. Expanding into responsible innovation and global health.', '', 'active', 90, '["https://www.generalcatalyst.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001773757&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/general-catalyst-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0028-0028-0028-000000000028', 'Founders Fund LLC', 'Founders Fund', 'investor', 'https://www.foundersfund.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2005, 'Venture capital firm founded in 2005 by Peter Thiel, Ken Howery, and Luke Nosek. Early backer of SpaceX, Facebook, Airbnb, Lyft, and Palantir. Known for contrarian, science-driven investment thesis.', '', 'active', 90, '["https://www.foundersfund.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001422149&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/founders-fund"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0029-0029-0029-000000000029', 'Accel Partners Management LLC', 'Accel', 'investor', 'https://www.accel.com', 'Palo Alto', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1983, 'Global venture capital and growth equity firm founded in 1983. Early investor in Facebook, Spotify, Slack, Dropbox, Atlassian, and Crowdstrike. Operates across the US, Europe, and India.', '', 'active', 90, '["https://www.accel.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000885869&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/accel-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0030-0030-0030-000000000030', 'Point72 Asset Management LP', 'Point72', 'investor', 'https://www.point72.com', 'Stamford', 'CT', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["growth"]'::jsonb, '["equity", "debt", "credit"]'::jsonb, 2014, 'Multi-strategy hedge fund with approximately $35B AUM. Founded in 2014 by Steve Cohen, successor to SAC Capital Advisors. Strategies include discretionary long/short equity, macro, systematic, and venture. HQ in Stamford, CT.', '', 'active', 90, '["https://www.point72.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001649339&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/point72-asset-management"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0031-0031-0031-000000000031', 'D.E. Shaw & Co LP', 'D.E. Shaw', 'investor', 'https://www.deshaw.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["growth"]'::jsonb, '["equity", "debt", "credit"]'::jsonb, 1988, 'Quantitative and multi-strategy investment firm with approximately $60B AUM. Founded in 1988 by David Shaw. Known for systematic and computational approaches to investing. Operates across hedge fund, private equity, and technology businesses.', '', 'active', 90, '["https://www.deshaw.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001009207&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/d-e-shaw-group"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0032-0032-0032-000000000032', 'Two Sigma Investments LP', 'Two Sigma', 'investor', 'https://www.twosigma.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["growth"]'::jsonb, '["equity", "debt", "credit"]'::jsonb, 2001, 'Quantitative and systematic investment firm with approximately $60B AUM. Founded in 2001 by John Overdeck and David Siegel. Uses data science, distributed computing, and machine learning across all investment strategies.', '', 'active', 90, '["https://www.twosigma.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001550766&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/two-sigma"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0033-0033-0033-000000000033', 'Gates Frontier LLC', 'Gates Frontier', 'investor', 'https://www.gatesfrontier.com', 'Kirkland', 'WA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, NULL, 'Family investment office for Bill Gates. Registered investment adviser (SEC Form ADV). Manages a diversified portfolio across technology, healthcare, energy, and global development. Sister entity to Cascade Investment LLC.', '', 'active', 85, '["https://www.gatesfrontier.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001759760&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/gates-frontier"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0034-0034-0034-000000000034', 'Walton Enterprises LLC', 'Walton Enterprises', 'investor', 'https://www.waltonenterprises.com', 'Bentonville', 'AR', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, NULL, 'Family investment office for the Walton family (founders of Walmart). Registered investment adviser (SEC Form ADV). Manages one of the largest family fortunes in the world, estimated at over $200B.', '', 'active', 85, '["https://www.waltonenterprises.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001048353&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/walton-enterprises"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0035-0035-0035-000000000035', 'Cascade Investment LLC', 'Cascade Investment', 'investor', 'https://www.cascadeinvestment.com', 'Kirkland', 'WA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1994, 'Personal investment vehicle for Bill Gates, founded in 1994. Registered investment adviser (SEC Form ADV). Managed by CIO Michael Larson. Holds stakes in Canadian National Railway, AutoNation, and large US farmland holdings.', '', 'active', 90, '["https://www.cascadeinvestment.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001166559&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/cascade-investment"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0036-0036-0036-000000000036', 'Pritzker Private Capital LLC', 'Pritzker Private Capital', 'investor', 'https://www.pritzker.com', 'Chicago', 'IL', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, NULL, 'Pritzker family private equity and family office platform headquartered in Chicago, IL. Focuses on middle market companies in manufacturing, services, and healthcare. Affiliated with the Pritzker family (Hyatt Hotels founders).', '', 'active', 85, '["https://www.pritzker.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001798920&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/pritzker-private-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0037-0037-0037-000000000037', 'Rockefeller Capital Management LP', 'Rockefeller Capital Management', 'investor', 'https://www.rockco.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 2018, 'Independent wealth and asset management firm with approximately $130B AUM. Founded in 2018 from the former Rockefeller & Co. Serves ultra-high-net-worth families, institutions, and the Rockefeller family legacy.', '', 'active', 90, '["https://www.rockco.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001743755&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/rockefeller-capital-management"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0038-0038-0038-000000000038', 'JPMorgan Chase & Co.', 'JPMorgan Chase', 'investor', 'https://www.jpmorganchase.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', 2340000000.0, 2340000000.0, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1799, 'Global financial services firm with $4T+ in total assets. NYSE: JPM, CIK 0000019617. Predecessor institutions date to 1799. Largest US bank by assets. Operates investment banking, consumer banking, asset management, and commercial banking.', '', 'active', 95, '["https://www.jpmorganchase.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000019617&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/jpmorgan-chase"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0039-0039-0039-000000000039', 'The Goldman Sachs Group Inc.', 'Goldman Sachs', 'investor', 'https://www.goldmansachs.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', 521000000.0, 11934000000.0, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1869, 'Global investment banking and asset management firm. NYSE: GS, CIK 0000886982. Founded in 1869. Lead underwriter on some of the largest IPOs in history including DoorDash, Snowflake, Rivian, Arm Holdings, and Duolingo.', '', 'active', 95, '["https://www.goldmansachs.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000886982&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/goldman-sachs"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0040-0040-0040-000000000040', 'Bank of America Corporation', 'Bank of America', 'investor', 'https://www.bankofamerica.com', 'Charlotte', 'NC', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1904, 'Global banking and financial services corporation. NYSE: BAC, CIK 0000070858. Founded in 1904 as Bank of Italy in San Francisco. Second-largest US bank by assets. Operates consumer banking, global banking, global markets, and Merrill Lynch wealth management.', '', 'active', 95, '["https://www.bankofamerica.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000070858&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/bank-of-america"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0041-0041-0041-000000000041', 'Wells Fargo & Company', 'Wells Fargo', 'investor', 'https://www.wellsfargo.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1852, 'Diversified financial services company. NYSE: WFC, CIK 0000072971. Founded in 1852 by Henry Wells and William Fargo. Third-largest US bank by assets. Operates consumer and small business banking, commercial banking, and corporate investment banking.', '', 'active', 95, '["https://www.wellsfargo.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000072971&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/wells-fargo"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0042-0042-0042-000000000042', 'Citigroup Inc.', 'Citigroup', 'investor', 'https://www.citigroup.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1812, 'Global banking institution. NYSE: C, CIK 0000831001. Predecessor City Bank of New York founded in 1812. Operates across institutional clients group, personal banking, and wealth management in approximately 160 countries.', '', 'active', 95, '["https://www.citigroup.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000831001&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/citi"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0043-0043-0043-000000000043', 'Morgan Stanley', 'Morgan Stanley', 'investor', 'https://www.morganstanley.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', 748000000.0, 8100000000.0, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1935, 'Global investment bank and wealth management firm. NYSE: MS, CIK 0000895421. Founded in 1935. Lead underwriter on landmark IPOs including Uber, Reddit, UiPath, and Airbnb. Operates investment banking, institutional securities, and wealth management globally.', '', 'active', 95, '["https://www.morganstanley.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000895421&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/morgan-stanley"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0044-0044-0044-000000000044', 'UBS Group AG', 'UBS', 'investor', 'https://www.ubs.com', 'Zurich', '', 'Switzerland', '["Switzerland"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1862, 'Global investment bank and wealth management firm. NYSE: UBS. Founded in 1862. Headquartered in Zurich, Switzerland. Completed acquisition of Credit Suisse in 2023. Serves private, corporate, and institutional clients worldwide.', '', 'active', 95, '["https://www.ubs.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001610520&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/ubs"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0045-0045-0045-000000000045', 'Deutsche Bank AG', 'Deutsche Bank', 'investor', 'https://www.db.com', 'Frankfurt', '', 'Germany', '["Germany"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1870, 'Global investment bank headquartered in Frankfurt, Germany. NYSE: DB. Founded in 1870. Files 20-F annual reports with the SEC. Operates investment banking, corporate banking, private banking, and asset management globally.', '', 'active', 95, '["https://www.db.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001159508&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/deutsche-bank"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0046-0046-0046-000000000046', 'Lazard Inc.', 'Lazard', 'investor', 'https://www.lazard.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1848, 'Independent investment bank and asset management firm. NYSE: LAZ, CIK 0001302215. Founded in 1848. Provides M&A advisory, restructuring, and asset management. One of the oldest and most prestigious independent advisory firms globally.', '', 'active', 95, '["https://www.lazard.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001302215&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/lazard"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0047-0047-0047-000000000047', 'Evercore Inc.', 'Evercore', 'investor', 'https://www.evercore.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1995, 'Independent investment banking advisory firm. NYSE: EVR, CIK 0001360901. Founded in 1995 by Roger Altman. Provides M&A advisory, restructuring, and equity capital markets services. Consistently ranked among the top independent advisory firms by deal volume.', '', 'active', 95, '["https://www.evercore.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001360901&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/evercore"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0048-0048-0048-000000000048', 'Sun Capital Partners Inc.', 'Sun Capital Partners', 'investor', 'https://www.suncappart.com', 'Boca Raton', 'FL', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 1995, 'Private equity firm specializing in operational turnarounds and management-led buyouts. Founded in 1995 by Marc Leder and Rodger Krouse. Headquartered in Boca Raton, FL. Has invested in over 400 companies since inception.', '', 'active', 85, '["https://www.suncappart.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001273753&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/sun-capital-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0049-0049-0049-000000000049', 'Marlin Equity Partners LLC', 'Marlin Equity Partners', 'investor', 'https://www.marlinequity.com', 'Manhattan Beach', 'CA', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 2005, 'Private equity firm focused on technology, software, and business services. Founded in 2005 by David McGovern. Headquartered in Manhattan Beach, CA, with offices in London. Has completed over 200 acquisitions since inception.', '', 'active', 85, '["https://www.marlinequity.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001409459&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/marlin-equity-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0050-0050-0050-000000000050', 'Frontenac Company LLC', 'Frontenac', 'investor', 'https://www.frontenac.com', 'Chicago', 'IL', 'USA', '["USA"]'::jsonb, '$500M-1B', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 1971, 'Lower middle market private equity firm founded in 1971. Headquartered in Chicago, IL. Focuses on management-led buyouts and recapitalizations of companies in business services, consumer, and industrial sectors.', '', 'active', 85, '["https://www.frontenac.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001016287&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/frontenac"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0051-0051-0051-000000000051', 'Huron Capital Partners LLC', 'Huron Capital', 'investor', 'https://www.huroncapital.com', 'Detroit', 'MI', 'USA', '["USA"]'::jsonb, '$500M-1B', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 1999, 'Lower middle market private equity firm founded in 1999. Headquartered in Detroit, MI. Focuses on buyouts and build-ups in fragmented industries. Uses a proprietary thesis-driven deal sourcing approach.', '', 'active', 85, '["https://www.huroncapital.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001560089&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/huron-capital-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0052-0052-0052-000000000052', 'California Public Employees'' Retirement System', 'CalPERS', 'investor', 'https://www.calpers.ca.gov', 'Sacramento', 'CA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1932, 'Largest public pension fund in the United States with $503B AUM as of June 30 2024 (calpers.ca.gov 2024 Annual Report). Serves approximately 2 million members. Invests across public equity, fixed income, private equity, real assets, and real estate.', '', 'active', 95, '["https://www.calpers.ca.gov", "https://www.linkedin.com/company/calpers"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0053-0053-0053-000000000053', 'Ontario Teachers'' Pension Plan Board', 'Ontario Teachers''', 'investor', 'https://www.otpp.com', 'Toronto', 'ON', 'Canada', '["Canada"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1990, 'Canadian pension fund with CAD $247.5B in net assets (2023 Annual Report, otpp.com). Founded in 1990. Serves approximately 340,000 working and retired teachers in Ontario. Known for direct investing capability across infrastructure, private equity, and real assets.', '', 'active', 95, '["https://www.otpp.com", "https://www.linkedin.com/company/ontario-teachers-pension-plan"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0054-0054-0054-000000000054', 'Canada Pension Plan Investment Board', 'CPP Investments', 'investor', 'https://www.cppinvestments.com', 'Toronto', 'ON', 'Canada', '["Canada"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1997, 'Canadian Crown corporation managing the CPP Fund with CAD $632B AUM (cppinvestments.com 2024 Annual Report). Founded in 1997. Invests on behalf of approximately 21 million contributors and beneficiaries. One of the world''s 10 largest pension funds.', '', 'active', 95, '["https://www.cppinvestments.com", "https://www.linkedin.com/company/cpp-investments"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0055-0055-0055-000000000055', 'Hamilton Lane Advisors LLC', 'Hamilton Lane', 'investor', 'https://www.hamiltonlane.com', 'Conshohocken', 'PA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1991, 'Global private markets investment management firm with $900B+ in assets under management and supervision (10-K). NASDAQ: HLNE, CIK 0001433642. Founded in 1991. Provides fund of funds, direct co-investment, and customized separate accounts globally.', '', 'active', 95, '["https://www.hamiltonlane.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001433642&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/hamilton-lane"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0056-0056-0056-000000000056', 'StepStone Group LP', 'StepStone Group', 'investor', 'https://www.stepstonegroup.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 2007, 'Global private markets investment firm with $675B+ in AUM and advisory assets (10-K). NASDAQ: STEP, CIK 0001816090. Founded in 2007. Provides customized investment solutions for institutional investors across all private market strategies.', '', 'active', 95, '["https://www.stepstonegroup.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001816090&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/stepstone-group"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0057-0057-0057-000000000057', 'HarbourVest Partners LLC', 'HarbourVest Partners', 'investor', 'https://www.harbourvest.com', 'Boston', 'MA', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1982, 'Global private markets investment management firm with approximately $116B AUM (harbourvest.com). Founded in 1982. Provides fund of funds, direct co-investments, and secondary market solutions to institutional investors worldwide.', '', 'active', 90, '["https://www.harbourvest.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000875500&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/harbourvest-partners"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0058-0058-0058-000000000058', 'First Round Capital Management LLC', 'First Round Capital', 'investor', 'https://www.firstround.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '$500M-1B', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2004, 'Seed-stage venture capital firm founded in 2004 by Josh Kopelman. Registered investment adviser (SEC Form ADV). Early backer of Uber, Square, Warby Parker, Mint, Flatiron Health, and Roblox. Known for founder-focused approach and community platform.', '', 'active', 90, '["https://www.firstround.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001562088&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/first-round-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0059-0059-0059-000000000059', 'Y Combinator Management LLC', 'Y Combinator', 'investor', 'https://www.ycombinator.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '$500M-1B', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2005, 'World''s most influential startup accelerator and seed investor. Founded in 2005 by Paul Graham, Jessica Livingston, Trevor Blackwell, and Robert Morris. Alumni include Airbnb, Dropbox, Stripe, Coinbase, Reddit, DoorDash, and thousands of others.', '', 'active', 90, '["https://www.ycombinator.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001697303&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/y-combinator"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0060-0060-0060-000000000060', 'Lux Capital Management LLC', 'Lux Capital', 'investor', 'https://www.luxcapital.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$1B-5B', NULL, NULL, '["seed", "A", "B", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 2000, 'Deep tech and science-focused venture capital firm founded in 2000 by Josh Wolfe and Peter Hébert. Registered investment adviser (SEC Form ADV). Portfolio includes Osmo, Kaleidoscope Bio, Orbital Insight, and Shypdirect.', '', 'active', 90, '["https://www.luxcapital.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001607241&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/lux-capital"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0061-0061-0061-000000000061', 'GIC Private Limited', 'GIC', 'investor', 'https://www.gic.com.sg', 'Singapore', '', 'Singapore', '["Singapore"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1981, 'Singapore sovereign wealth fund managing government reserves. Founded in 1981. Estimated AUM of $770B+ (gic.com.sg). Invests across public markets, private equity, real estate, and infrastructure in over 40 countries.', '', 'active', 90, '["https://www.gic.com.sg", "https://www.linkedin.com/company/gic"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0062-0062-0062-000000000062', 'Temasek Holdings Private Limited', 'Temasek', 'investor', 'https://www.temasek.com.sg', 'Singapore', '', 'Singapore', '["Singapore"]'::jsonb, '$10B+', NULL, NULL, '["seed", "A", "growth"]'::jsonb, '["equity"]'::jsonb, 1974, 'Singapore state-owned investment company with SGD $389B net portfolio value (temasek.com.sg 2024 Annual Report). Founded in 1974. Active investor in technology, financial services, and consumer sectors globally. Owns stakes in Singapore Airlines, DBS Bank, and ST Engineering.', '', 'active', 90, '["https://www.temasek.com.sg", "https://www.linkedin.com/company/temasek"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.'),
  ('a1b2c3d4-0063-0063-0063-000000000063', 'Mubadala Investment Company PJSC', 'Mubadala', 'investor', 'https://www.mubadala.com', 'Abu Dhabi', '', 'UAE', '["UAE"]'::jsonb, '$10B+', NULL, NULL, '["buyout", "growth"]'::jsonb, '["equity", "buyout", "special-sit"]'::jsonb, 2002, 'Abu Dhabi sovereign wealth fund with $302B AUM (mubadala.com 2024 Annual Review). Founded in 2002. Invests in technology, aerospace, energy, healthcare, and real estate globally. LP and direct investor in leading PE and VC funds worldwide.', '', 'active', 90, '["https://www.mubadala.com", "https://www.linkedin.com/company/mubadala"]'::jsonb, 'Ported from legacy seed; taxonomy via junction tables.')
ON CONFLICT (id) DO UPDATE SET
  legal_name = EXCLUDED.legal_name, firm_name = EXCLUDED.firm_name, firm_type = EXCLUDED.firm_type,
  website = EXCLUDED.website, hq_city = EXCLUDED.hq_city, hq_state = EXCLUDED.hq_state,
  hq_country = EXCLUDED.hq_country, geography_focus = EXCLUDED.geography_focus, aum_range = EXCLUDED.aum_range,
  check_size_min = EXCLUDED.check_size_min, check_size_max = EXCLUDED.check_size_max,
  stage_preferences = EXCLUDED.stage_preferences, deal_type_preferences = EXCLUDED.deal_type_preferences,
  year_founded = EXCLUDED.year_founded, description = EXCLUDED.description,
  crm_status = EXCLUDED.crm_status, internal_score = EXCLUDED.internal_score,
  source_links = EXCLUDED.source_links, notes = EXCLUDED.notes, updated_at = NOW();

-- firm_investor_types
INSERT INTO firm_investor_types (firm_id, category_id)
VALUES
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0006-0006-0006-000000000006', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0007-0007-0007-000000000007', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0026-0026-0026-000000000026', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0031-0031-0031-000000000031', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0032-0032-0032-000000000032', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0034-0034-0034-000000000034', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0037-0037-0037-000000000037', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0037-0037-0037-000000000037', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM investor_categories WHERE slug = 'independent-sponsors')),
  ('a1b2c3d4-0049-0049-0049-000000000049', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0049-0049-0049-000000000049', (SELECT id FROM investor_categories WHERE slug = 'independent-sponsors')),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM investor_categories WHERE slug = 'independent-sponsors')),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM investor_categories WHERE slug = 'independent-sponsors')),
  ('a1b2c3d4-0052-0052-0052-000000000052', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0053-0053-0053-000000000053', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0054-0054-0054-000000000054', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0055-0055-0055-000000000055', (SELECT id FROM investor_categories WHERE slug = 'allocators')),
  ('a1b2c3d4-0055-0055-0055-000000000055', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0056-0056-0056-000000000056', (SELECT id FROM investor_categories WHERE slug = 'allocators')),
  ('a1b2c3d4-0056-0056-0056-000000000056', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0057-0057-0057-000000000057', (SELECT id FROM investor_categories WHERE slug = 'allocators')),
  ('a1b2c3d4-0057-0057-0057-000000000057', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0061-0061-0061-000000000061', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM investor_categories WHERE slug = 'investors')),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM investor_categories WHERE slug = 'family-offices')),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM investor_categories WHERE slug = 'hedge-funds')),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM investor_categories WHERE slug = 'private-equity')),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM investor_categories WHERE slug = 'independent-sponsors')),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM investor_categories WHERE slug = 'venture-capital')),
  ('a1b2c3d4-0052-0052-0052-000000000052', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors')),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM investor_categories WHERE slug = 'search-funds')),
  ('a1b2c3d4-0055-0055-0055-000000000055', (SELECT id FROM investor_categories WHERE slug = 'allocators')),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM investor_categories WHERE slug = 'private-investors')),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM investor_categories WHERE slug = 'angel-investors'))
ON CONFLICT (firm_id, category_id) DO NOTHING;

-- firm_industries
INSERT INTO firm_industries (firm_id, industry_id, is_primary)
VALUES
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0001-0001-0001-000000000001', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM industry_verticals WHERE slug = 'crypto-blockchain'), false),
  ('a1b2c3d4-0002-0002-0002-000000000002', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), true),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0003-0003-0003-000000000003', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0004-0004-0004-000000000004', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0005-0005-0005-000000000005', (SELECT id FROM industry_verticals WHERE slug = 'retail-ecommerce'), false),
  ('a1b2c3d4-0006-0006-0006-000000000006', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0006-0006-0006-000000000006', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0007-0007-0007-000000000007', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0007-0007-0007-000000000007', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0016-0016-0016-000000000016', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'retail-ecommerce'), false),
  ('a1b2c3d4-0017-0017-0017-000000000017', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0018-0018-0018-000000000018', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0020-0020-0020-000000000020', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0021-0021-0021-000000000021', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0022-0022-0022-000000000022', (SELECT id FROM industry_verticals WHERE slug = 'cleantech-climate'), false),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0023-0023-0023-000000000023', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0024-0024-0024-000000000024', (SELECT id FROM industry_verticals WHERE slug = 'industrials'), false),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'retail-ecommerce'), false),
  ('a1b2c3d4-0025-0025-0025-000000000025', (SELECT id FROM industry_verticals WHERE slug = 'industrials'), false),
  ('a1b2c3d4-0026-0026-0026-000000000026', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0026-0026-0026-000000000026', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0026-0026-0026-000000000026', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0026-0026-0026-000000000026', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0027-0027-0027-000000000027', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM industry_verticals WHERE slug = 'defense-government'), false),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM industry_verticals WHERE slug = 'biotech-life-sciences'), false),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0028-0028-0028-000000000028', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0029-0029-0029-000000000029', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0030-0030-0030-000000000030', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0031-0031-0031-000000000031', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0031-0031-0031-000000000031', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0032-0032-0032-000000000032', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0032-0032-0032-000000000032', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0032-0032-0032-000000000032', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0033-0033-0033-000000000033', (SELECT id FROM industry_verticals WHERE slug = 'education'), false),
  ('a1b2c3d4-0034-0034-0034-000000000034', (SELECT id FROM industry_verticals WHERE slug = 'retail-ecommerce'), true),
  ('a1b2c3d4-0034-0034-0034-000000000034', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0034-0034-0034-000000000034', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0034-0034-0034-000000000034', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), true),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'hospitality'), false),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'agriculture'), false),
  ('a1b2c3d4-0035-0035-0035-000000000035', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM industry_verticals WHERE slug = 'manufacturing'), true),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0036-0036-0036-000000000036', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0037-0037-0037-000000000037', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0037-0037-0037-000000000037', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0037-0037-0037-000000000037', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0038-0038-0038-000000000038', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0039-0039-0039-000000000039', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0040-0040-0040-000000000040', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0041-0041-0041-000000000041', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0042-0042-0042-000000000042', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0043-0043-0043-000000000043', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0044-0044-0044-000000000044', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0045-0045-0045-000000000045', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0046-0046-0046-000000000046', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0047-0047-0047-000000000047', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), true),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM industry_verticals WHERE slug = 'retail-ecommerce'), false),
  ('a1b2c3d4-0048-0048-0048-000000000048', (SELECT id FROM industry_verticals WHERE slug = 'industrials'), false),
  ('a1b2c3d4-0049-0049-0049-000000000049', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0049-0049-0049-000000000049', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), true),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM industry_verticals WHERE slug = 'industrials'), false),
  ('a1b2c3d4-0050-0050-0050-000000000050', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), true),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM industry_verticals WHERE slug = 'industrials'), false),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0051-0051-0051-000000000051', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0052-0052-0052-000000000052', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0052-0052-0052-000000000052', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0052-0052-0052-000000000052', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0053-0053-0053-000000000053', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0053-0053-0053-000000000053', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0053-0053-0053-000000000053', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0054-0054-0054-000000000054', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0054-0054-0054-000000000054', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0054-0054-0054-000000000054', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0055-0055-0055-000000000055', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), true),
  ('a1b2c3d4-0056-0056-0056-000000000056', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), true),
  ('a1b2c3d4-0056-0056-0056-000000000056', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0057-0057-0057-000000000057', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), true),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0058-0058-0058-000000000058', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0059-0059-0059-000000000059', (SELECT id FROM industry_verticals WHERE slug = 'biotech-life-sciences'), false),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM industry_verticals WHERE slug = 'biotech-life-sciences'), true),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM industry_verticals WHERE slug = 'defense-government'), false),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM industry_verticals WHERE slug = 'ai-ml'), false),
  ('a1b2c3d4-0060-0060-0060-000000000060', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0061-0061-0061-000000000061', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0061-0061-0061-000000000061', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0061-0061-0061-000000000061', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0061-0061-0061-000000000061', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'infrastructure'), false),
  ('a1b2c3d4-0062-0062-0062-000000000062', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'defense-government'), false),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'energy'), false),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'healthcare'), false),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false),
  ('a1b2c3d4-0063-0063-0063-000000000063', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), false)
ON CONFLICT (firm_id, industry_id) DO NOTHING;

-- contacts
INSERT INTO contacts (
  id, firm_id, first_name, last_name, title, email, phone, linkedin_url, is_primary, department, notes
) VALUES
  ('b1c2d3e4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000001', 'Roelof', 'Botha', 'Steward', '', '', 'https://www.linkedin.com/in/roelofbotha', false, '', 'Steward at Sequoia Capital. Joined as associate in 2003 after working with Michael Moritz through the PayPal IPO. Made partner in 2007 following the YouTube acquisition (which he advocated for). Former CFO of PayPal.'),
  ('b1c2d3e4-0002-0002-0002-000000000002', 'a1b2c3d4-0001-0001-0001-000000000001', 'Alfred', 'Lin', 'Partner', '', '', 'https://www.linkedin.com/in/alfred-lin-sequoia', false, '', 'Partner at Sequoia Capital. Former COO and CFO of Zappos (acquired by Amazon for ~$1.2B). Board member at Airbnb, DoorDash, and Houzz. Joined Sequoia in 2010.'),
  ('b1c2d3e4-0003-0003-0003-000000000003', 'a1b2c3d4-0001-0001-0001-000000000001', 'Doug', 'Leone', 'Global Steward (Retired)', '', '', 'https://www.linkedin.com/in/dougleone', false, '', 'Former Global Steward at Sequoia Capital. Joined the firm in 1988. Led investments in Palo Alto Networks, ServiceNow, and Roper Technologies. Stepped back from active management in 2023.'),
  ('b1c2d3e4-0004-0004-0004-000000000004', 'a1b2c3d4-0002-0002-0002-000000000002', 'Marc', 'Andreessen', 'General Partner and Co-Founder', '', '', 'https://www.linkedin.com/in/marc-andreessen', false, '', 'Co-Founder and General Partner at Andreessen Horowitz. Co-creator of the Mosaic web browser and co-founder of Netscape. Built a16z in 2009 on the conviction that software would eat the world.'),
  ('b1c2d3e4-0005-0005-0005-000000000005', 'a1b2c3d4-0002-0002-0002-000000000002', 'Ben', 'Horowitz', 'General Partner and Co-Founder', '', '', 'https://www.linkedin.com/in/ben-horowitz', false, '', 'Co-Founder and General Partner at Andreessen Horowitz. Former CEO of Opsware (sold to HP for $1.6B in 2007). Author of "The Hard Thing About Hard Things". Co-founded a16z in 2009 with Marc Andreessen.'),
  ('b1c2d3e4-0006-0006-0006-000000000006', 'a1b2c3d4-0002-0002-0002-000000000002', 'Chris', 'Dixon', 'General Partner', '', '', 'https://www.linkedin.com/in/chrisdixon', false, '', 'General Partner at Andreessen Horowitz, leads the a16z crypto fund. Early-stage investor in Coinbase, Oculus VR (acquired by Facebook), and Kickstarter. Joined a16z in 2012.'),
  ('b1c2d3e4-0007-0007-0007-000000000007', 'a1b2c3d4-0002-0002-0002-000000000002', 'Scott', 'Kupor', 'Managing Partner', '', '', 'https://www.linkedin.com/in/scottkupor', false, '', 'Managing Partner at Andreessen Horowitz, overseeing firm operations and strategy. Author of "Secrets of Sand Hill Road: Venture Capital and How to Get It". Has been with a16z since its founding in 2009.'),
  ('b1c2d3e4-0008-0008-0008-000000000008', 'a1b2c3d4-0003-0003-0003-000000000003', 'Stephen', 'Schwarzman', 'Chairman, CEO and Co-Founder', '', '', 'https://www.linkedin.com/in/stephen-schwarzman', false, '', 'Chairman, CEO and Co-Founder of Blackstone. Founded the firm in 1985. Oversees $1.2 trillion in AUM (as of Q3 2025). Major philanthropist; donated $350M to MIT and $100M to Oxford.'),
  ('b1c2d3e4-0009-0009-0009-000000000009', 'a1b2c3d4-0003-0003-0003-000000000003', 'Jonathan', 'Gray', 'President and COO', '', '', 'https://www.linkedin.com/in/jon-gray-blackstone', false, '', 'President and COO of Blackstone. Leads the firm''s global real estate business, the largest component of Blackstone''s AUM. Joined Blackstone in 1992 and has been President since 2018.'),
  ('b1c2d3e4-0010-0010-0010-000000000010', 'a1b2c3d4-0004-0004-0004-000000000004', 'Henry', 'Kravis', 'Co-Founder and Co-Executive Chairman', '', '', 'https://www.linkedin.com/in/henry-kravis', false, '', 'Co-Founder and Co-Executive Chairman of KKR. Pioneer of the leveraged buyout industry. Led the landmark $31B RJR Nabisco LBO in 1989 — the largest LBO in history at the time. Joined the firm as Co-Executive Chairman in 2021.'),
  ('b1c2d3e4-0011-0011-0011-000000000011', 'a1b2c3d4-0004-0004-0004-000000000004', 'Scott', 'Nuttall', 'Co-Chief Executive Officer', '', '', 'https://www.linkedin.com/in/scott-nuttall-kkr', false, '', 'Co-CEO of KKR. Joined the firm in 1996. Previously led KKR''s Global Capital and Asset Management business. Became Co-CEO alongside Joseph Bae in 2021 when Kravis and Roberts transitioned to Co-Executive Chairmen.'),
  ('b1c2d3e4-0012-0012-0012-000000000012', 'a1b2c3d4-0005-0005-0005-000000000005', 'Scott', 'Shleifer', 'Founder and Partner', '', '', 'https://www.linkedin.com/in/scott-shleifer', false, '', 'Founder and Partner at Tiger Global Management. Formerly at Tiger Management under Julian Robertson. Oversees both the private equity and hedge fund strategies.'),
  ('b1c2d3e4-0013-0013-0013-000000000013', 'a1b2c3d4-0005-0005-0005-000000000005', 'Chase', 'Coleman', 'Founder and Managing Partner', '', '', 'https://www.linkedin.com/in/chase-coleman-iii', false, '', 'Founder and Managing Partner of Tiger Global Management. Founded the firm in 2001. Manages the hedge fund strategies alongside the private investment vehicles.'),
  ('b1c2d3e4-0014-0014-0014-000000000014', 'a1b2c3d4-0006-0006-0006-000000000006', 'Kenneth', 'Griffin', 'Founder, CEO and Co-Chief Investment Officer', '', '', 'https://www.linkedin.com/in/kenneth-griffin', false, '', 'Founder, CEO and Co-CIO of Citadel LLC and Citadel Securities. Began investing in 1986 as a Harvard freshman. Founded Citadel in 1990. Team of over 2,500 professionals. Established global HQ in Miami in 2022.'),
  ('b1c2d3e4-0015-0015-0015-000000000015', 'a1b2c3d4-0007-0007-0007-000000000007', 'Ray', 'Dalio', 'Founder and Co-Chief Investment Officer (Retired)', '', '', 'https://www.linkedin.com/in/raydalio', false, '', 'Founder of Bridgewater Associates. Created the All Weather and Pure Alpha macro strategies. Transitioned from Co-CIO role in 2022. Author of "Principles: Life and Work". Forbes ranked him among the 100 wealthiest people globally.'),
  ('b1c2d3e4-0016-0016-0016-000000000016', 'a1b2c3d4-0020-0020-0020-000000000020', 'Leon', 'Black', 'Co-Founder (Retired CEO)', '', '', 'https://www.linkedin.com/in/leon-black-apollo', false, '', 'Co-Founder of Apollo Global Management. Retired as CEO in March 2021. Previously led Drexel Burnham Lambert M&A. Built Apollo into one of the world''s largest alternative asset managers with $696B AUM as of 2024.'),
  ('b1c2d3e4-0017-0017-0017-000000000017', 'a1b2c3d4-0020-0020-0020-000000000020', 'Marc', 'Rowan', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/marc-rowan', false, '', 'CEO of Apollo Global Management since March 2021. Co-founded Apollo in 1990. Led the firm''s transformation into a leading alternative asset and retirement services platform.'),
  ('b1c2d3e4-0018-0018-0018-000000000018', 'a1b2c3d4-0021-0021-0021-000000000021', 'David', 'Rubenstein', 'Co-Founder and Co-Chairman', '', '', 'https://www.linkedin.com/in/david-rubenstein', false, '', 'Co-Founder and Co-Chairman of The Carlyle Group. Founded Carlyle in 1987. Former Deputy Assistant to President Jimmy Carter. Prominent philanthropist and author of The American Story.'),
  ('b1c2d3e4-0019-0019-0019-000000000019', 'a1b2c3d4-0021-0021-0021-000000000021', 'Harvey', 'Schwartz', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/harvey-schwartz-carlyle', false, '', 'CEO of The Carlyle Group since February 2023. Previously President and Co-COO of Goldman Sachs.'),
  ('b1c2d3e4-0020-0020-0020-000000000020', 'a1b2c3d4-0022-0022-0022-000000000022', 'David', 'Bonderman', 'Co-Founder and Chairman', '', '', 'https://www.linkedin.com/in/david-bonderman', false, '', 'Co-Founder and Chairman of TPG. Co-founded in 1992 with James Coulter. Previously COO of the Bass Group. Led investments in Continental Airlines, Burger King, and Ducati.'),
  ('b1c2d3e4-0021-0021-0021-000000000021', 'a1b2c3d4-0022-0022-0022-000000000022', 'Jon', 'Winkelried', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/jon-winkelried', false, '', 'CEO of TPG. Joined TPG in 2008 after serving as Co-President and Co-COO of Goldman Sachs. Leads global investment strategy across PE, growth, impact, and real estate.'),
  ('b1c2d3e4-0022-0022-0022-000000000022', 'a1b2c3d4-0023-0023-0023-000000000023', 'Timothy', 'Geithner', 'President', '', '', 'https://www.linkedin.com/in/timothy-geithner', false, '', '75th US Treasury Secretary 2009-2013 under President Obama. Previously President of the Federal Reserve Bank of New York. President of Warburg Pincus since 2013.'),
  ('b1c2d3e4-0023-0023-0023-000000000023', 'a1b2c3d4-0023-0023-0023-000000000023', 'Jeffrey', 'Paine', 'Managing Director', '', '', 'https://www.linkedin.com/in/jeffrey-paine-warburg', false, '', 'Managing Director at Warburg Pincus. Leads Southeast Asia investment strategy. Co-founded Golden Gate Ventures before joining Warburg Pincus.'),
  ('b1c2d3e4-0024-0024-0024-000000000024', 'a1b2c3d4-0024-0024-0024-000000000024', 'David', 'Mussafer', 'Managing Partner and Chairman', '', '', 'https://www.linkedin.com/in/david-mussafer', false, '', 'Managing Partner and Chairman of Advent International. Has been with the firm since 1990. Leads North American PE investment activity and oversees global operations.'),
  ('b1c2d3e4-0025-0025-0025-000000000025', 'a1b2c3d4-0024-0024-0024-000000000024', 'James', 'Westra', 'Managing Director', '', '', 'https://www.linkedin.com/in/james-westra-advent', false, '', 'Managing Director at Advent International. Focuses on technology and business services in North America and Europe.'),
  ('b1c2d3e4-0026-0026-0026-000000000026', 'a1b2c3d4-0025-0025-0025-000000000025', 'Steve', 'Pagliuca', 'Managing Director and Co-Chairman', '', '', 'https://www.linkedin.com/in/steve-pagliuca', false, '', 'Managing Director and Co-Chairman of Bain Capital since 1989. Co-Owner of the Boston Celtics NBA franchise.'),
  ('b1c2d3e4-0027-0027-0027-000000000027', 'a1b2c3d4-0025-0025-0025-000000000025', 'Jonathan', 'Lavine', 'Co-Managing Partner', '', '', 'https://www.linkedin.com/in/jonathan-lavine', false, '', 'Co-Managing Partner of Bain Capital. Joined in 1993. Leads Bain Capital Credit. Chair of Columbia University Board of Trustees.'),
  ('b1c2d3e4-0028-0028-0028-000000000028', 'a1b2c3d4-0026-0026-0026-000000000026', 'Bill', 'Gurley', 'General Partner', '', '', 'https://www.linkedin.com/in/bill-gurley', false, '', 'General Partner at Benchmark since 1999. Led Benchmark investment in Uber (Series A, 2011). Also backed OpenTable, Zillow, Stitch Fix, and GrubHub. Writes the Above the Crowd investment blog.'),
  ('b1c2d3e4-0029-0029-0029-000000000029', 'a1b2c3d4-0026-0026-0026-000000000026', 'Eric', 'Vishria', 'General Partner', '', '', 'https://www.linkedin.com/in/ericvishria', false, '', 'General Partner at Benchmark. Previously co-founded Rockmelt (acquired by Yahoo in 2013). Focuses on enterprise software and developer tools.'),
  ('b1c2d3e4-0030-0030-0030-000000000030', 'a1b2c3d4-0027-0027-0027-000000000027', 'Hemant', 'Taneja', 'Managing Director and CEO', '', '', 'https://www.linkedin.com/in/hementtaneja', false, '', 'Managing Director and CEO of General Catalyst since 2007. Author of Unscaled. Board member at Livongo, Snap, and Samsara.'),
  ('b1c2d3e4-0031-0031-0031-000000000031', 'a1b2c3d4-0027-0027-0027-000000000027', 'Niko', 'Bonatsos', 'Managing Director', '', '', 'https://www.linkedin.com/in/nikobonatsos', false, '', 'Managing Director at General Catalyst. Focuses on consumer internet and mobile. Backed Discord, Grammarly, and Snap. Joined General Catalyst in 2012.'),
  ('b1c2d3e4-0032-0032-0032-000000000032', 'a1b2c3d4-0028-0028-0028-000000000028', 'Peter', 'Thiel', 'Co-Founder and Partner', '', '', 'https://www.linkedin.com/in/peterthiel', false, '', 'Co-Founder and Partner of Founders Fund. Co-founded PayPal (sold to eBay $1.5B, 2002), first outside investor in Facebook ($500K, 2004), co-founded Palantir. Established Founders Fund in 2005.'),
  ('b1c2d3e4-0033-0033-0033-000000000033', 'a1b2c3d4-0028-0028-0028-000000000028', 'Keith', 'Rabois', 'Partner', '', '', 'https://www.linkedin.com/in/keith-rabois', false, '', 'Partner at Founders Fund. PayPal Mafia member; former EVP PayPal, VP Business Development LinkedIn, COO Square. Investor in DoorDash, Airbnb, YouTube, and Yelp.'),
  ('b1c2d3e4-0034-0034-0034-000000000034', 'a1b2c3d4-0029-0029-0029-000000000029', 'Jim', 'Breyer', 'Founding Partner (now at Breyer Capital)', '', '', 'https://www.linkedin.com/in/jimbreyer', false, '', 'Founding Partner of Accel. Led $12.7M Series A in Facebook (2005). Backed Etsy, Marvel Entertainment, and Spotify. Founded Breyer Capital. Former Chairman of NVCA.'),
  ('b1c2d3e4-0035-0035-0035-000000000035', 'a1b2c3d4-0029-0029-0029-000000000029', 'Rich', 'Wong', 'General Partner', '', '', 'https://www.linkedin.com/in/richwong', false, '', 'General Partner at Accel. Enterprise software, cloud, and cybersecurity focus. Board member at Atlassian, Qualtrics, and Tenable. Joined Accel in 2006.'),
  ('b1c2d3e4-0036-0036-0036-000000000036', 'a1b2c3d4-0030-0030-0030-000000000030', 'Steve', 'Cohen', 'Founder and CEO', '', '', 'https://www.linkedin.com/in/steve-cohen-point72', false, '', 'Founder and CEO of Point72 Asset Management. Founded in 2014 as successor to SAC Capital. Owner of the New York Mets (MLB).'),
  ('b1c2d3e4-0037-0037-0037-000000000037', 'a1b2c3d4-0030-0030-0030-000000000030', 'Doug', 'Haynes', 'President', '', '', 'https://www.linkedin.com/in/doughaynes', false, '', 'President of Point72 Asset Management. Previously senior partner at McKinsey leading global technology practice. Joined Point72 to lead firm operations and talent strategy.'),
  ('b1c2d3e4-0038-0038-0038-000000000038', 'a1b2c3d4-0031-0031-0031-000000000031', 'David', 'Shaw', 'Founder and Chief Scientist', '', '', 'https://www.linkedin.com/in/david-e-shaw', false, '', 'Founder and Chief Scientist of D.E. Shaw. Founded in 1988. Former Columbia computer science professor. Pioneered computational quantitative investing. Now focuses on D.E. Shaw Research in computational biochemistry.'),
  ('b1c2d3e4-0039-0039-0039-000000000039', 'a1b2c3d4-0031-0031-0031-000000000031', 'Julius', 'Gaudio', 'Co-Chief Executive Officer', '', '', 'https://www.linkedin.com/in/julius-gaudio', false, '', 'Co-CEO of D.E. Shaw. Oversees day-to-day operations and investment businesses. Long-tenured executive with deep experience in quantitative and systematic strategies.'),
  ('b1c2d3e4-0040-0040-0040-000000000040', 'a1b2c3d4-0032-0032-0032-000000000032', 'John', 'Overdeck', 'Co-Founder and Co-Chairman', '', '', 'https://www.linkedin.com/in/john-overdeck', false, '', 'Co-Founder and Co-Chairman of Two Sigma Investments. Co-founded 2001 with David Siegel. Previously at D.E. Shaw and Amazon. International Mathematical Olympiad gold medalist (1986).'),
  ('b1c2d3e4-0041-0041-0041-000000000041', 'a1b2c3d4-0032-0032-0032-000000000032', 'David', 'Siegel', 'Co-Founder and Co-Chairman', '', '', 'https://www.linkedin.com/in/davidsiegel-twosigma', false, '', 'Co-Founder and Co-Chairman of Two Sigma Investments. Co-founded 2001 with John Overdeck. MIT PhD in computer science. Previously at D.E. Shaw and Paloma Partners.'),
  ('b1c2d3e4-0042-0042-0042-000000000042', 'a1b2c3d4-0033-0033-0033-000000000033', 'Bill', 'Gates', 'Principal', '', '', 'https://www.linkedin.com/in/williamhgates', false, '', 'Principal of Gates Frontier. Co-founded Microsoft in 1975. Led Microsoft as CEO until 2000. Co-chair of the Bill and Melinda Gates Foundation.'),
  ('b1c2d3e4-0043-0043-0043-000000000043', 'a1b2c3d4-0033-0033-0033-000000000033', 'Michael', 'Larson', 'Chief Investment Officer', '', '', 'https://www.linkedin.com/in/michael-larson-cascade', false, '', 'Chief Investment Officer for Gates Frontier and Cascade Investment LLC since 1994. Manages Bill Gates personal investment portfolio across equities, real estate, energy, and alternatives.'),
  ('b1c2d3e4-0044-0044-0044-000000000044', 'a1b2c3d4-0034-0034-0034-000000000034', 'Rob', 'Walton', 'Chairman Emeritus of Walmart; Principal of Walton Enterprises', '', '', 'https://www.linkedin.com/in/rob-walton', false, '', 'S. Robson Walton, Chairman Emeritus of Walmart and principal of Walton Enterprises LLC. Son of Sam Walton. Served as Walmart Chairman 1992-2015.'),
  ('b1c2d3e4-0045-0045-0045-000000000045', 'a1b2c3d4-0034-0034-0034-000000000034', 'Greg', 'Penner', 'Chairman of Walmart Board', '', '', 'https://www.linkedin.com/in/greg-penner', false, '', 'Chairman of the Walmart Board of Directors since 2015. Son-in-law of Rob Walton. Former General Partner at Madrone Capital Partners. Serves on boards of Google and Hyatt Hotels.'),
  ('b1c2d3e4-0046-0046-0046-000000000046', 'a1b2c3d4-0035-0035-0035-000000000035', 'Michael', 'Larson', 'Chief Investment Officer', '', '', 'https://www.linkedin.com/in/michael-larson-cascade', false, '', 'Chief Investment Officer of Cascade Investment LLC since 1994. Manages Bill Gates personal portfolio including Canadian National Railway, AutoNation, and Four Seasons Hotels. Also serves as CIO of Gates Frontier LLC.'),
  ('b1c2d3e4-0047-0047-0047-000000000047', 'a1b2c3d4-0036-0036-0036-000000000036', 'Tony', 'Pritzker', 'Chairman', '', '', 'https://www.linkedin.com/in/tony-pritzker', false, '', 'Chairman of Pritzker Private Capital. Member of the Pritzker family, heirs to the Hyatt Hotels fortune. Oversees family PE and direct investment activities.'),
  ('b1c2d3e4-0048-0048-0048-000000000048', 'a1b2c3d4-0036-0036-0036-000000000036', 'Paul', 'Carbone', 'Managing Partner', '', '', 'https://www.linkedin.com/in/paul-carbone-pritzker', false, '', 'Managing Partner of Pritzker Private Capital. Leads investment strategy and portfolio company management.'),
  ('b1c2d3e4-0049-0049-0049-000000000049', 'a1b2c3d4-0037-0037-0037-000000000037', 'Gregory', 'Fleming', 'President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/gregory-fleming', false, '', 'President and CEO of Rockefeller Capital Management, which he founded in 2018. Previously President of Morgan Stanley Wealth Management and President of Merrill Lynch.'),
  ('b1c2d3e4-0050-0050-0050-000000000050', 'a1b2c3d4-0038-0038-0038-000000000038', 'Jamie', 'Dimon', 'Chairman and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/jamie-dimon', false, '', 'Chairman and CEO of JPMorgan Chase since 2005. Previously CEO of Bank One. Widely regarded as the most influential banker of his generation.'),
  ('b1c2d3e4-0051-0051-0051-000000000051', 'a1b2c3d4-0038-0038-0038-000000000038', 'Daniel', 'Pinto', 'President and Chief Operating Officer', '', '', 'https://www.linkedin.com/in/daniel-pinto-jpmorgan', false, '', 'President and COO of JPMorgan Chase. Also CEO of Corporate and Investment Bank. Born in Buenos Aires. Has been with JPMorgan since 1983.'),
  ('b1c2d3e4-0052-0052-0052-000000000052', 'a1b2c3d4-0039-0039-0039-000000000039', 'David', 'Solomon', 'Chairman and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/david-solomon-gs', false, '', 'Chairman and CEO of Goldman Sachs since October 2018. Previously Co-Head of Investment Banking. Led Goldman consumer banking initiative Marcus.'),
  ('b1c2d3e4-0053-0053-0053-000000000053', 'a1b2c3d4-0039-0039-0039-000000000039', 'John', 'Waldron', 'President and Chief Operating Officer', '', '', 'https://www.linkedin.com/in/john-waldron-goldman-sachs', false, '', 'President and COO of Goldman Sachs. Has been with the firm since 1994. Named President when Solomon became CEO in 2018.'),
  ('b1c2d3e4-0054-0054-0054-000000000054', 'a1b2c3d4-0040-0040-0040-000000000040', 'Brian', 'Moynihan', 'Chairman, President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/brianmoynihan', false, '', 'Chairman, President and CEO of Bank of America since 2010. Led Bank of America transformation and recovery post-financial crisis.'),
  ('b1c2d3e4-0055-0055-0055-000000000055', 'a1b2c3d4-0040-0040-0040-000000000040', 'Alastair', 'Borthwick', 'Chief Financial Officer', '', '', 'https://www.linkedin.com/in/alastair-borthwick', false, '', 'Chief Financial Officer of Bank of America. Joined from CIBC where he was Group Head of Capital Markets. Named CFO in 2021.'),
  ('b1c2d3e4-0056-0056-0056-000000000056', 'a1b2c3d4-0041-0041-0041-000000000041', 'Charles', 'Scharf', 'President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/charles-scharf', false, '', 'President and CEO of Wells Fargo since October 2019. Previously CEO of BNY Mellon and Visa. Leading Wells Fargo transformation following its retail banking scandal.'),
  ('b1c2d3e4-0057-0057-0057-000000000057', 'a1b2c3d4-0041-0041-0041-000000000041', 'Mike', 'Santomassimo', 'Chief Financial Officer', '', '', 'https://www.linkedin.com/in/mike-santomassimo', false, '', 'Chief Financial Officer of Wells Fargo. Joined in 2020 from BNY Mellon where he also served as CFO.'),
  ('b1c2d3e4-0058-0058-0058-000000000058', 'a1b2c3d4-0042-0042-0042-000000000042', 'Jane', 'Fraser', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/jane-fraser-citi', false, '', 'Chief Executive Officer of Citigroup since February 2021. First woman to lead a major US bank. Leading multi-year transformation of Citi global operations.'),
  ('b1c2d3e4-0059-0059-0059-000000000059', 'a1b2c3d4-0042-0042-0042-000000000042', 'Mark', 'Mason', 'Chief Financial Officer', '', '', 'https://www.linkedin.com/in/mark-mason-citi', false, '', 'Chief Financial Officer of Citigroup. Has been with Citi since 2001. Named CFO in 2019.'),
  ('b1c2d3e4-0060-0060-0060-000000000060', 'a1b2c3d4-0043-0043-0043-000000000043', 'James', 'Gorman', 'Executive Chairman', '', '', 'https://www.linkedin.com/in/james-gorman-morgan-stanley', false, '', 'Executive Chairman of Morgan Stanley. CEO 2010-January 2024. Led Morgan Stanley transformation into leading wealth and asset management firm. Oversaw E*Trade ($13B) and Eaton Vance ($7B) acquisitions.'),
  ('b1c2d3e4-0061-0061-0061-000000000061', 'a1b2c3d4-0043-0043-0043-000000000043', 'Ted', 'Pick', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/ted-pick', false, '', 'Chief Executive Officer of Morgan Stanley since January 2024. Previously Co-President and head of Institutional Securities. Has been with Morgan Stanley since 1990.'),
  ('b1c2d3e4-0062-0062-0062-000000000062', 'a1b2c3d4-0044-0044-0044-000000000044', 'Sergio', 'Ermotti', 'Group Chief Executive Officer', '', '', 'https://www.linkedin.com/in/sergio-ermotti', false, '', 'Group CEO of UBS since April 2023. Returned to lead Credit Suisse integration. Previously Group CEO 2011-2020.'),
  ('b1c2d3e4-0063-0063-0063-000000000063', 'a1b2c3d4-0044-0044-0044-000000000044', 'Todd', 'Tuckner', 'Group Chief Financial Officer', '', '', 'https://www.linkedin.com/in/todd-tuckner', false, '', 'Group CFO of UBS since 2023. Has been with UBS since 2007. Overseeing financial integration of Credit Suisse.'),
  ('b1c2d3e4-0064-0064-0064-000000000064', 'a1b2c3d4-0045-0045-0045-000000000045', 'Christian', 'Sewing', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/christian-sewing', false, '', 'Chief Executive Officer of Deutsche Bank since April 2018. Has been with Deutsche Bank since 1989. Led major restructuring refocusing on corporate banking and wealth management.'),
  ('b1c2d3e4-0065-0065-0065-000000000065', 'a1b2c3d4-0045-0045-0045-000000000045', 'James', 'von Moltke', 'Chief Financial Officer', '', '', 'https://www.linkedin.com/in/james-von-moltke', false, '', 'Chief Financial Officer of Deutsche Bank since 2017. Previously EVP and CFO of Citigroup Institutional Clients Group.'),
  ('b1c2d3e4-0066-0066-0066-000000000066', 'a1b2c3d4-0046-0046-0046-000000000046', 'Peter', 'Orszag', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/peter-orszag', false, '', 'CEO of Lazard since 2023. Previously Vice Chairman at Lazard. Former Director of the Office of Management and Budget under President Obama.'),
  ('b1c2d3e4-0067-0067-0067-000000000067', 'a1b2c3d4-0046-0046-0046-000000000046', 'Evan', 'Russo', 'Chief Financial Officer', '', '', 'https://www.linkedin.com/in/evan-russo-lazard', false, '', 'Chief Financial Officer of Lazard. Long-tenured Lazard executive. Oversees financial reporting and treasury for the global firm.'),
  ('b1c2d3e4-0068-0068-0068-000000000068', 'a1b2c3d4-0047-0047-0047-000000000047', 'John', 'Weinberg', 'Co-Executive Chairman and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/john-weinberg-evercore', false, '', 'Co-Executive Chairman and CEO of Evercore. Previously Senior Chairman at Goldman Sachs. Joined Evercore in 2016. Grandson of Goldman Sachs Sidney Weinberg.'),
  ('b1c2d3e4-0069-0069-0069-000000000069', 'a1b2c3d4-0047-0047-0047-000000000047', 'Ralph', 'Schlosstein', 'Co-Executive Chairman (Retired 2022)', '', '', 'https://www.linkedin.com/in/ralph-schlosstein', false, '', 'Co-Executive Chairman Emeritus of Evercore. Served as CEO 2009-2022. Previously co-founded BlackRock in 1988. Built Evercore into a top-ranked independent advisory firm.'),
  ('b1c2d3e4-0070-0070-0070-000000000070', 'a1b2c3d4-0048-0048-0048-000000000048', 'Marc', 'Leder', 'Co-Chief Executive Officer and Co-Founder', '', '', 'https://www.linkedin.com/in/marc-leder-sun-capital', false, '', 'Co-CEO and Co-Founder of Sun Capital Partners. Co-founded 1995 with Rodger Krouse. Previously at Lehman Brothers. Overseen over 400 acquisitions with operational improvement focus.'),
  ('b1c2d3e4-0071-0071-0071-000000000071', 'a1b2c3d4-0048-0048-0048-000000000048', 'Rodger', 'Krouse', 'Co-Chief Executive Officer and Co-Founder', '', '', 'https://www.linkedin.com/in/rodger-krouse', false, '', 'Co-CEO and Co-Founder of Sun Capital Partners. Co-founded 1995 with Marc Leder. Previously at Lehman Brothers. Leads deal sourcing and portfolio operations.'),
  ('b1c2d3e4-0072-0072-0072-000000000072', 'a1b2c3d4-0049-0049-0049-000000000049', 'David', 'McGovern', 'Founder and Managing Partner', '', '', 'https://www.linkedin.com/in/david-mcgovern-marlin', false, '', 'Founder and Managing Partner of Marlin Equity Partners. Founded 2005. Previously at DLJ Merchant Banking Partners and Bear Stearns. Built Marlin into a leading technology PE firm with over 200 acquisitions.'),
  ('b1c2d3e4-0073-0073-0073-000000000073', 'a1b2c3d4-0049-0049-0049-000000000049', 'Alex', 'Beek', 'Managing Partner', '', '', 'https://www.linkedin.com/in/alex-beek-marlin', false, '', 'Managing Partner at Marlin Equity Partners. Focuses on technology and software acquisitions globally.'),
  ('b1c2d3e4-0074-0074-0074-000000000074', 'a1b2c3d4-0050-0050-0050-000000000050', 'Paul', 'Carbery', 'Managing Partner', '', '', 'https://www.linkedin.com/in/paul-carbery-frontenac', false, '', 'Managing Partner of Frontenac Company. Leads Chief Executive Connections (CXC) model for sourcing and building lower middle market businesses.'),
  ('b1c2d3e4-0075-0075-0075-000000000075', 'a1b2c3d4-0050-0050-0050-000000000050', 'Clinton', 'Biondo', 'Partner', '', '', 'https://www.linkedin.com/in/clinton-biondo', false, '', 'Partner at Frontenac Company. Focuses on business services and consumer investments in the lower middle market.'),
  ('b1c2d3e4-0076-0076-0076-000000000076', 'a1b2c3d4-0051-0051-0051-000000000051', 'Brian', 'Demkowicz', 'Managing Partner', '', '', 'https://www.linkedin.com/in/brian-demkowicz', false, '', 'Managing Partner and Co-Founder of Huron Capital Partners. Founded 1999. Leads Huron thesis-driven approach to building platform companies through acquisition.'),
  ('b1c2d3e4-0077-0077-0077-000000000077', 'a1b2c3d4-0051-0051-0051-000000000051', 'Ian', 'Bain', 'Partner', '', '', 'https://www.linkedin.com/in/ian-bain-huron', false, '', 'Partner at Huron Capital Partners. Focuses on deal origination and portfolio company development across business services and healthcare.'),
  ('b1c2d3e4-0078-0078-0078-000000000078', 'a1b2c3d4-0052-0052-0052-000000000052', 'Marcie', 'Frost', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/marcie-frost-calpers', false, '', 'CEO of CalPERS since 2016. Previously Director of the Washington State Department of Retirement Systems. Leads $503B fund serving approximately 2 million California public employees.'),
  ('b1c2d3e4-0079-0079-0079-000000000079', 'a1b2c3d4-0052-0052-0052-000000000052', 'Theresa', 'Taylor', 'Board Chair', '', '', 'https://www.linkedin.com/in/theresa-taylor-calpers', false, '', 'Board Chair of the CalPERS Board of Administration. Elected member representing state employees. Also a member of the California State Personnel Board.'),
  ('b1c2d3e4-0080-0080-0080-000000000080', 'a1b2c3d4-0053-0053-0053-000000000053', 'Jo', 'Taylor', 'President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/jo-taylor-otpp', false, '', 'President and CEO of Ontario Teachers Pension Plan since 2020. Previously Head of International at Ontario Teachers. Leads global investment strategy from Toronto for CAD $247.5B fund.'),
  ('b1c2d3e4-0081-0081-0081-000000000081', 'a1b2c3d4-0053-0053-0053-000000000053', 'Ziad', 'Hindo', 'Chief Investment Officer', '', '', 'https://www.linkedin.com/in/ziad-hindo', false, '', 'Chief Investment Officer of Ontario Teachers Pension Plan. Has been with the fund since 1999. Named CIO in 2019.'),
  ('b1c2d3e4-0082-0082-0082-000000000082', 'a1b2c3d4-0054-0054-0054-000000000054', 'John', 'Graham', 'President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/john-graham-cpp', false, '', 'President and CEO of CPP Investments since 2021. Leads investment of the Canada Pension Plan Fund (CAD $632B) for 21 million Canadians.'),
  ('b1c2d3e4-0083-0083-0083-000000000083', 'a1b2c3d4-0054-0054-0054-000000000054', 'Edwin', 'Cass', 'Chief Investment Officer', '', '', 'https://www.linkedin.com/in/edwin-cass-cpp', false, '', 'Chief Investment Officer of CPP Investments. Has been with the fund since 2007.'),
  ('b1c2d3e4-0084-0084-0084-000000000084', 'a1b2c3d4-0055-0055-0055-000000000055', 'Mario', 'Giannini', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/mario-giannini-hamilton-lane', false, '', 'CEO of Hamilton Lane. Has been with the firm since 1995. Led Hamilton Lane IPO on NASDAQ in 2017 (HLNE).'),
  ('b1c2d3e4-0085-0085-0085-000000000085', 'a1b2c3d4-0055-0055-0055-000000000055', 'Erik', 'Hirsch', 'Vice Chairman', '', '', 'https://www.linkedin.com/in/erik-hirsch-hamilton-lane', false, '', 'Vice Chairman of Hamilton Lane. Has been with the firm since 1999. Previously Chief Investment Officer. Named Vice Chairman in 2019.'),
  ('b1c2d3e4-0086-0086-0086-000000000086', 'a1b2c3d4-0056-0056-0056-000000000056', 'Scott', 'Hart', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/scott-hart-stepstone', false, '', 'CEO of StepStone Group since 2021. Co-founded in 2007. Instrumental in StepStone NASDAQ IPO (STEP) in 2020.'),
  ('b1c2d3e4-0087-0087-0087-000000000087', 'a1b2c3d4-0056-0056-0056-000000000056', 'Jason', 'Ment', 'Managing Partner, President and Chief Operating Officer', '', '', 'https://www.linkedin.com/in/jason-ment-stepstone', false, '', 'Managing Partner, President and COO of StepStone Group. Co-founded 2007. Oversees operations, legal, and compliance. Previously at Credit Suisse Private Equity.'),
  ('b1c2d3e4-0088-0088-0088-000000000088', 'a1b2c3d4-0057-0057-0057-000000000057', 'Brooks', 'Zug', 'Senior Managing Director and Co-Founder', '', '', 'https://www.linkedin.com/in/brooks-zug-harbourvest', false, '', 'Senior Managing Director and Co-Founder of HarbourVest Partners. Co-founded in 1982. Pioneered the private equity fund of funds model.'),
  ('b1c2d3e4-0089-0089-0089-000000000089', 'a1b2c3d4-0057-0057-0057-000000000057', 'John', 'Toomey', 'Managing Director', '', '', 'https://www.linkedin.com/in/john-toomey-harbourvest', false, '', 'Managing Director at HarbourVest Partners. Focuses on US primary fund investments and secondary transactions. Over two decades with HarbourVest.'),
  ('b1c2d3e4-0090-0090-0090-000000000090', 'a1b2c3d4-0058-0058-0058-000000000058', 'Josh', 'Kopelman', 'Founder and Partner', '', '', 'https://www.linkedin.com/in/jkopelman', false, '', 'Founder and Partner of First Round Capital. Founded Half.com (sold to eBay $350M, 2000). Founded First Round Capital in 2004. Early investor in Uber, Square, Warby Parker, and Mint.'),
  ('b1c2d3e4-0091-0091-0091-000000000091', 'a1b2c3d4-0058-0058-0058-000000000058', 'Bill', 'Trenchard', 'Partner', '', '', 'https://www.linkedin.com/in/billtrenchard', false, '', 'Partner at First Round Capital. Previously a founder and operator. Focuses on enterprise software, developer tools, and infrastructure investments.'),
  ('b1c2d3e4-0092-0092-0092-000000000092', 'a1b2c3d4-0059-0059-0059-000000000059', 'Garry', 'Tan', 'President and Chief Executive Officer', '', '', 'https://www.linkedin.com/in/garrytan', false, '', 'President and CEO of Y Combinator since 2023. Previously co-founded Initialized Capital. YC alum (2007) and early investor in Coinbase, Instacart, and Cruise.'),
  ('b1c2d3e4-0093-0093-0093-000000000093', 'a1b2c3d4-0059-0059-0059-000000000059', 'Tom', 'Blomfield', 'Partner', '', '', 'https://www.linkedin.com/in/tomblomfield', false, '', 'Partner at Y Combinator. Founded Monzo Bank in 2015, one of Europe most successful neobanks. Co-founder of GoCardless (YC W11). Joined YC as partner in 2021.'),
  ('b1c2d3e4-0094-0094-0094-000000000094', 'a1b2c3d4-0060-0060-0060-000000000060', 'Josh', 'Wolfe', 'Co-Founder and Managing Partner', '', '', 'https://www.linkedin.com/in/joshwolfe', false, '', 'Co-Founder and Managing Partner of Lux Capital since 2000. Focuses on deep tech including defense, robotics, genomics, and AI.'),
  ('b1c2d3e4-0095-0095-0095-000000000095', 'a1b2c3d4-0060-0060-0060-000000000060', 'Peter', 'Hebert', 'Co-Founder and Managing Partner', '', '', 'https://www.linkedin.com/in/peterhebert', false, '', 'Co-Founder and Managing Partner of Lux Capital since 2000. Focuses on energy, materials science, and life sciences. Previously at Battery Ventures.'),
  ('b1c2d3e4-0096-0096-0096-000000000096', 'a1b2c3d4-0061-0061-0061-000000000061', 'Chow Kiat', 'Lim', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/lim-chow-kiat-gic', false, '', 'Chief Executive Officer of GIC Private Limited since 2017. Has been with GIC since 1993. Oversees Singapore foreign reserve investment in over 40 countries.'),
  ('b1c2d3e4-0097-0097-0097-000000000097', 'a1b2c3d4-0061-0061-0061-000000000061', 'Jeffrey', 'Jaensubhakij', 'Group President and Chief Investment Officer', '', '', 'https://www.linkedin.com/in/jeffrey-jaensubhakij', false, '', 'Group President and CIO of GIC. Has been with GIC since 1997. Leads investment management of $770B+ portfolio.'),
  ('b1c2d3e4-0098-0098-0098-000000000098', 'a1b2c3d4-0062-0062-0062-000000000062', 'Dilhan', 'Pillay', 'Chief Executive Officer', '', '', 'https://www.linkedin.com/in/dilhan-pillay', false, '', 'Chief Executive Officer of Temasek Holdings since 2021. Leads global investment strategy for SGD $389B portfolio.'),
  ('b1c2d3e4-0099-0099-0099-000000000099', 'a1b2c3d4-0062-0062-0062-000000000062', 'Rohit', 'Sipahimalani', 'Chief Investment Officer', '', '', 'https://www.linkedin.com/in/rohit-sipahimalani', false, '', 'Chief Investment Officer of Temasek Holdings. Has been with Temasek since 2007. Oversees portfolio management of SGD $389B portfolio.'),
  ('b1c2d3e4-0100-0100-0100-000000000100', 'a1b2c3d4-0063-0063-0063-000000000063', 'Khaldoon', 'Al Mubarak', 'Managing Director and Group Chief Executive Officer', '', '', 'https://www.linkedin.com/in/khaldoon-al-mubarak', false, '', 'Managing Director and Group CEO of Mubadala Investment Company since 2002. Also Chairman of the Executive Affairs Authority of Abu Dhabi. Leads $302B investment platform.'),
  ('b1c2d3e4-0101-0101-0101-000000000101', 'a1b2c3d4-0063-0063-0063-000000000063', 'Waleed', 'Al Mokarrab Al Muhairi', 'Deputy Group Chief Executive Officer', '', '', 'https://www.linkedin.com/in/waleed-al-muhairi-mubadala', false, '', 'Deputy Group CEO of Mubadala Investment Company. Oversees technology, venture, and international investments.')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, notes = EXCLUDED.notes, updated_at = NOW();

-- funds
INSERT INTO funds (
  id, firm_id, fund_name, vintage_year, fund_size, currency, status, strategy, target_return
) VALUES
  ('c1d2e3f4-0001-0001-0001-000000000001', 'a1b2c3d4-0001-0001-0001-000000000001', 'Sequoia Capital Global Growth Fund III', 2018, 8000000000, 'USD', 'active', 'Series C - Pre-IPO', NULL),
  ('c1d2e3f4-0002-0002-0002-000000000002', 'a1b2c3d4-0001-0001-0001-000000000001', 'Sequoia Capital US Venture Fund XVII', 2020, 808000000, 'USD', 'active', 'Seed - Series B', NULL),
  ('c1d2e3f4-0003-0003-0003-000000000003', 'a1b2c3d4-0002-0002-0002-000000000002', 'a16z Crypto Fund I', 2018, 300000000, 'USD', 'active', 'Seed - Series B', NULL),
  ('c1d2e3f4-0004-0004-0004-000000000004', 'a1b2c3d4-0002-0002-0002-000000000002', 'Andreessen Horowitz Fund IX', 2024, 1250000000, 'USD', 'active', 'Series A - Series D', NULL),
  ('c1d2e3f4-0005-0005-0005-000000000005', 'a1b2c3d4-0003-0003-0003-000000000003', 'Blackstone Capital Partners VIII', 2019, 26000000000, 'USD', 'active', 'Buyout', NULL),
  ('c1d2e3f4-0006-0006-0006-000000000006', 'a1b2c3d4-0004-0004-0004-000000000004', 'KKR North America Fund XIII', 2021, 17749000000, 'USD', 'active', 'Buyout - Growth', NULL),
  ('c1d2e3f4-0007-0007-0007-000000000007', 'a1b2c3d4-0005-0005-0005-000000000005', 'Tiger Global Private Investment Partners XV', 2021, 12700000000, 'USD', 'active', 'Series B - Pre-IPO', NULL),
  ('c1d2e3f4-0008-0008-0008-000000000008', 'a1b2c3d4-0007-0007-0007-000000000007', 'Bridgewater All Weather Fund', 1996, 59000000000, 'USD', 'active', 'Public Markets', NULL),
  ('c1d2e3f4-0009-0009-0009-000000000009', 'a1b2c3d4-0006-0006-0006-000000000006', 'Citadel Wellington Fund', 1990, 45000000000, 'USD', 'active', 'Public Markets', NULL),
  ('c1d2e3f4-0010-0010-0010-000000000010', 'a1b2c3d4-0002-0002-0002-000000000002', 'a16z Bio Fund II', 2020, 450000000, 'USD', 'active', 'Seed - Series C', NULL),
  ('c1d2e3f4-0011-0011-0011-000000000011', 'a1b2c3d4-0020-0020-0020-000000000020', 'Apollo Investment Fund IX', 2017, 24700000000, 'USD', 'active', 'Buyout', NULL),
  ('c1d2e3f4-0012-0012-0012-000000000012', 'a1b2c3d4-0021-0021-0021-000000000021', 'Carlyle Partners VII', 2018, 22000000000, 'USD', 'active', 'Buyout', NULL),
  ('c1d2e3f4-0013-0013-0013-000000000013', 'a1b2c3d4-0022-0022-0022-000000000022', 'TPG Partners IX', 2023, 14800000000, 'USD', 'active', 'Buyout / Growth', NULL),
  ('c1d2e3f4-0014-0014-0014-000000000014', 'a1b2c3d4-0023-0023-0023-000000000023', 'Warburg Pincus Global Growth 14', 2023, 17300000000, 'USD', 'active', 'Growth Equity', NULL),
  ('c1d2e3f4-0015-0015-0015-000000000015', 'a1b2c3d4-0027-0027-0027-000000000027', 'General Catalyst Growth Fund', 2022, 4600000000, 'USD', 'active', 'Series B - Pre-IPO', NULL)
ON CONFLICT (id) DO UPDATE SET fund_size = EXCLUDED.fund_size, updated_at = NOW();

-- deals
INSERT INTO deals (
  id, firm_id, fund_id, deal_name, target_company, deal_type, deal_size, deal_date, stage, sector, status, source_url
) VALUES
  ('d1e2f3a4-0001-0001-0001-000000000001', 'a1b2c3d4-0016-0016-0016-000000000016', NULL, 'Databricks', 'Databricks Inc.', 'venture', 1000000000, '2021-02-01'::date, 'Series G', 'ai', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001813758&owner=exclude&count=40'),
  ('d1e2f3a4-0002-0002-0002-000000000002', 'a1b2c3d4-0002-0002-0002-000000000002', 'c1d2e3f4-0004-0004-0004-000000000004', 'Databricks', 'Databricks Inc.', 'venture', 8589661278, '2024-12-17'::date, 'Series J', 'ai', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001813758&owner=exclude&count=40'),
  ('d1e2f3a4-0003-0003-0003-000000000003', 'a1b2c3d4-0001-0001-0001-000000000001', 'c1d2e3f4-0002-0002-0002-000000000002', 'Stripe', 'Stripe Inc.', 'venture', 600000000, '2021-03-15'::date, 'Series H', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001670148&owner=exclude&count=40'),
  ('d1e2f3a4-0004-0004-0004-000000000004', 'a1b2c3d4-0001-0001-0001-000000000001', 'c1d2e3f4-0001-0001-0001-000000000001', 'Stripe', 'Stripe Inc.', 'venture', 6869866984, '2023-03-15'::date, 'Series I', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001670148&owner=exclude&count=40'),
  ('d1e2f3a4-0005-0005-0005-000000000005', 'a1b2c3d4-0001-0001-0001-000000000001', 'c1d2e3f4-0004-0004-0004-000000000004', 'OpenAI', 'OpenAI Inc.', 'venture', 300000000, '2023-04-28'::date, 'Venture Round', 'ai', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001800397&owner=exclude&count=40'),
  ('d1e2f3a4-0006-0006-0006-000000000006', 'a1b2c3d4-0018-0018-0018-000000000018', 'c1d2e3f4-0007-0007-0007-000000000007', 'Nubank', 'Nu Pagamentos S.A. (Nubank)', 'venture', 750000000, '2021-06-07'::date, 'Series G', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001691493&owner=exclude&count=40'),
  ('d1e2f3a4-0007-0007-0007-000000000007', 'a1b2c3d4-0016-0016-0016-000000000016', NULL, 'Canva', 'Canva Pty Ltd', 'venture', 200000000, '2021-04-08'::date, 'Series F', 'saas', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001863990&owner=exclude&count=40'),
  ('d1e2f3a4-0009-0009-0009-000000000009', 'a1b2c3d4-0005-0005-0005-000000000005', 'c1d2e3f4-0007-0007-0007-000000000007', 'Robinhood', 'Robinhood Markets Inc.', 'venture', 3400000000, '2021-01-29'::date, 'Series G', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001783879&owner=exclude&count=40'),
  ('d1e2f3a4-0010-0010-0010-000000000010', 'a1b2c3d4-0017-0017-0017-000000000017', 'c1d2e3f4-0005-0005-0005-000000000005', 'Klarna', 'Klarna Bank AB', 'venture', 639000000, '2021-07-01'::date, 'Late Stage VC', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001959724&owner=exclude&count=40'),
  ('d1e2f3a4-0011-0011-0011-000000000011', 'a1b2c3d4-0004-0004-0004-000000000004', 'c1d2e3f4-0006-0006-0006-000000000006', 'Cloudera Inc.', 'Cloudera Inc.', 'buyout', 5300000000, '2021-10-08'::date, 'Take-Private', 'cloud', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001660134&owner=exclude&count=40'),
  ('d1e2f3a4-0013-0013-0013-000000000013', 'a1b2c3d4-0002-0002-0002-000000000002', 'c1d2e3f4-0003-0003-0003-000000000003', 'Compound Finance', 'Compound Labs Inc.', 'venture', 25000000, '2019-11-19'::date, 'Series A', 'crypto', 'announced', 'https://compound.finance'),
  ('d1e2f3a4-0014-0014-0014-000000000014', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'DoorDash Inc.', 'DoorDash Inc.', 'ipo', 3366000000, '2020-12-09'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001792789&owner=exclude&count=40'),
  ('d1e2f3a4-0015-0015-0015-000000000015', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Snowflake Inc.', 'Snowflake Inc.', 'ipo', 3360000000, '2020-09-16'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001640147&owner=exclude&count=40'),
  ('d1e2f3a4-0016-0016-0016-000000000016', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Rivian Automotive Inc.', 'Rivian Automotive Inc.', 'ipo', 11934000000, '2021-11-10'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001874178&owner=exclude&count=40'),
  ('d1e2f3a4-0017-0017-0017-000000000017', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Arm Holdings plc', 'Arm Holdings plc', 'ipo', 4870000000, '2023-09-14'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001973239&owner=exclude&count=40'),
  ('d1e2f3a4-0018-0018-0018-000000000018', 'a1b2c3d4-0043-0043-0043-000000000043', NULL, 'Reddit Inc.', 'Reddit Inc.', 'ipo', 748000000, '2024-03-21'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001713445&owner=exclude&count=40'),
  ('d1e2f3a4-0019-0019-0019-000000000019', 'a1b2c3d4-0038-0038-0038-000000000038', NULL, 'Lyft Inc.', 'Lyft Inc.', 'ipo', 2340000000, '2019-03-29'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001759509&owner=exclude&count=40'),
  ('d1e2f3a4-0020-0020-0020-000000000020', 'a1b2c3d4-0043-0043-0043-000000000043', NULL, 'Uber Technologies Inc.', 'Uber Technologies Inc.', 'ipo', 8100000000, '2019-05-10'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001543151&owner=exclude&count=40'),
  ('d1e2f3a4-0021-0021-0021-000000000021', 'a1b2c3d4-0043-0043-0043-000000000043', NULL, 'UiPath Inc.', 'UiPath Inc.', 'ipo', 1340000000, '2021-04-21'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001734722&owner=exclude&count=40'),
  ('d1e2f3a4-0022-0022-0022-000000000022', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Duolingo Inc.', 'Duolingo Inc.', 'ipo', 521000000, '2021-07-28'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001650372&owner=exclude&count=40'),
  ('d1e2f3a4-0023-0023-0023-000000000023', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'GitLab Inc.', 'GitLab Inc.', 'ipo', 801000000, '2021-10-14'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001653482&owner=exclude&count=40'),
  ('d1e2f3a4-0024-0024-0024-000000000024', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Instacart (Maplebear Inc.)', 'Instacart (Maplebear Inc.)', 'ipo', 660000000, '2023-09-19'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001579091&owner=exclude&count=40')
ON CONFLICT (id) DO UPDATE SET deal_size = EXCLUDED.deal_size, fund_id = EXCLUDED.fund_id, updated_at = NOW();


-- =============================================================================
-- Additional firm: U.S. Bancorp (5th bank to meet 5-bank spread requirement)
-- Sources: SEC EDGAR CIK 0000036104 | usbank.com | NYSE: USB
-- Total assets $678.3B per 2024 10-K (filed 2025-02-21)
-- =============================================================================

INSERT INTO firms (
  id, legal_name, firm_name, firm_type, website,
  hq_city, hq_state, hq_country, geography_focus, aum_range,
  check_size_min, check_size_max, stage_preferences, deal_type_preferences, year_founded,
  description, logo_url, crm_status, internal_score, source_links, notes
) VALUES
  ('a1b2c3d4-0064-0064-0064-000000000064', 'U.S. Bancorp', 'U.S. Bank', 'investor', 'https://www.usbank.com', 'Minneapolis', 'MN', 'USA', '["USA"]'::jsonb, '$10B+', NULL, NULL, '[]'::jsonb, '["equity", "debt", "advisory"]'::jsonb, 1863, 'Fifth-largest US commercial bank by assets with $678.3B in total assets as of December 31, 2024 (2024 10-K, CIK 0000036104). NYSE: USB. Founded under national bank charter No. 24 in 1863 during the Lincoln administration. Operates consumer and business banking, payment services, corporate and commercial banking, and wealth management. Completed $8B acquisition of MUFG Union Bank on December 1, 2022.', '', 'active', 90, '["https://www.usbank.com", "https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0000036104&type=&dateb=&owner=exclude&count=40", "https://www.linkedin.com/company/us-bank"]'::jsonb, 'Added to meet 5-bank spread requirement.')
ON CONFLICT (id) DO UPDATE SET
  legal_name = EXCLUDED.legal_name, firm_name = EXCLUDED.firm_name,
  description = EXCLUDED.description, source_links = EXCLUDED.source_links, updated_at = NOW();

INSERT INTO firm_investor_types (firm_id, category_id) VALUES
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM investor_categories WHERE slug = 'banks')),
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM investor_categories WHERE slug = 'investment-banks')),
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM investor_categories WHERE slug = 'institutional-investors'))
ON CONFLICT (firm_id, category_id) DO NOTHING;

INSERT INTO firm_industries (firm_id, industry_id, is_primary) VALUES
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM industry_verticals WHERE slug = 'financial-services'), true),
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM industry_verticals WHERE slug = 'technology'), false),
  ('a1b2c3d4-0064-0064-0064-000000000064', (SELECT id FROM industry_verticals WHERE slug = 'real-estate'), false)
ON CONFLICT (firm_id, industry_id) DO NOTHING;

INSERT INTO contacts (
  id, firm_id, first_name, last_name, title, email, phone, linkedin_url, is_primary, department, notes
) VALUES
  ('b1c2d3e4-0102-0102-0102-000000000102', 'a1b2c3d4-0064-0064-0064-000000000064', 'Gunjan', 'Kedia', 'President and Chief Executive Officer', '', '', '', false, '', 'President and CEO of U.S. Bancorp since April 15, 2025 (effective at the conclusion of the Annual Meeting of Shareholders). Previously served as President. Succeeded Andy Cecere who became Executive Chairman.'),
  ('b1c2d3e4-0103-0103-0103-000000000103', 'a1b2c3d4-0064-0064-0064-000000000064', 'John', 'Stern', 'Senior Executive Vice President and Chief Financial Officer', '', '', '', false, '', 'Senior Executive Vice President and CFO of U.S. Bancorp. Has served as Senior EVP since April 2023 and as CFO since September 2023. Has been with U.S. Bank since 2000. (Source: 2024 10-K, p. 133)')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, notes = EXCLUDED.notes, updated_at = NOW();

-- =============================================================================
-- Additional firm: SV Angel (angel investor #1)
-- Sources: svangel.com | SEC IAPD CRD 162285 / SEC# 802-75165
-- =============================================================================

INSERT INTO firms (
  id, legal_name, firm_name, firm_type, website,
  hq_city, hq_state, hq_country, geography_focus, aum_range,
  check_size_min, check_size_max, stage_preferences, deal_type_preferences, year_founded,
  description, logo_url, crm_status, internal_score, source_links, notes
) VALUES
  ('a1b2c3d4-0065-0065-0065-000000000065', 'SV Angel Management, LLC', 'SV Angel', 'investor', 'https://svangel.com', 'San Francisco', 'CA', 'USA', '["USA"]'::jsonb, '', NULL, NULL, '["seed", "growth"]'::jsonb, '["equity", "convertible"]'::jsonb, 1992, 'Seed and growth-stage angel investment firm founded by Ron Conway in 1992. SEC-registered investment adviser, CRD 162285 / SEC# 802-75165, HQ at 950 Mason Street, San Francisco. Operates a Seed Fund and a Growth Fund. Described on official site as hyper-engaged and founder-focused.', '', 'prospect', 80, '["https://svangel.com", "https://adviserinfo.sec.gov/firm/summary/162285", "https://www.linkedin.com/company/sv-angel"]'::jsonb, 'Angel investor; seed and growth funds. AUM not publicly disclosed.')
ON CONFLICT (id) DO UPDATE SET
  legal_name = EXCLUDED.legal_name, firm_name = EXCLUDED.firm_name,
  description = EXCLUDED.description, source_links = EXCLUDED.source_links, updated_at = NOW();

INSERT INTO firm_investor_types (firm_id, category_id) VALUES
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM investor_categories WHERE slug = 'angel-investors')),
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM investor_categories WHERE slug = 'venture-capital'))
ON CONFLICT (firm_id, category_id) DO NOTHING;

INSERT INTO firm_industries (firm_id, industry_id, is_primary) VALUES
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false),
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM industry_verticals WHERE slug = 'fintech'), false),
  ('a1b2c3d4-0065-0065-0065-000000000065', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false)
ON CONFLICT (firm_id, industry_id) DO NOTHING;

INSERT INTO contacts (
  id, firm_id, first_name, last_name, title, email, phone, linkedin_url, is_primary, department, notes
) VALUES
  ('b1c2d3e4-0104-0104-0104-000000000104', 'a1b2c3d4-0065-0065-0065-000000000065', 'Ron', 'Conway', 'Founder', '', '', '', false, '', 'Founder of SV Angel. Angel investor since 1992. (Source: svangel.com)')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, notes = EXCLUDED.notes, updated_at = NOW();

-- =============================================================================
-- Additional firm: Lerer Hippeau (angel investor #2 / early-stage seed fund)
-- Sources: adviserinfo.sec.gov/firm/summary/162263 | lererhippeau.com
-- CRD 162263 / SEC 802-76405 | Fund IX: $197.7M (SEC Form D)
-- =============================================================================

INSERT INTO firms (
  id, legal_name, firm_name, firm_type, website,
  hq_city, hq_state, hq_country, geography_focus, aum_range,
  check_size_min, check_size_max, stage_preferences, deal_type_preferences, year_founded,
  description, logo_url, crm_status, internal_score, source_links, notes
) VALUES
  ('a1b2c3d4-0066-0066-0066-000000000066', 'Lerer Hippeau Ventures Management, LLC', 'Lerer Hippeau', 'investor', 'https://lererhippeau.com', 'New York', 'NY', 'USA', '["USA"]'::jsonb, '$100M-500M', NULL, NULL, '["seed"]'::jsonb, '["equity", "convertible"]'::jsonb, 2010, 'New York-based early-stage venture and seed investment firm. SEC exempt reporting adviser, CRD 162263 / SEC 802-76405. HQ at 555 Greenwich Street, New York, NY 10014. Founded in 2010. Describes itself as singularly obsessed with finding founders before they are famous. Focuses on pre-seed and seed stage across consumer and enterprise. Most recent fund Lerer Hippeau IX LP closed at $200M (announced April 2025).', '', 'prospect', 75, '["https://lererhippeau.com", "https://adviserinfo.sec.gov/firm/summary/162263", "https://lererhippeau.com/team"]'::jsonb, 'Seed/pre-seed stage fund; tagged angel-investors per category definition overlap at seed stage.')
ON CONFLICT (id) DO UPDATE SET
  legal_name = EXCLUDED.legal_name, firm_name = EXCLUDED.firm_name,
  description = EXCLUDED.description, source_links = EXCLUDED.source_links, updated_at = NOW();

INSERT INTO firm_investor_types (firm_id, category_id) VALUES
  ('a1b2c3d4-0066-0066-0066-000000000066', (SELECT id FROM investor_categories WHERE slug = 'angel-investors')),
  ('a1b2c3d4-0066-0066-0066-000000000066', (SELECT id FROM investor_categories WHERE slug = 'venture-capital'))
ON CONFLICT (firm_id, category_id) DO NOTHING;

INSERT INTO firm_industries (firm_id, industry_id, is_primary) VALUES
  ('a1b2c3d4-0066-0066-0066-000000000066', (SELECT id FROM industry_verticals WHERE slug = 'technology'), true),
  ('a1b2c3d4-0066-0066-0066-000000000066', (SELECT id FROM industry_verticals WHERE slug = 'consumer'), false),
  ('a1b2c3d4-0066-0066-0066-000000000066', (SELECT id FROM industry_verticals WHERE slug = 'software-saas'), false)
ON CONFLICT (firm_id, industry_id) DO NOTHING;

INSERT INTO contacts (
  id, firm_id, first_name, last_name, title, email, phone, linkedin_url, is_primary, department, notes
) VALUES
  ('b1c2d3e4-0105-0105-0105-000000000105', 'a1b2c3d4-0066-0066-0066-000000000066', 'Ben', 'Lerer', 'Managing Partner', '', '', '', false, '', 'Managing Partner of Lerer Hippeau since the firm''s founding in 2010. (Source: lererhippeau.com/team)'),
  ('b1c2d3e4-0106-0106-0106-000000000106', 'a1b2c3d4-0066-0066-0066-000000000066', 'Eric', 'Hippeau', 'Managing Partner', '', '', '', false, '', 'Managing Partner of Lerer Hippeau since the firm''s founding in 2010. (Source: lererhippeau.com/team)')
ON CONFLICT (id) DO UPDATE SET title = EXCLUDED.title, notes = EXCLUDED.notes, updated_at = NOW();

-- =============================================================================
-- Additional deals (to reach 30+ total)
-- Sources: SEC EDGAR 424B4 filings, Form D filings, official press releases
-- =============================================================================

INSERT INTO deals (
  id, firm_id, fund_id, deal_name, target_company, deal_type, deal_size, deal_date, stage, sector, status, source_url
) VALUES
  -- Airbnb IPO: Goldman Sachs co-lead bookrunner. 424B4 filed 2020-12-10, CIK 0001559720.
  -- Gross proceeds incl. overallotment: $3.74B (51,282,051 primary + 6,912,000 overallotment shares at $68)
  ('d1e2f3a4-0025-0025-0025-000000000025', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Airbnb Inc.', 'Airbnb Inc.', 'ipo', 3740000000, '2020-12-10'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001559720&owner=exclude&count=40'),
  -- Peloton IPO: Goldman Sachs co-lead bookrunner. 424B4 filed 2019-09-25, CIK 0001639825.
  -- Gross proceeds incl. overallotment: $1.16B (40,000,000 primary + 6,000,000 overallotment shares at $29)
  ('d1e2f3a4-0026-0026-0026-000000000026', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Peloton Interactive Inc.', 'Peloton Interactive Inc.', 'ipo', 1160000000, '2019-09-25'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001639825&owner=exclude&count=40'),
  -- Toast IPO: Goldman Sachs lead bookrunner. 424B4 filed 2021-09-21, CIK 0001650164.
  -- Gross proceeds incl. overallotment: ~$1.0B (21,750,000 primary + 3,262,500 overallotment shares at $40)
  ('d1e2f3a4-0027-0027-0027-000000000027', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Toast Inc.', 'Toast Inc.', 'ipo', 1000000000, '2021-09-21'::date, 'IPO', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001650164&owner=exclude&count=40'),
  -- Roblox direct listing: Morgan Stanley exclusive financial advisor. NYSE listing 2021-03-10, CIK 0001315098.
  -- Direct listing: no primary shares sold; $0 proceeds to company.
  ('d1e2f3a4-0028-0028-0028-000000000028', 'a1b2c3d4-0043-0043-0043-000000000043', NULL, 'Roblox Corporation', 'Roblox Corporation', 'direct-listing', NULL, '2021-03-10'::date, 'Direct Listing', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001315098&owner=exclude&count=40'),
  -- Palantir direct listing: Morgan Stanley exclusive financial advisor. NYSE listing 2020-09-30, CIK 0001321655.
  -- Direct listing: no primary shares sold; $0 proceeds to company.
  ('d1e2f3a4-0029-0029-0029-000000000029', 'a1b2c3d4-0043-0043-0043-000000000043', NULL, 'Palantir Technologies Inc.', 'Palantir Technologies Inc.', 'direct-listing', NULL, '2020-09-30'::date, 'Direct Listing', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001321655&owner=exclude&count=40'),
  -- Figma Series D: Andreessen Horowitz (a16z) led $200M round. SEC Form D CIK 0001579878, filed 2021-07-01 (closing date 2021-06-23).
  ('d1e2f3a4-0030-0030-0030-000000000030', 'a1b2c3d4-0002-0002-0002-000000000002', NULL, 'Figma Inc.', 'Figma Inc.', 'venture', 200000000, '2021-06-23'::date, 'Series D', 'technology', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001579878&owner=exclude&count=40'),
  -- Ancestry take-private: Blackstone acquired Ancestry.com for $4.7B. Completed 2020-12-04 per Blackstone press release.
  ('d1e2f3a4-0031-0031-0031-000000000031', 'a1b2c3d4-0003-0003-0003-000000000003', NULL, 'Ancestry.com', 'Ancestry.com Operations LLC', 'buyout', 4700000000, '2020-12-04'::date, 'Take-Private', 'technology', 'closed', 'https://www.blackstone.com/press-releases/article/blackstone-completes-acquisition-of-ancestry/'),
  -- Coinbase direct listing: Goldman Sachs lead financial advisor. Nasdaq listing 2021-04-14, CIK 0001679788.
  -- Direct listing: no primary shares sold; $0 proceeds to company.
  ('d1e2f3a4-0032-0032-0032-000000000032', 'a1b2c3d4-0039-0039-0039-000000000039', NULL, 'Coinbase Global Inc.', 'Coinbase Global Inc.', 'direct-listing', NULL, '2021-04-14'::date, 'Direct Listing', 'fintech', 'announced', 'https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001679788&owner=exclude&count=40')
ON CONFLICT (id) DO UPDATE SET deal_size = EXCLUDED.deal_size, fund_id = EXCLUDED.fund_id, updated_at = NOW();

COMMIT;
