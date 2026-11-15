---
name: design-a-screen
description: "Wear this before building or changing anything with a screen: a window, a view, a dialog, a form, a dashboard, a front-end component. Reads the core build-software-base first. Sets which standard applies, the states every view owes, and the rule that a design cannot be judged from source. Use when writing UI code or laying out a data-heavy view."
---

# Design a screen

**First, read the core `build-software-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what all software built with this kit shares: the order of authority (the contracts, best practice, the house voice), read the code first, scope is the deliverable, invented data, never production or a real cloud account and builders laptop only, a refusal ends the step, prove both directions, never report a pass you did not watch, the reporting clause, and how a commit is made. Do not wear `build-software-base` beside this skill; read its file. What follows is this skill's own.

**The rule that outranks everything else here: a design cannot be reviewed from source.** A page that scrolls sideways with a third card cut in half, an empty-state sentence clipped at both ends, three hundred pixels of card reserved to say *not yet*, and `$-101,000` where money reads with a real minus sign are none of them visible in code, and all of them are obvious in the image.

**Render it and look at it before calling it done.** Where no screenshot tool is available, the application can draw itself: build the window under the real application so the stylesheet loads, render it to an image, save a PNG, and read the image back. Kill any running instance first or a single-instance app swallows the activation.

## First: which standard applies

**A design system binds only a repository that has adopted it**, meaning a design-tokens file and a written rules file sit at its root. **Check, do not assume.**

- **Adopted.** Read the rules file; every rule in it binds. Read the tokens file; every visual value comes from there and no literal hex, px or ms appears in app code. If the system has a separate note for web front-ends, it is a delta, not a replacement. Read the longer design guide only when a rule surprises you.
- **Not adopted.** **The system does not apply and you may not bring an app into line with it unless the person you work for asks for that as the task.** Follow the screen's own neighbours, and the universal questions below. Starting a *new* app from the reference is the intended use; reaching into an existing one is not.

**Precedence when rules conflict:** do no harm, then usability, then consistency, then polish. Break a rule if the screen genuinely needs it and write down why.

## Every state, not just the happy one

For every view that loads data, decide all four **before** writing the success path, because retrofitting them is how they end up missing:

1. **Before the data arrives.** What is on screen, and does the layout hold its shape so nothing jumps when it fills?
2. **Empty.** And it says **why** it is empty. **An absence has to be visible**: a control that silently disappears cannot be told apart from a feature that does not exist.
3. **Failed.** What went wrong in words the person can act on, and a way to retry.
4. **Far more data than anyone imagined.** Does it page, scroll, or fall over?

## The reader's work is the measure

**If the reader has to do arithmetic, build a scale, or hold numbers in their head, the layout has not finished its job.** Two numbers side by side asking for a division become one proportional bar. A figure judged against a range gets the range drawn, with a marker on it.

**Colour carries meaning, never identity.** Six decorative accents on one screen teach the reader that colour is decoration, and then the card that needs to shout cannot. **Never information by colour alone**: pair it with an icon or a word.

**Say a thing once.** A label repeated in the heading, the axis and the tooltip is noise.

**Words are part of the interface.** Sentence case everywhere. Verb-first buttons. One term per concept for the life of the app. No *successfully*, no *please*, no *Oops*, no exclamation mark, and never a raw exception string.

**Numbers**: locale decides format, a real minus sign rather than a hyphen, a non-breaking space between a figure and its unit, right-aligned on tabular figures.

## Access, built in rather than retrofitted

A visible focus ring on everything focusable, never removed. Tab order matching visual order, and everything reachable by mouse reachable by keyboard. A label bound to every input. Body text at 4.5:1 and interactive boundaries at 3:1, **verified rather than estimated**. Targets at least 24px, or 44px on touch. `prefers-reduced-motion` kills transforms.

## Harm before polish

Nothing optional defaults to on. Consent is opt-in and its buttons carry identical weight. Secrets go in the OS keyring, never a config file. No network call the person did not ask for. No log containing credentials, tokens, file contents or a home directory path. **Prefer undo over a confirmation**, and confirm only what genuinely cannot be undone, naming the object.

## Before you call it done

- You **rendered it and looked**, at the real window size, light and dark.
- All four states exist and you have seen each one.
- Every visual value comes from the tokens, if the repo adopted them.
- A keyboard-only pass, and 100%, 125% and 200% scaling.

**Taste is another skill.** For how it should look (a direction drawn from the subject, typefaces chosen on purpose, the defaults that read as generated, interface wording), wear a visual design skill, such as Anthropic's `frontend-design` from github.com/anthropics/skills. It aims for a distinctive look; on a tool or a dashboard, usability comes first, and where a repository adopted a design system, the system wins.

**The review half is two separate agents.** `review-ui` checks the states and `review-accessibility` checks the barriers, and **neither can judge appearance from source either**. They will name the renders that need a human eye. This skill is what you wear so there is less for them to find.
