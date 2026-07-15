#' Report the status of installed skills
#'
#' Prints, and invisibly returns, which skills are installed at `path`,
#' which ref they came from, and whether any have been hand-edited since.
#'
#' @param path Base directory skills were installed into with [use_skill()].
#' @param target Where under `path` the skills were installed; must match
#'   the `target` used with [use_skill()]. See [use_skill()] for the
#'   available values.
#'
#' @return A data frame with columns `skill`, `ref`, and `modified`,
#'   invisibly.
#'
#' @examples
#' \dontrun{
#' skill_status()
#' }
#'
#' @export
skill_status <- function(
  path = ".",
  target = names(grimoire_targets)
) {
  target <- match.arg(target)
  path <- resolve_target_path(path, target)
  manifest <- read_manifest(path)
  installed <- names(manifest$skills)

  if (length(installed) == 0) {
    cli::cli_inform("No skills installed at {.path {path}}.")
    return(invisible(data.frame(
      skill = character(),
      ref = character(),
      modified = logical(),
      stringsAsFactors = FALSE
    )))
  }

  rows <- lapply(installed, skill_status_one, path = path, manifest = manifest)
  invisible(do.call(rbind, rows))
}

skill_status_one <- function(skill, path, manifest) {
  entry <- manifest$skills[[skill]]
  modified <- isTRUE(skill_is_modified(skill_dir(path, skill), entry$checksum))

  if (modified) {
    cli::cli_alert_warning(
      "{.field {skill}} ({.val {entry$ref}}) \u2014 locally modified"
    )
  } else {
    cli::cli_alert_success("{.field {skill}} ({.val {entry$ref}})")
  }

  data.frame(
    skill = skill,
    ref = entry$ref,
    modified = modified,
    stringsAsFactors = FALSE
  )
}
