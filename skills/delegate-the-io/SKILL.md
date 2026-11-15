---
name: delegate-the-io
description: Wear this before reading a large corpus. A whole directory, a long file, an unfamiliar tree, or a question that means opening a dozen files to answer. Reads the core evidence-base first. Decides whether to read it here or hand it to the bulk-reader worker, and names what is never delegated. Use when a task starts by asking what is in something, where something is used, or to summarise a set of files.
---

# Delegate the reading

**First, read the core `evidence-base`, whole**: its `core.md` is in the skill folder of that name, beside this one. It holds what every read, brief and piece of research shares: read the source not what points at it, established means confirmed, a gap is a result, how a page is fetched and a blocked one handed over, a refusal ends the step, and the places never read unless named. Do not wear `evidence-base` beside this skill; read its file. What follows is this skill's own.

Most of what a session spends is not thinking. It is carrying files.

A file read directly is paid for twice: once on the way in, and then again on every single turn that follows, because it stays in the context. Read a 4,000 line file on turn three of a thirty turn session and you have paid for it twenty-seven more times. **That carrying is the larger half of the bill, and it is invisible**, because nothing in the transcript shows it.

`bulk-reader` removes the carrying. It reads the corpus in its own context, returns bullets, and its context is thrown away. **The saving is not mostly the price gap between the models. It is that the file never arrives here.**

## When to reach for it without being told

Four shapes, and you will meet all four in a normal week:

- **"What is in this directory?"** An unfamiliar tree, a vendor package, a config sprawl. You want an inventory, not the files.
- **"Where is this used?"** A trace across a codebase. The search results are as expensive as the reads, and they do not need to be here either.
- **"Does this document still match the code?"** A comparison between two large things, where the answer is a short list of disagreements.
- **"Summarise these twelve files."** Anything where the output is an order of magnitude smaller than the input.

The rough floor is **32 KB, about 8,000 tokens**. Below it the worker's own startup overhead eats the saving and you have spent thirty seconds to break even.

**The floor moves with the session.** A file carried for three turns costs almost nothing; the same file on turn two of a long session costs a great deal. Early in a long session, delegate sooner than the number says.

## When to read it here instead

- **You are about to edit it.** An edit needs real line numbers, and the worker's bullets are a pointer rather than a coordinate. Read the section directly, with an offset and a limit.
- **You already know where the answer is.** `grep`, or `sed -n '<a>,<b>p'`. A targeted read is cheaper than a worker and faster.
- **The wording matters.** A contract, a decision, a person's own prose. A summary of a thing whose value is its exact phrasing has thrown away the thing.
- **The corpus is small.** Below the floor, just read it.

## What is never delegated

**Personal folders, and the folders that hold credentials, keys and certificates.** By the core's rule, delegating a read does not launder it, and nothing there is opened unless the task named that file, or you named it and the person you work for agreed, before the read. **A worker that can sweep is a worker that will**, which is why `bulk-reader` has no shell and refuses these outright.

**A record of decisions and their reasons**, such as a decision log. It is made of reasons, and a cheap summary drops them. A decision that arrives without its reason is indistinguishable from an open question, which is the exact failure the record exists to prevent.

A size check will not catch either, so a large read there is yours to do directly.

## How to brief it

The worker is cheap, and a cheap model answers the question it was given rather than the one you meant. So the brief carries the weight.

- **Ask one question, phrased as a lookup.** *"Which classes call `getOrderTotal`, and from which file and line?"* beats *"tell me about the order code"*.
- **Name the files, or name the pattern.** It has grep and glob, so a pattern is enough and the search results stay out of here too.
- **Say what a useful answer looks like.** A count, a list of paths, a yes or no with the line that settles it.
- **Ask for the gap explicitly.** "Say so if it is not there" is what turns silence into a result.

**Read what comes back as evidence, not as a conclusion.** Every bullet leads with a path, a line or a symbol, which is exactly so you can open the one that matters. If the answer is about to go into a document or a decision, open that one.

## The roles are already graded, so do not re-decide their model

Where a review agent's definition fixes its model, that grading is the decision. **Do not pass a `model` override to the agent tool to second-guess it**, in either direction. If a role is graded wrongly, the fix is one line in its definition and a note saying what it started missing.

## Before you call the delegation done

- The corpus was actually large. Below the floor you spent time to save nothing.
- The question was specific enough that a wrong answer would look wrong.
- Nothing from the places that are never delegated was in the file list or reachable by the pattern.
- What you are about to write down cites a path and a line, and you opened the one that carries the weight.
