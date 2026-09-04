---
name: kanary
description: Use when working with Kanary recordings or ephemeral audio transcription through the kanary CLI. List, inspect, search, export, and transcribe Voice recordings on this Mac, with projection-first JSON handling. Reads and ephemeral transcribes go over local IPC to the running Kanary.app and print JSON for jq.
---

# Kanary

Use the `kanary` CLI as the supported interface to Kanary recordings.
It talks to the running Kanary.app and prints JSON on stdout. Run `kanary help` for the authoritative command list.

## Ephemeral Transcription

Use top-level `transcribe <path>` when the user wants to transcribe an audio file without adding it to the Kanary recordings library:

```sh
kanary transcribe /path/to/audio.mp3 | jq '{duration, segments: (.transcript.segments | length), diagnostics: (.transcript.diagnostics | length)}'
```

For large outputs, write the full JSON transcript to a `.json` file. The stdout receipt is flat: `.segments` and `.diagnostics` are top-level integer counts, and `.transcript` is not included. Read the full transcript from the `--out` file with `.transcript.segments[]`.

```sh
kanary transcribe /path/to/audio.mp3 --out /path/to/transcript.json \
  | jq '{out_path, duration, segments, diagnostics}'
```

Top-level `transcribe` is ephemeral and does not mutate the recordings store, so it does not require confirmation. It can still consume local transcription compute and may require Kanary Pro for long audio; if it exits with a Pro/plan error, stop and relay that limitation to the user before continuing.

For exact stdout JSON shapes and key names, see `references/contract.md`.

## Recordings

Project before you read: recordings, especially transcripts, can be large. Filter with `jq` so only what the task needs enters context.

List metadata only:

```sh
kanary recordings list | jq '.recordings[] | {id, title, created_at, duration}'
```

When summarizing list results to the user:

- Omit `id` unless the user explicitly asks for IDs. Keep it internally for follow-up `show` commands.
- Show `created_at` as the recording date/time.
- Format `duration` as human-readable hours/minutes/seconds instead of raw seconds.

Inspect one recording. Keep `limited` and probe transcript size first:

```sh
kanary recordings show <id> | jq '{limited: .transcript.limited, meta: (.metadata | {id, title, created_at, duration}), segments: (.transcript.segments | length)}'
```

Extract only the transcript lines you need:

```sh
kanary recordings show <id> | jq -r '.transcript.segments[] | "[\(.start_seconds)-\(.end_seconds)] \(.channel): \(.text)"'
```

Search within a transcript:

```sh
kanary recordings show <id> | jq -r '.transcript.segments[] | select(.text | test("keyword"; "i")) | "[\(.start_seconds)-\(.end_seconds)] \(.channel): \(.text)"'
```

Limit to a time window in seconds:

```sh
kanary recordings show <id> | jq -r '.transcript.segments[] | select(.start_seconds >= 300 and .start_seconds < 420) | "[\(.start_seconds)-\(.end_seconds)] \(.channel): \(.text)"'
```

Export creates files. Confirm the destination first:

```sh
kanary recordings export <id> [<path>] [--channel auto|mixed|speaker|mic]
```

Mutating commands, including `recordings delete`, `recordings import`, and `recordings transcribe <id>`, require user confirmation before running.

## Surface Pro notices

`kanary recordings show` may include `transcript.limited == "plan"` and may print a `[Kanary Pro]` line on stderr when a transcript is limited without Kanary Pro. Keep `limited` in jq selections, and do not discard stderr for show. If `transcript` is null, the plan notice is still surfaced on stderr.

When the probe shows `transcript.limited == "plan"` (or you see the `[Kanary Pro]` stderr line), **stop and relay the limitation to the user before extracting, summarizing, or any further work.** State the recording's full `duration` versus the covered window (transcripts are limited to roughly the first 75 minutes without Kanary Pro) and ask how to proceed. If the stderr line includes an upgrade URL, include the full URL in the user-facing response exactly as printed, preserving all query parameters. Never summarize or act on a `plan`-limited transcript without first telling the user it is partial.

## Safety

- Use `kanary recordings ...` for recording data and `kanary transcribe <path>` for ephemeral file transcription.
- Do not `ls`, `find`, `cat`, edit, or delete files under Kanary app data locations such as `~/Library/Application Support/Kanary*` or Kanary iCloud containers.
- Treat list/show and top-level transcribe as read-only with respect to Kanary storage. Confirm export and `transcribe --out` destinations. Ask before deletes, imports, or `recordings transcribe <id>`.

## Trouble?

If a command fails, exits non-zero, especially exit code 13, or `app.reachable` looks wrong, read `references/troubleshooting.md`.
