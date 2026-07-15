fixture_tree <- function() {
  list(
    list(path = "skills/demo-skill/SKILL.md", type = "blob", sha = "sha1"),
    list(
      path = "skills/demo-skill/references/foo.md",
      type = "blob",
      sha = "sha2"
    ),
    list(path = "skills/other-skill/SKILL.md", type = "blob", sha = "sha3"),
    list(path = "README.md", type = "blob", sha = "sha4"),
    list(path = "skills", type = "tree", sha = "sha5")
  )
}

fixture_skill_md <- function(description = "Demo skill for tests.") {
  paste0(
    "---\n",
    "name: demo-skill\n",
    "description: ",
    description,
    "\n",
    "---\n\n",
    "# Demo skill\n\nBody text.\n"
  )
}

local_mocked_download <- function(env = parent.frame(), sha = "deadbeef") {
  testthat::local_mocked_bindings(
    resolve_ref = function(repo, ref = NULL) ref %||% "v0.1.0",
    resolve_commit_sha = function(repo, ref) sha,
    get_repo_tree = function(repo, sha) fixture_tree(),
    download_file_to = function(repo, sha, path, dest) {
      fs::dir_create(fs::path_dir(dest), recurse = TRUE)
      content <- if (basename(path) == "SKILL.md") {
        fixture_skill_md()
      } else {
        "reference body\n"
      }
      writeLines(content, dest)
      invisible(dest)
    },
    .env = env
  )
}

# Self-contained: the mock is torn down when this function returns, so a
# second, differently-shaed local_mocked_download() can be layered on top
# in the calling test without double-mocking the same bindings. Messages are
# captured (not suppressed) so setup calls don't leak cli output into
# devtools::test() output for tests that snapshot a later, real call.
install_skills <- function(root, skill, sha = "deadbeef", target = "default") {
  local_mocked_download(sha = sha)
  testthat::capture_messages(use_skill(skill, path = root, target = target))
  invisible(NULL)
}

redact_path <- function(root) {
  root <- as.character(fs::path(root))
  function(lines) gsub(root, "<root>", lines, fixed = TRUE)
}

`%||%` <- function(x, y) if (is.null(x)) y else x
