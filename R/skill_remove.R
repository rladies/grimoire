#' Remove installed skills
#'
#' Deletes previously installed skill folders. A skill that has been
#' hand-edited locally (its on-disk checksum no longer matches what
#' [use_skill()] installed) is left in place unless `force = TRUE`. When the
#' last skill at `path` is removed, the manifest file (and the now-empty
#' `skills/` directory) are cleaned up too.
#'
#' @param skill Character vector of skill names to remove.
#' @param path Base directory skills were installed into with [use_skill()].
#' @param force If `FALSE` (the default), a locally modified skill is
#'   skipped with a warning. If `TRUE`, it is removed anyway.
#' @param target Where under `path` the skills were installed; must match
#'   the `target` used with [use_skill()]. See [use_skill()] for the
#'   available values.
#'
#' @return The names of the skills that were removed, invisibly.
#'
#' @examples
#' \dontrun{
#' skill_remove("rladies-blog-post")
#' }
#'
#' @export
skill_remove <- function(
  skill,
  path = ".",
  force = FALSE,
  target = names(grimoire_targets)
) {
  check_skill_arg(skill)
  target <- match.arg(target)
  path <- resolve_target_path(path, target)

  manifest <- read_manifest(path)
  removed <- character()

  for (s in skill) {
    dest <- skill_dir(path, s)
    if (!fs::dir_exists(dest)) {
      cli::cli_alert_info("{.field {s}} is not installed at {.path {path}}")
      next
    }

    modified <- skill_is_modified(dest, manifest$skills[[s]]$checksum)
    if (!isFALSE(modified) && !force) {
      cli::cli_alert_warning(paste(
        "{.field {s}} has local changes or is untracked \u2014 skipping",
        "({.code force = TRUE} to remove anyway)"
      ))
      next
    }

    fs::dir_delete(dest)
    manifest$skills[[s]] <- NULL
    removed <- c(removed, s)
    cli::cli_alert_success("Removed {.field {s}}")
  }

  skills_root <- fs::path(path, "skills")
  if (length(manifest$skills) == 0) {
    if (fs::file_exists(manifest_path(path))) {
      fs::file_delete(manifest_path(path))
    }
    if (fs::dir_exists(skills_root) && length(fs::dir_ls(skills_root)) == 0) {
      fs::dir_delete(skills_root)
    }
  } else {
    write_manifest(path, manifest)
  }

  invisible(removed)
}
