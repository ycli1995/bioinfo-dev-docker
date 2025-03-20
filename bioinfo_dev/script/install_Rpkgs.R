
args <- commandArgs(TRUE)

options(timeout = 100000)

options(download.file.method = "wget", download.file.extra = "-c")

pkgs <- args

all_pkgs <- BiocManager::available()

#notfound <- setdiff(pkgs, all_pkgs)
#if (length(notfound) > 0) {
#  stop(
#    "The following packages are not found: \n  ",
#    paste(notfound, collapse = ", ")
#  )
#}

pkgs <- setNames(pkgs, gsub(".*\\/", "", pkgs))
install.packages(pkgs, clean = TRUE, dependency = FALSE)

pkgs <- pkgs[setdiff(names(pkgs), rownames(installed.packages()))]
if (length(pkgs) > 0) {
  BiocManager::install(pkgs, update = FALSE, ask = FALSE)
  pkgs <- pkgs[setdiff(names(pkgs), rownames(installed.packages()))]
}

for (p in pkgs) {
  tryCatch(
    devtools::install_github(repo = paste0("cran/", p), upgrade = 'never', clean = TRUE),
    error = function(e) {
      warning(e, call. = FALSE, immediate. = TRUE)
      tryCatch(
        devtools::install_github(repo = p, upgrade = 'never', clean = TRUE),
        error = function(e) warning(e, call. = FALSE, immediate. = TRUE)
      )
    }
  )
}

