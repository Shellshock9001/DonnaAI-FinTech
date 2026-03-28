# Email Notifications Feature — Detailed Changes

## Overview

This document provides a detailed breakdown of all changes made for the
Email Notifications feature (Phase 5 Task). This feature adds a complete
transactional email system to the Liquidity.ai dashboard using the Resend SDK.

---

## Files Created

### server/lib/email.js
Core email module containing:
- Resend SDK client configured via RESEND_API_KEY environment variable
- loadTemplate() — reads HTML files from server/emails/ folder
- fillTemplate() — replaces double curly brace placeholders with real values
- logEmail() — records every email attempt to the email_log database table
- sendEmail() — core send function with built-in success and failure logging
- sendSignupApproved(to, name)
- sendSignupDenied(to, name, reason)
- sendPasswordReset(to, name, resetLink)
- sendSecurityAlert(to, name, details)

### server/emails/signup-approved.html
Sent when admin approves a new user account.
Dynamic values: name
Trigger: Admin clicks Approve in Settings > Approvals

### server/emails/signup-denied.html
Sent when admin denies a new user account.
Dynamic values: name, reason
Trigger: Admin clicks Deny in Settings > Approvals

### server/emails/password-reset.html
Sent when admin force resets a users password.
Dynamic values: name, resetLink
Trigger: Admin clicks Force Reset in Settings > Team

### server/emails/security-alert.html
Sent after 5 consecutive failed login attempts.
Dynamic values: name, details
Trigger: 5 failed login attempts on any account

### server/EMAIL_SETUP.md
Full developer documentation covering Resend setup, credentials,
email trigger reference table, template system, testing commands,
how to add new email types, domain verification steps, and email
logging query instructions.

---

## Files Modified

### server/db.js
Added email_log table to the database schema:

    CREATE TABLE IF NOT EXISTS email_log (
      id TEXT PRIMARY KEY,
      to_address TEXT NOT NULL,
      subject TEXT NOT NULL,
      template TEXT NOT NULL,
      status TEXT NOT NULL DEFAULT sent,
      error TEXT DEFAULT NULL,
      sent_at TEXT NOT NULL DEFAULT (datetime(now))
    );

### server/routes/userRoutes.js
Added email triggers to three existing routes:

1. PATCH /:id/approve
   Added sendSignupApproved() after user is approved
   Uses target.email and target.display_name from the database

2. PATCH /:id/deny
   Added sendSignupDenied() after user is denied
   Passes denial reason to the email template

3. PATCH /:id/force-reset
   Added sendPasswordReset() after password reset is flagged

### server/routes/authRoutes.js
Added sendSecurityAlert() to the ACCOUNT_LOCKED event.
Fires after 5 consecutive failed login attempts.
Passes the users IP address as the alert details.

### .env.example
Replaced Mailtrap variables with Resend variables:

    RESEND_API_KEY=your_resend_api_key_here
    RESEND_FROM=onboarding@resend.dev

---

## Email Triggers

| User Action | Function | Template |
|---|---|---|
| Admin approves user | sendSignupApproved() | signup-approved.html |
| Admin denies user | sendSignupDenied() | signup-denied.html |
| Admin force resets password | sendPasswordReset() | password-reset.html |
| 5 failed login attempts | sendSecurityAlert() | security-alert.html |

---

## How Email Logging Works

Every email attempt is recorded in the email_log table regardless
of whether it succeeded or failed.

Success flow:
1. sendEmail() calls resend.emails.send()
2. On success inserts record with status sent and error null
3. API responds normally

Failure flow:
1. sendEmail() calls resend.emails.send()
2. On failure inserts record with status failed and error message
3. Error is re-thrown but caught by .catch() in the route
4. API responds normally — email failure never crashes the server

---

## Design Decisions

### Why .catch() instead of await for email calls in routes
Email is a side effect of the main action. If an email fails the
user approval or denial should still succeed. Using .catch() lets
the email fail silently while the API responds immediately.

### Why inline CSS in templates
Email clients like Gmail, Outlook, and Apple Mail strip external
stylesheets and style tags. Inline CSS is the only reliable way
to style emails consistently across all platforms.

### Why Resend SDK instead of Nodemailer
Resend handles delivery, retries, and reputation management.
It delivers to real inboxes unlike Mailtrap which only catches
emails in a sandbox. Switching providers only requires changing
environment variables — zero code changes needed.

---

## Testing

All 4 templates tested and confirmed delivered to real Gmail inbox:
- signup-approved email confirmed in Gmail
- signup-denied email confirmed in Gmail
- password-reset email confirmed in Gmail
- security-alert email confirmed in Gmail
- Email logging verified for both sent and failed emails
- Graceful error handling verified — API never crashes on email failure

---

## What is Still Pending

- Domain verification via Resend for custom sending domain
- Cross-client rendering tests in Outlook and Apple Mail
- Real reset token generation for password reset link

## Password Reset Token (Added)

### server/db.js
Added password_reset_tokens table:

    CREATE TABLE IF NOT EXISTS password_reset_tokens (
      id TEXT PRIMARY KEY,
      user_id TEXT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
      token_hash TEXT NOT NULL,
      expires_at TEXT NOT NULL,
      used INTEGER DEFAULT 0,
      created_at TEXT NOT NULL DEFAULT (datetime(now))
    );

Added 3 new queries: createResetToken, getResetToken, markResetTokenUsed

### server/routes/userRoutes.js
Updated PATCH /:id/force-reset to:
- Generate secure random token using crypto.randomBytes(32)
- Hash token with SHA-256 before storing
- Store token in password_reset_tokens table with 15 min expiry
- Build reset link using FRONTEND_URL environment variable
- Send real reset link in password reset email

### server/routes/authRoutes.js
Added POST /api/auth/reset-password route:
- Accepts token and newPassword from request body
- Hashes token and looks it up in database
- Validates token is unused and not expired
- Enforces password complexity rules
- Updates user password and marks token as used
- Logs audit event

### src/pages/ResetPasswordPage.jsx (New File)
New frontend page that:
- Reads token from URL query parameter
- Shows password and confirm password fields
- Calls POST /api/auth/reset-password
- Shows success message and redirects to login
- Styled to match dashboard dark theme

### src/App.jsx
Added check for reset password route:
- Detects token in URL query params
- Renders ResetPasswordPage before auth check
- Allows unauthenticated users to reset password
