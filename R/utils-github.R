split_repo <- function(repo) {
  parts <- strsplit(repo, "/", fixed = TRUE)[[1]]
  if (length(parts) != 2 || any(parts == "")) {
    cli::cli_abort(
      "{.arg repo} must be in the form {.val owner/repo}, not {.val {repo}}."
    )
  }
  list(owner = parts[1], repo = parts[2])
}

gh_repo_endpoint <- function(repo, suffix = "", ...) {
  or <- split_repo(repo)
  gh::gh(sprintf("GET /repos/%s/%s%s", or$owner, or$repo, suffix), ...)
}

resolve_ref <- function(repo, ref = NULL) {
  if (!is.null(ref)) {
    return(ref)
  }
  latest <- tryCatch(
    gh_repo_endpoint(repo, "/releases/latest"),
    error = function(e) NULL
  )
  if (!is.null(latest)) {
    return(latest$tag_name)
  }
  info <- gh_repo_endpoint(repo)
  cli::cli_alert_info(paste(
    "No releases found for {.val {repo}} \u2014 using default branch",
    "{.val {info$default_branch}}"
  ))
  info$default_branch
}

resolve_commit_sha <- function(repo, ref) {
  if (grepl("^[0-9a-f]{40}$", ref)) {
    return(ref)
  }
  gh_repo_endpoint(repo, sprintf("/commits/%s", ref))$sha
}

get_repo_tree <- function(repo, sha) {
  gh_repo_endpoint(repo, sprintf("/git/trees/%s", sha), recursive = "1")$tree
}

is_safe_path_segment <- function(x) {
  grepl("^[A-Za-z0-9_.-]+$", x) && !x %in% c(".", "..")
}

is_safe_skill_name <- is_safe_path_segment

# list_remote_skills_from_tree() silently drops unsafe names (a malicious
# entry just never becomes an installable skill); list_skill_files() aborts
# loudly instead, because by that point the user has already chosen to
# install this skill and a silent partial download would be more confusing
# than a clear refusal.
is_safe_relpath <- function(x) {
  if (fs::is_absolute_path(x)) {
    return(FALSE)
  }
  segments <- strsplit(x, "[/\\\\]")[[1]]
  length(segments) > 0 &&
    all(vapply(segments, is_safe_path_segment, logical(1)))
}

list_remote_skills_from_tree <- function(tree) {
  paths <- vapply(tree, function(x) x$path, character(1))
  is_skill_md <- grepl("^skills/[^/]+/SKILL\\.md$", paths)
  names <- sort(sub("^skills/([^/]+)/SKILL\\.md$", "\\1", paths[is_skill_md]))
  names[vapply(names, is_safe_skill_name, logical(1))]
}

list_skill_files <- function(tree, skill) {
  prefix <- paste0("skills/", skill, "/")
  is_match <- vapply(
    tree,
    function(x) identical(x$type, "blob") && startsWith(x$path, prefix),
    logical(1)
  )
  entries <- tree[is_match]
  if (length(entries) == 0) {
    cli::cli_abort("No files found for skill {.val {skill}}.")
  }
  paths <- vapply(entries, function(x) x$path, character(1))
  relpaths <- sub(prefix, "", paths, fixed = TRUE)
  unsafe <- !vapply(relpaths, is_safe_relpath, logical(1))
  if (any(unsafe)) {
    cli::cli_abort(c(
      "x" = paste(
        "{.val {skill}} contains unsafe file path{?s}:",
        "{.path {relpaths[unsafe]}}"
      ),
      "i" = "Refusing to download files that could escape the target directory."
    ))
  }
  data.frame(path = paths, relpath = relpaths, stringsAsFactors = FALSE)
}

raw_url <- function(repo, sha, path) {
  sprintf("https://raw.githubusercontent.com/%s/%s/%s", repo, sha, path)
}

download_file_raw <- function(repo, sha, path) {
  resp <- curl::curl_fetch_memory(raw_url(repo, sha, path))
  if (resp$status_code >= 400L) {
    cli::cli_abort(
      "Failed to download {.path {path}} ({.val {resp$status_code}})."
    )
  }
  rawToChar(resp$content)
}

download_file_to <- function(repo, sha, path, dest) {
  fs::dir_create(fs::path_dir(dest), recurse = TRUE)
  curl::curl_download(raw_url(repo, sha, path), fs::path(dest), quiet = TRUE)
  invisible(dest)
}
