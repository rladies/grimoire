# Single source of truth for install targets: the four exported functions
# use names(grimoire_targets) as their `target` default, so adding a target
# only ever requires a change here.
grimoire_targets <- c(
  default = "",
  claude = ".claude",
  opencode = ".opencode",
  agents = ".agents"
)

target_prefix <- function(target) {
  grimoire_targets[[target]]
}

resolve_target_path <- function(path, target) {
  prefix <- target_prefix(target)
  if (nzchar(prefix)) fs::path(path, prefix) else fs::path(path)
}

skill_dir <- function(path, skill) {
  fs::path(path, "skills", skill)
}

check_skill_arg <- function(skill, call = parent.frame()) {
  if (!is.character(skill) || length(skill) == 0) {
    cli::cli_abort(
      "{.arg skill} must be a non-empty character vector.",
      call = call
    )
  }
}

manifest_path <- function(path) {
  fs::path(path, "skills", ".grimoire-manifest.json")
}

read_manifest <- function(path) {
  mf <- manifest_path(path)
  if (!fs::file_exists(mf)) {
    return(list(repo = NULL, skills = list()))
  }
  manifest <- jsonlite::read_json(mf, simplifyVector = FALSE)
  if (is.null(manifest$skills)) {
    manifest$skills <- list()
  }
  manifest
}

write_manifest <- function(path, manifest) {
  fs::dir_create(fs::path(path, "skills"), recurse = TRUE)
  jsonlite::write_json(
    manifest,
    manifest_path(path),
    auto_unbox = TRUE,
    pretty = TRUE,
    null = "null"
  )
  invisible(manifest)
}

compute_skill_checksum <- function(dir) {
  files <- fs::dir_ls(dir, recurse = TRUE, type = "file")
  if (length(files) == 0) {
    return(NA_character_)
  }
  relpaths <- fs::path_rel(files, start = dir)
  hashes <- vapply(
    files,
    digest::digest,
    character(1),
    algo = "sha256",
    file = TRUE
  )
  names(hashes) <- relpaths
  digest::digest(hashes[order(names(hashes))], algo = "sha256")
}

update_manifest_entry <- function(path, repo, skill, ref, sha, checksum) {
  manifest <- read_manifest(path)
  manifest$repo <- repo
  manifest$skills[[skill]] <- list(
    ref = ref,
    sha = sha,
    checksum = checksum,
    installed_at = format(Sys.time(), "%Y-%m-%dT%H:%M:%SZ", tz = "UTC")
  )
  write_manifest(path, manifest)
  invisible(manifest)
}

skill_is_modified <- function(dest, checksum) {
  if (is.null(checksum) || !fs::dir_exists(dest)) {
    return(NA)
  }
  !identical(compute_skill_checksum(dest), checksum)
}
