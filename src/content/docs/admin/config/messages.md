---
title: Messages
description: Admin → Messages — the banner, announcement emails, what people read at the door, and the email they get when approved.
---

**Admin → Messages** holds what Garth says to people: a banner for everyone
inside, announcement emails, the messages at the door, and the email someone
gets when they are approved.

## Announcement

A banner across the top of every page, for everyone signed in.

- **Show the announcement** — the switch.
- **Tone** — **Information** (news, nothing to do), **Heads-up** (something
  to plan for) or **Problem** (something is broken now).
- **Hide after** — an optional date after which it disappears on its own.

A **Preview** shows it as people will see it.

## Announcement emails

An email to everyone with an account, or to the administrators: news,
maintenance, a change to know about. Sending needs
[email](../email-and-slack/#email) set up; drafts can be written without it.

### Writing one

| Field | What it is |
|---|---|
| **Subject** | One line, at most 200 characters |
| **Message** | Plain text, at most 10,000 characters |
| **Link** | Optional: an `https://` address to read more, printed under the message |
| **Link text** | Optional: what the link is, as in "Status page" |
| **Audience** | **Everyone** or **Administrators** |

Under the audience, the page counts who will get it, and who is skipped:
people who are suspended or have no email address.

The email ends by saying why the person is getting it, and who sent it — see
[Email and Slack](../email-and-slack/#email).

- **Save draft** — keep it for later. A draft can be deleted.
- **Send me a test** — sends it to your own address only.
- **Send…** — after a confirmation. The recipients are fixed at that moment.
  It can't be taken back.

### After sending

A sent announcement keeps a record, one row per recipient:

| Status | What happened |
|---|---|
| **Delivered** | The email was sent |
| **Failed** | It failed after retries |
| **Skipped** | Suspended, no email address, or the account was removed |
| **Interrupted** | Garth restarted during the send |

- **Send again** — sends it to those it failed for or was interrupted for.
- **Copy to a new draft** — start a new announcement from this one.

What was sent stays on record and can't be deleted.

## At the door

| Message | Shown |
|---|---|
| **Waiting for approval** | To someone who signed in while new accounts need approval |
| **Not invited** | At sign-in, to someone without an invitation while Garth is invite only |
| **Suspended (locked)** | At sign-in, to someone an administrator suspended |

Each has a **Preview** that opens the sign-in page as that person sees it.
See [Who can join](../../identity/who-can-join/).

## Approved

Emailed to someone when an administrator approves them, with a link to sign
in. It is sent only when email is set up and they have an address.

Each message has a sensible default and can be up to 4,000 characters.
