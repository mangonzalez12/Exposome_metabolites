
# Project root: here::here() finds the repo root (the folder with .git) when R is
# started inside the repo. If R was started in the parent folder (e.g. the VS Code
# workspace root), fall back to the repo subfolder.
root = here::here()
if (!dir.exists(file.path(root, "data"))) {
  root = file.path(root, "Exposome_metabolites")
}
stopifnot(dir.exists(file.path(root, "data")))

# ISA-Tab study/sample file (tab-separated).
metadata = read.delim(
  file.path(root, "data", "s_MTBLS2442.txt"),
  header = TRUE,
  check.names = TRUE,      # repeated ISA columns (Protocol REF, Term Source REF...) get unique names
  stringsAsFactors = FALSE,
  na.strings = c("", "NA"),
  fileEncoding = "UTF-8"   # column descriptions contain "µm"
)
# Use "Sample Name" (unique per row) as row names; it is not the first column
# ("Source Name" is), so set it explicitly by name.
stopifnot(!anyDuplicated(metadata$Sample.Name), !anyNA(metadata$Sample.Name))
rownames(metadata) = metadata$Sample.Name
metadata
