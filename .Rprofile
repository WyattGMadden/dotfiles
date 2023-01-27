setHook(packageEvent("grDevices", "onLoad"),
        function(...) grDevices::quartz.options(width = 35, height = 20,
                                                pointsize = 40))

if (interactive()) {
    suppressMessages(require(colorout))
    setOutputColors256(normal = 202,
                       number = 214,
                       negnum = 209,
                       date = 184,
                       string = 172,
                       const = 179,
                       warn = 209,
                       error = 209,
                       verbose = FALSE)
}

# recommended for package development
if (interactive()) {
  suppressMessages(require(devtools))
}
options(
  usethis.full_name = "Wyatt Madden",
  usethis.description = list(
    `Authors@R` = 'person("Wyatt", "Madden", email = "wyattgmadden@gmail.com", role = c("aut", "cre"), 
    comment = c(ORCID = "0000-0002-9792-7077"))',
    License = "MIT + file LICENSE",
    Version = "0.0.0.9000"
  )
)
