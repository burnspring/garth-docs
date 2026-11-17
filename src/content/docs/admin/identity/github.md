---
title: Sign in with GitHub
description: Let people sign in with their GitHub account on Admin → Sign-in, beside single sign-on and the local administrator.
---

People can sign in with their GitHub account. It suits an install without an
identity provider of its own. It is set up on **Admin → Sign-in**, under
**Sign in with GitHub**, and works beside [single sign-on](../single-sign-on/)
and [the local administrator](../local-administrator/).

## Register Garth

Register an OAuth app on GitHub (**Settings → Developer settings → OAuth
Apps**). Use the **Authorization callback URL** the page shows:

```text
https://garth.example.com/auth/github/callback
```

It is built from the address you opened the page at, so open it at Garth's
public address before you copy it.

Garth asks GitHub only for the person's profile and email addresses, nothing
of their repositories.

## Sign in with GitHub

| Field | What it is |
|---|---|
| **Client ID** | From the OAuth app's page |
| **Client secret** | Generate one on the OAuth app's page. Stored encrypted and never shown again. Leave blank to keep the stored one |

Press **Save**. The badge reads **Not set up**, **Off** or **On**.

## Switch on

**Show "Continue with GitHub"** puts the button on the sign-in page, beside
any other way in. It can be turned on only after the client ID and secret are
saved.

## Who someone is

- Their username in Garth comes from their GitHub login. Usernames can't
  change later.
- Their GitHub account is who they are. Renaming the login on GitHub doesn't
  change their account in Garth.
- Only a primary email GitHub has verified matches an
  [invitation](../who-can-join/#invitations).

## Who gets in

Anyone with a GitHub account can sign in, so
[Who can join](../who-can-join/) decides who gets in. With **Approval**, a
newcomer waits in the queue on People. Their place in it is bound to their
GitHub account: they come back to it, and nobody else can sign in to it.
