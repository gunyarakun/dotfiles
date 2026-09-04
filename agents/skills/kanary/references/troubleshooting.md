# Troubleshooting

## Check app/IPC state

```sh
kanary status
```

`status` always exits 0 and reports state as JSON.

## Sandbox or restricted shell

If status JSON includes `"app": { "blocked": "sandbox" }`, or any command exits with code 13, the CLI binary was reached but the agent shell likely cannot connect to Kanary.app's local IPC socket, because it is blocked by a sandbox or restricted shell. Retry the command with escalated or unsandboxed permissions.

## App not running

If `app.reachable` is false and `app.blocked` is null, make sure Kanary.app is running, then retry.

## Exit codes

- 0: ok
- 3: not installed
- 4: Voice disabled
- 8: IPC failure
- 9: Kanary Pro required
- 10: unavailable; see stderr (`Voice requires macOS 26 or later`, or `CLI is not available in this build`)
- 13: sandbox-blocked, retry escalated
- 64: app launch timed out
