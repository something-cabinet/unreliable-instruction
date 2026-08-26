# Carnival of the Liar (working title)

**Jam theme:** Trust No One
**Engine:** Godot 4

## Premise

Player is an inspector hired by a carnival manager to investigate whether
the carnival's stall owners are running their games fairly. The manager
hands the player a stack of **psychology profiles** describing lying
patterns (e.g. "always alternates lie/truth," "lies only when wearing
red," "only tells the truth when sad") — but the profiles are **not
labeled with names**. The player must figure out which profile belongs
to which owner, and in doing so, uncover the true rules of each carnival
game and whether each owner is actually cheating.

## Core Loop

1. Player has a set of unlabeled psychology profiles and a set of stall
   owners (same count, 1:1 match, unknown pairing).
2. Player spends limited **investigation actions** on owners:
   - Ask about the stall's rule (owner states a 2-4 line rule, possibly
     a lie, depending on their true, still-unknown profile).
   - Observe a scripted round of their game being played.
3. Using the (limited) evidence gathered, player tentatively matches
   profiles to owners — profiles that are inconsistent with the evidence
   are ruled out. Because each profile is used exactly once, evidence
   about one owner narrows down the possibilities for the others too
   (elimination logic, like a logic grid puzzle).
4. Investigation actions are scarce relative to the number of owners —
   the player cannot fully interrogate everyone, so some assignments
   must be solved purely by elimination.
5. Player submits a final report: profile-to-owner matches, plus which
   owners were actually following their true rule vs. cheating.
6. Manager reacts based on report accuracy.

## Why This Fits the Theme

The player can't take any single piece of information at face value —
not the stated rules (owners lie per their pattern), not even which
pattern applies to whom (profiles are unlabeled and must be earned
through evidence). Trust has to be built entirely through cross-checked,
budgeted evidence gathering — nothing is handed over reliably.

## Design Decisions (locked)

- Lying patterns are told on the profile card itself (not inferred from
  scratch) — the puzzle is *matching*, not decoding an unknown pattern.
- "Playing the game" is a short **scripted round**, not a real minigame
  — player watches the outcome and judges it, keeping content-authoring
  cost low per owner.
- Investigation actions are a **limited, shared resource** across all
  owners (not unlimited/free revision) — this creates budgeting
  tension and forces elimination logic rather than brute-force checking
  every owner individually.
- Each stated rule is short: 2-4 lines, to keep writing/reading light.

## Open Design Questions (still to settle)

- Exact number of owners/profiles for the jam build (target ~5-6).
- Exact investigation action budget (target: fewer total actions than
  needed to fully interrogate every owner independently, so elimination
  is mandatory).
- Whether "ask rule" and "observe round" are separate actions, or
  bundled as one "visit" action per owner.
- Whether the manager's own profile intel can ever be wrong (a possible
  later twist, not required for jam scope).
- Fail-state / ending variation based on report accuracy.
- UI for tracking evidence and assignment state (logic-grid style
  confirmed/possible/ruled-out per profile-owner pair).
