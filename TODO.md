# TODO — Carnival of the Liar

High-level steps only. Break each into details when you get there.

## 1. Lock the puzzle design
- [ ] Decide owner/profile count for the jam build.
- [ ] Decide investigation action budget (and whether ask/observe are
      separate or bundled).
- [ ] Write and hand-validate (or script-validate) that the puzzle is
      solvable within the action budget with a unique solution.

## 2. Write content
- [ ] Write all lying-pattern profiles.
- [ ] Write stated rule + true rule + scripted-round outcome for each
      owner.
- [ ] Write manager intro dialogue and report/ending reactions.
- [ ] Define visual "tells" for any condition-based lying patterns
      (outfit color, mood icon, etc).

## 3. Data structure / architecture
- [ ] Define owner data as a Godot Resource (stated rule, true rule,
      lie condition, tell, round outcome).
- [ ] Define profile data as a Resource (pattern description, logic
      for lie/truth evaluation).
- [ ] Decide save/state format for tracking player's evidence gathered
      and current profile-owner assignments.

## 4. Core systems
- [ ] Dialogue/statement display system (simple, since lines are short).
- [ ] Investigation action system (spend action → get evidence, track
      remaining budget).
- [ ] Scripted round playback system (reusable across all owners).
- [ ] Profile-to-owner assignment UI (drag/drop or click-to-match grid).
- [ ] Evidence tracking UI (confirmed / possible / ruled-out per pair).

## 5. Flow / scenes
- [ ] Manager intro scene.
- [ ] Hub scene (choose which owner to investigate / which action to
      spend).
- [ ] Owner interaction scene (statement + round playback).
- [ ] Report/submission scene.
- [ ] Ending/result scene (manager reaction based on accuracy).

## 6. Art & audio
- [ ] Owner portraits (+ any tell variants, e.g. red outfit).
- [ ] Manager portrait.
- [ ] Carnival background/UI art.
- [ ] Scripted round visuals (simple animations or sprite sequences).
- [ ] SFX/music pass.

## 7. Polish & playtesting
- [ ] Playtest full puzzle solvability with a fresh player.
- [ ] Tune action budget based on playtest difficulty.
- [ ] Bug pass, edge cases (revisiting owners, re-assigning profiles).
- [ ] Final build export + jam submission checklist.
