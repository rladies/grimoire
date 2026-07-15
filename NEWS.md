# grimoire 0.0.0.9000

- Initial release of the R client for grimoire skills: `use_skill()`,
  `skill_update()`, `skill_remove()`, `skill_status()`, and
  `available_skills()`.
- `use_skill()`, `skill_update()`, `skill_remove()`, and `skill_status()` gain
  a `target` argument (`"default"`, `"claude"`, `"opencode"`, `"agents"`) to
  install straight into a directory Claude Code or Opencode auto-discovers,
  instead of the plain `skills/` folder.
