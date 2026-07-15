#' Update installed skills to a newer ref
#'
#' Re-downloads installed skills whose upstream content has moved on. A
#' skill is skipped if it has been hand-edited locally (its on-disk checksum
#' no longer matches what [use_skill()] installed), unless `force = TRUE`.
#'
#' @param skill Character vector of skill names to update, or `NULL` (the
#'   default) to update every skill installed at `path`.
#' @param path Base directory skills were installed into with [use_skill()].
#' @param ref Git ref to update to. Defaults to the latest 'GitHub' release
#'   of the repository the skills were originally installed from.
#' @param force If `FALSE` (the default), a locally modified skill is
#'   skipped with a warning. If `TRUE`, it is overwritten.
#' @param target Where under `path` the skills were installed; must match
#'   the `target` used with [use_skill()]. See [use_skill()] for the
#'   available values.
#'
#' @return The names of the skills that were updated, invisibly.
#'
#' @examples
#' \dontrun{
#' skill_update() # update everything installed
#' skill_update("rladies-blog-post")
#' }
#'
#' @export
skill_update <- function(
  skill = NULL,
  path = ".",
  ref = NULL,
  force = FALSE,
  target = names(grimoire_targets)
) {
  target <- match.arg(target)
  path <- resolve_target_path(path, target)
  manifest <- read_manifest(path)
  installed <- names(manifest$skills)

  if (length(installed) == 0) {
    cli::cli_inform(
      "No skills installed at {.path {path}} \u2014 nothing to update."
    )
    return(invisible(character()))
  }

  if (is.null(skill)) {
    skill <- installed
  }
  unknown <- setdiff(skill, installed)
  if (length(unknown) > 0) {
    cli::cli_abort(c(
      "x" = "Not installed at {.path {path}}: {.val {unknown}}",
      "i" = paste(
        "Use {.fn use_skill} to install",
        "{cli::qty(length(unknown))}{?it/them} first."
      )
    ))
  }

  repo <- manifest$repo
  resolved_ref <- resolve_ref(repo, ref)
  sha <- resolve_commit_sha(repo, resolved_ref)
  tree <- get_repo_tree(repo, sha)

  cli::cli_h1("Updating {length(skill)} skill{?s} to {.val {resolved_ref}}")
  updated <- Filter(
    Negate(is.na),
    vapply(
      skill,
      skill_update_one,
      character(1),
      path = path,
      repo = repo,
      ref = resolved_ref,
      sha = sha,
      tree = tree,
      manifest = manifest,
      force = force
    )
  )
  invisible(unname(updated))
}

skill_update_one <- function(
  skill,
  path,
  repo,
  ref,
  sha,
  tree,
  manifest,
  force
) {
  entry <- manifest$skills[[skill]]
  modified <- skill_is_modified(skill_dir(path, skill), entry$checksum)

  if (isTRUE(modified) && !force) {
    cli::cli_alert_warning(paste(
      "{.field {skill}} has local changes \u2014 skipping",
      "({.code force = TRUE} to overwrite)"
    ))
    return(NA_character_)
  }

  if (identical(entry$sha, sha)) {
    cli::cli_alert_info("{.field {skill}} is already up to date ({.val {ref}})")
    return(NA_character_)
  }

  use_skill_one(skill, path, repo, ref, sha, tree, force = TRUE)
  skill
}
