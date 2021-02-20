#!/usr/bin/env nix-shell
#! nix-shell -i Rscript -p R rPackages.spongebob
suppressWarnings(library(spongebob))
con <- file("stdin")
open(con, blocking=TRUE)
x <- readLines(con)
x <- spongebobsay(x)
write(x,"")
