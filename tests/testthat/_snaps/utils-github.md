# split_repo() / errors on a malformed slug

    Code
      split_repo("grimoire")
    Condition
      Error in `split_repo()`:
      ! `repo` must be in the form "owner/repo", not "grimoire".

---

    Code
      split_repo("a/b/c")
    Condition
      Error in `split_repo()`:
      ! `repo` must be in the form "owner/repo", not "a/b/c".

# resolve_ref() / falls back to the default branch when there are no releases

    Code
      resolve_ref("rladies/grimoire", NULL)
    Message
      i No releases found for "rladies/grimoire" — using default branch "main"
    Output
      [1] "main"

# list_skill_files() / errors when the skill has no files

    Code
      list_skill_files(fixture_tree(), "nope")
    Condition
      Error in `list_skill_files()`:
      ! No files found for skill "nope".

# list_skill_files() / refuses to build relpaths that escape the target directory

    Code
      list_skill_files(malicious, "demo-skill")
    Condition
      Error in `list_skill_files()`:
      x "demo-skill" contains unsafe file path: '../../../etc/passwd'
      i Refusing to download files that could escape the target directory.

# download_file_raw() / errors on an HTTP failure

    Code
      download_file_raw("rladies/grimoire", "deadbeef", "skills/nope/SKILL.md")
    Condition
      Error in `download_file_raw()`:
      ! Failed to download 'skills/nope/SKILL.md' (404).

