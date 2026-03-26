# Email System - Setup and Documentation

## Overview

This project uses the Resend SDK to send transactional emails triggered by user management actions in the dashboard. This document covers the current setup and how to add new email types.

---

## Current Setup (Resend)

### What is Resend?

Resend is a developer-friendly email delivery platform. Unlike Mailtrap which only catches emails for testing, Resend delivers real emails to real inboxes. It is used for both testing and production.

### Files

    server/
    lib/
        email.js - Resend config and 4 send functions
    emails/
        signup-approved.html
        signup-denied.html
        password-reset.html
        security-alert.html

### Environment Variables

Add these to your .env file:

    RESEND_API_KEY=your_resend_api_key_here
    RESEND_FROM=onboarding@resend.dev

### Getting Resend Credentials

1. Go to resend.com and create a free account
2. Go to API Keys in the left sidebar
3. Click Create API Key and name it liquidity-ai
4. Copy the key that starts with re_
5. Add it to your .env file as RESEND_API_KEY
6. Use onboarding@resend.dev as RESEND_FROM until domain is verified

---

## Email Triggers

| User Action | Function Called | Template Used |
|---|---|---|
| Admin approves a user | sendSignupApproved(email, name) | signup-approved.html |
| Admin denies a user | sendSignupDenied(email, name, reason) | signup-denied.html |
| Admin force resets password | sendPasswordReset(email, name, resetLink) | password-reset.html |
| 5 failed login attempts | sendSecurityAlert(email, name, details) | security-alert.html |

### Where they are wired in

- server/routes/userRoutes.js - approve, deny, and force-reset routes
- server/routes/authRoutes.js - account lockout route

---

## How the Template System Works

Templates use double curly brace placeholder syntax for dynamic values. Example:

    Hi {{name}},

The fillTemplate() function in email.js loops through the variables object and replaces each placeholder with the real value before the email is sent.

---

## Testing Emails Individually

Run these commands one at a time from the project root:

Test signup approved:

    node -e "import('./server/lib/email.js').then(m => m.sendSignupApproved('your@email.com', 'Test User').then(() => console.log('sent')).catch(console.error))"

Test signup denied:

    node -e "import('./server/lib/email.js').then(m => m.sendSignupDenied('your@email.com', 'Test User', 'Incomplete documentation').then(() => console.log('sent')).catch(console.error))"

Test password reset:

    node -e "import('./server/lib/email.js').then(m => m.sendPasswordReset('your@email.com', 'Test User', 'http://localhost:5173/reset?token=abc123').then(() => console.log('sent')).catch(console.error))"

Test security alert:

    node -e "import('./server/lib/email.js').then(m => m.sendSecurityAlert('your@email.com', 'Test User', 'Login from unknown IP 192.168.1.1').then(() => console.log('sent')).catch(console.error))"

Note: Replace your@email.com with your real email address. Resend will deliver to your actual inbox.

---

## Adding a New Email Type

Step 1 - Create the HTML template in server/emails/ using double curly brace placeholders for dynamic values.

Step 2 - Add a send function in server/lib/email.js following this pattern:

    export async function sendMyNewEmail(to, name) {
      const html = fillTemplate(loadTemplate('my-new-email'), { name });
      return sendEmail({ to, subject: 'Your subject here', html, template: 'my-new-email' });
    }

Step 3 - Import and call it in the relevant route file using .catch() to avoid breaking the API response if email fails.

---

## Email Logging

Every email sent or failed is automatically recorded in the email_log table in the database.

The table stores:

- id - unique record ID
- to_address - recipient email
- subject - email subject line
- template - which template was used
- status - either sent or failed
- error - error message if failed, null if successful
- sent_at - timestamp of when it was attempted

To query the log directly:

    node -e "import('./server/db.js').then(m => { const logs = m.db.prepare('SELECT * FROM email_log ORDER BY sent_at DESC').all(); console.log(JSON.stringify(logs, null, 2)); })"

---

## Domain Verification (For Production)

Currently using onboarding@resend.dev as the sending address which works for testing. To send from your own domain in production:

1. Go to resend.com and click Domains in the sidebar
2. Click Add Domain and enter your domain
3. Add the DNS records Resend provides to your domain registrar
4. Wait for verification then update RESEND_FROM in .env to noreilly@yourdomain.com

---

## Important Notes for Developers

### .env is gitignored

The .env file is never committed to GitHub. Each developer needs their own .env file with their own Resend API key. See .env.example for the required variables.

### Emails fail silently

Email sending uses .catch() instead of await so a failed email never breaks the main API response. Errors are logged to the server console and recorded in the email_log table.
