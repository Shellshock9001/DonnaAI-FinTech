import { Resend } from 'resend';
import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';
import { v4 as uuidv4 } from 'uuid';
import dotenv from 'dotenv';
dotenv.config();

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const resend = new Resend(process.env.RESEND_API_KEY);

function loadTemplate(templateName) {
  const filePath = path.join(__dirname, '..', 'emails', `${templateName}.html`);
  return fs.readFileSync(filePath, 'utf-8');
}

function fillTemplate(html, variables) {
  let result = html;
  for (const [key, value] of Object.entries(variables)) {
    result = result.replaceAll(`{{${key}}}`, value);
  }
  return result;
}

async function logEmail(to, subject, template, status, error = null) {
  const { db } = await import('../db.js');
  db.prepare(`
    INSERT INTO email_log (id, to_address, subject, template, status, error)
    VALUES (?, ?, ?, ?, ?, ?)
  `).run(uuidv4(), to, subject, template, status, error);
}

async function sendEmail({ to, subject, html, template }) {
  try {
    const { data, error } = await resend.emails.send({
      from: process.env.RESEND_FROM,
      to,
      subject,
      html,
    });
    if (error) throw new Error(error.message);
    await logEmail(to, subject, template || 'unknown', 'sent');
    return data;
  } catch (err) {
    await logEmail(to, subject, template || 'unknown', 'failed', err.message);
    throw err;
  }
}

export async function sendSignupApproved(to, name) {
  const html = fillTemplate(loadTemplate('signup-approved'), { name });
  return sendEmail({ to, subject: 'Your Liquidity.ai account is approved!', html, template: 'signup-approved' });
}

export async function sendSignupDenied(to, name, reason) {
  const html = fillTemplate(loadTemplate('signup-denied'), { name, reason });
  return sendEmail({ to, subject: 'Your Liquidity.ai application was not approved', html, template: 'signup-denied' });
}

export async function sendPasswordReset(to, name, resetLink) {
  const html = fillTemplate(loadTemplate('password-reset'), { name, resetLink });
  return sendEmail({ to, subject: 'Reset your Liquidity.ai password', html, template: 'password-reset' });
}

export async function sendSecurityAlert(to, name, details) {
  const html = fillTemplate(loadTemplate('security-alert'), { name, details });
  return sendEmail({ to, subject: '⚠️ Security Alert — Liquidity.ai!', html, template: 'security-alert' });
}