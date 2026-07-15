#' Fetch a skill into a local project
#'
#' Downloads one or more skills from a grimoire-format 'GitHub' repository
#' into `<path>/skills/<skill>/`, so any tool that reads the Agent Skills
#' format (Claude Code, 'opencode', or others) can use it locally. Already
#' installed skills are left untouched unless `force = TRUE`.
#'
#' @param skill Character vector of skill names, as listed by
#'   [available_skills()].
#' @param path Base directory to install into. Skills land in
#'   `<path>/skills/<skill>/`. Defaults to the current directory.
#' @param repo `"owner/repo"` slug of the source repository.
#' @param ref Git ref (tag, branch, or SHA) to install from. Defaults to the
#'   latest 'GitHub' release, falling back to the default branch if the repo
#'   has no releases.
#' @param force If `FALSE` (the default), an already-installed skill is left
#'   as-is. If `TRUE`, it is deleted and re-downloaded, discarding any local
#'   edits.
#' @param target Where under `path` to install, relative to the skill/tool
#'   that should auto-discover it: `"default"` installs to `skills/`,
#'   `"claude"` to `.claude/skills/` (read by Claude Code and Opencode),
#'   `"opencode"` to `.opencode/skills/`, and `"agents"` to `.agents/skills/`.
#'
#' @return The path(s) to the installed skill folder(s), invisibly.
#'
#' @examples
#' \dontrun{
#' use_skill("rladies-blog-post")
#' use_skill(c("rladies-voice", "rladies-brand"), path = "my-project")
#' use_skill("rladies-blog-post", target = "opencode")
#' }
#'
#' @export
use_skill <- function(
  skill,
  path = ".",
  repo = "rladies/grimoire",
  ref = NULL,
  force = FALSE,
  target = names(grimoire_targets)
) {
  check_skill_arg(skill)
  target <- match.arg(target)
  path <- resolve_target_path(path, target)

  cli::cli_h1("Fetching {length(skill)} skill{?s} from {.val {repo}}")
  resolved_ref <- resolve_ref(repo, ref)
  sha <- resolve_commit_sha(repo, resolved_ref)
  tree <- get_repo_tree(repo, sha)

  unknown <- setdiff(skill, list_remote_skills_from_tree(tree))
  if (length(unknown) > 0) {
    cli::cli_abort(c(
      "x" = "Unknown skill{?s}: {.val {unknown}}",
      "i" = "Run {.fn available_skills} to see valid names."
    ))
  }

  dest_dirs <- vapply(
    skill,
    use_skill_one,
    character(1),
    path = path,
    repo = repo,
    ref = resolved_ref,
    sha = sha,
    tree = tree,
    force = force
  )
  invisible(unname(dest_dirs))
}

use_skill_one <- function(skill, path, repo, ref, sha, tree, force) {
  dest <- skill_dir(path, skill)
  exists <- fs::dir_exists(dest)

  if (exists && !force) {
    cli::cli_alert_info(paste(
      "{.field {skill}} already exists at {.path {dest}} \u2014 skipping",
      "({.code force = TRUE} to overwrite)"
    ))
    return(as.character(dest))
  }

  if (exists) {
    fs::dir_delete(dest)
  }

  files <- list_skill_files(tree, skill)
  fs::dir_create(dest, recurse = TRUE)
  tryCatch(
    for (i in seq_len(nrow(files))) {
      download_file_to(
        repo,
        sha,
        files$path[i],
        fs::path(dest, files$relpath[i])
      )
    },
    error = function(e) {
      fs::dir_delete(dest)
      stop(e)
    }
  )

  checksum <- compute_skill_checksum(dest)
  update_manifest_entry(path, repo, skill, ref, sha, checksum)
  cli::cli_alert_success(
    "Installed {.field {skill}} ({.val {ref}}) to {.path {dest}}"
  )
  as.character(dest)
}
