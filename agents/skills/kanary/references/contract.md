# Kanary CLI Output Contract

Raw stdout JSON shapes, to read alongside the jq recipes in `SKILL.md`. The canonical CLI contract lives in this repository at `macos/docs/specs/cli.md`; this file only lists the keys agents usually need.

## Rules

- stdout JSON keys are snake_case; `schema_version` is currently `1`.
- `--out` is a CLI input flag. JSON output paths use `out_path`.
- Treat unknown enum values as opaque strings, not parse failures.
- On failure stdout is empty and the error goes to stderr; only Pro/plan gate failures use the JSON shape below, other errors are plain text. Exit codes and recovery: `references/troubleshooting.md`.

## transcribe <path>

Ephemeral; does not add a recording to the library.

Without `--out`, stdout is the full transcript (same `transcript` shape as `recordings show`):

```json
{
  "schema_version": 1,
  "source_path": "/abs/audio.m4a",
  "duration": 7647.599,
  "transcript": {
    "segments": [
      { "channel": "speaker", "text": "...", "start_seconds": 0.0, "end_seconds": 20.0, "confidence": 0.9 }
    ],
    "diagnostics": [
      { "channel": null, "severity": "warning", "message": "..." }
    ]
  }
}
```

With `--out`, stdout is only a flat receipt; the full transcript is written to `out_path`:

```json
{
  "schema_version": 1,
  "out_path": "/abs/transcript.json",
  "duration": 7647.599,
  "segments": 396,
  "diagnostics": 0
}
```

`.transcript` is absent in the receipt; `.segments` / `.diagnostics` are integer counts. If the caller does not know which mode produced the JSON:

```sh
jq '{duration, segments: (.segments // (.transcript.segments | length)), diagnostics: (.diagnostics // (.transcript.diagnostics | length))}'
```

## recordings list

```json
{
  "schema_version": 1,
  "recordings": [
    { "id": "20260528-104530-AB12CD34", "created_at": "...", "updated_at": "...", "status": "transcribed", "duration": 92.425, "title": "Call" }
  ]
}
```

`duration` and `title` are omitted when absent.

## recordings show <id>

```json
{
  "schema_version": 1,
  "metadata": { "id": "20260528-104530-AB12CD34", "created_at": "...", "updated_at": "...", "status": "transcribed", "duration": 92.425, "title": "Call" },
  "transcript": { "limited": "plan", "segments": [ ... ], "diagnostics": [ ... ] },
  "summary": { "markdown": "## Summary\n..." }
}
```

`metadata` matches a `recordings list` item; segment / diagnostic shapes match `transcribe`. `transcript.limited == "plan"` means a Pro-capped transcript (~first 75 min). `transcript` and `summary` may be `null`.

## recordings export <id>

```json
{
  "schema_version": 1,
  "id": "20260528-104530-AB12CD34",
  "channel": "speaker",
  "out_path": "/abs/speaker.m4a",
  "bytes_written": 1234567
}
```

Request `--channel` is `auto|speaker|mic|mixed`; response `channel` is the resolved `speaker|mic|mixed`.

## status

```json
{
  "schema_version": 1,
  "cli": { "version": "2.0.6", "channel": "release" },
  "app": { "installed": true, "reachable": true, "blocked": null },
  "voice": { "os_supported": true, "capture_enabled": null }
}
```

`cli.channel` is `"release"` or `"debug"`. `app.blocked` is `null` or `"sandbox"`. `voice.capture_enabled` is `null` when unknown.

## errors (stderr)

Pro/plan gate failures (`code` `-32010`, `data.reason == "plan"`) emit a JSON object on stderr:

```json
{
  "code": -32010,
  "message": "...",
  "data": { "reason": "plan", "upgrade_url": "https://kanary.download/pricing?focus=pro&utm_source=cli" }
}
```

The CLI adds `data.upgrade_url`. Other failures print a human-readable message on stderr instead; exit-code mapping is in `references/troubleshooting.md`.
