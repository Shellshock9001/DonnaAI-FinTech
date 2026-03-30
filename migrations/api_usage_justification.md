# API Usage Justification Document

## Overview

This document explains why API keys are required, what each API is used for, and the limitations we face without them.

The goal of this project is to build a real and verifiable dataset of firms, contacts, funds, and deals using authoritative sources. Collecting this data at scale is not practical through manual browsing alone, so APIs are used to make the process efficient and consistent.


## Why API Keys Are Required

APIs are important because they enable:

1. **Efficient data collection**
   - Automates the process of finding and retrieving information
   - Reduces manual effort significantly

2. **Structured data access**
   - APIs return clean, machine-readable data (JSON)
   - Minimizes parsing errors compared to raw web pages

3. **Scalability**
   - Allows collecting large amounts of data quickly
   - Helps meet dataset requirements within time constraints

4. **Repeatability**
   - Queries can be re-run to regenerate or validate data
   - Useful for debugging and updates


## APIs Used in This Project

### 1. Tavily API

**Purpose:**
- Discover relevant and authoritative sources such as firm websites and press releases

**Why it is needed:**
- Helps identify valid sources before extracting data
- Reduces noise from irrelevant search results

**Without Tavily:**
- Source discovery becomes manual and time-consuming
- Higher chance of missing relevant firms or deals


### 2. SEC EDGAR (Public Data Source)

**Purpose:**
- Verify firm legitimacy
- Retrieve legal names and filings

**Why it is needed:**
- Ensures that all firms in the dataset are real and verifiable
- Acts as a reliable validation layer

**Without it:**
- Difficult to confirm whether firms are legitimate
- Higher risk of incorrect or incomplete data


### 3. Apify API

**Purpose:**
- Automate data extraction from firm websites, regulatory pages, and press releases at scale

**Why it is needed:**
- Allows structured scraping of web pages that do not have a public API
- Extracts contact information, fund details, and deal data from official sources
- Handles pagination and dynamic content that cannot be accessed through simple HTTP requests

**Without Apify:**
- Web extraction must be done manually page by page
- Significantly slower to collect firm and contact data at scale
- No reliable way to automate extraction from sites like FINRA BrokerCheck or firm team pages


### 4. Optional APIs (If Available)

#### PitchBook / Crunchbase

**Purpose:**
- Provide additional data on deals, funds, and investors

**Without them:**
- Limited visibility into deal activity
- Harder to meet deal coverage requirements

#### LinkedIn (if permitted)

**Purpose:**
- Identify professionals and roles

**Without it:**
- Contacts must be sourced only from company websites
- Slower and more limited coverage


## Example Workflow

1. Use Tavily API to find a firm's official website
2. Verify the firm using SEC EDGAR
3. Extract firm details such as name, location, and focus
4. Identify contacts from the firm website
5. Collect deal or fund information from press releases or filings

This process ensures that all data is based on real and verifiable sources.


## Problems Without API Access

- **Incomplete dataset:** Difficult to reach required counts for firms, contacts, and deals
- **Slower data collection:** Manual research significantly increases the time required
- **Inconsistent data quality:** Higher risk of missing or incorrectly formatted data
- **Limited automation:** Hard to reproduce or validate results


## Current Limitations

We are currently experiencing Tavily API rate limits and credit constraints, along with limited access to enrichment APIs.

**Impact:**
- Reduced deal and fund coverage
- Slower contact extraction
- Some manual data collection required


## Mitigation Strategy

- Prioritize authoritative sources including SEC EDGAR, official company websites, and regulatory databases
- Use APIs mainly for discovery, not bulk extraction
- Manually verify and fill gaps when necessary
- Avoid generating any synthetic or unverified data


## Conclusion

API keys are important for improving efficiency, data accuracy, scalability, and consistency. Without them, the project becomes slower, less reliable, and harder to scale.

Even with current limitations, combining APIs with trusted sources and manual validation ensures the dataset remains accurate, verifiable, and suitable for submission.
