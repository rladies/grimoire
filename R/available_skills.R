#' List skills available in a grimoire repository
#'
#' @param repo `"owner/repo"` slug of the source repository.
#' @param ref Git ref (tag, branch, or SHA) to list from. Defaults to the
#'   latest 'GitHub' release, falling back to the default branch if the repo
#'   has no releases.
#' @param descriptions If `TRUE` (the default), also fetch each skill's
#'   `description` from its `SKILL.md` frontmatter. Set to `FALSE` for a
#'   faster, name-only listing.
#'
#' @return A data frame with one row per skill, columns `skill` and
#'   (if `descriptions = TRUE`) `description`.
#'
#' @examples
#' \dontrun{
#' available_skills()
#' available_skills(descriptions = FALSE)
#' }
#'
#' @export
available_skills <- function(
  repo = "rladies/grimoire",
  ref = NULL,
  descriptions = TRUE
) {
  resolved_ref <- resolve_ref(repo, ref)
  sha <- resolve_commit_sha(repo, resolved_ref)
  tree <- get_repo_tree(repo, sha)
  skills <- list_remote_skills_from_tree(tree)

  if (!descriptions || length(skills) == 0) {
    return(data.frame(skill = skills, stringsAsFactors = FALSE))
  }

  cli::cli_alert_info(
    "Reading descriptions for {length(skills)} skill{?s} from {.val {repo}}"
  )
  desc <- vapply(
    skills,
    skill_description_one,
    character(1),
    repo = repo,
    sha = sha
  )
  data.frame(
    skill = skills,
    description = unname(desc),
    stringsAsFactors = FALSE
  )
}

skill_description_one <- function(skill, repo, sha) {
  text <- download_file_raw(repo, sha, paste0("skills/", skill, "/SKILL.md"))
  parse_skill_description(text)
}

parse_skill_description <- function(text) {
  lines <- strsplit(text, "\n")[[1]]
  delims <- which(lines == "---")
  if (length(delims) < 2) {
    return(NA_character_)
  }
  frontmatter <- paste(lines[(delims[1] + 1):(delims[2] - 1)], collapse = "\n")
  parsed <- yaml::yaml.load(frontmatter, eval.expr = FALSE)
  if (is.null(parsed$description)) NA_character_ else parsed$description
}
