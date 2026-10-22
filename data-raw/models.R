# Code to fit amewoo model on Unity Cluster. It is unlikely to work
# in other contexts.

# Currently there are two models the first amewoo is used in most examples.
# It is not a sparse model.
# The second rewbla was initial added to test evaluation code
# e.g. BirdFlowR::interval_log_likelihood()
# and is used in a few other tests. It is heavily sparsified.


dir <- "/work/pi_plunkett_umass_edu/birdflowexamples/"

library(BirdFlowR)
library(BirdFlowPipeline)
bf <- load_model("amewoo")

species <- "amewoo"
res <- 150
hp <- bf$metadata$hyperparameters

dir.create(dir, showWarnings = FALSE)
batch_species(species = species,
              grid_search_type = "old",
              dist_pow = hp$dist_pow,
              dist_weight = hp$dist_weight,
              ent_weight = hp$ent_weight,
              res = res,
              hdf_path = dir,
              base_output_path = dir,
              clip = BirdFlowPipeline::americas_clip,
              crs = as.character(BirdFlowPipeline::americas_crs)[2])



result <- paste0(dir, species, "_", res, "km/", species,
                 "_", ebirdst::ebirdst_version()$status_version_year[1], "_",
                 res, "km_obs1.0_ent",
                 hp$ent_weight,
                 "_dist", hp$dist_weight,
                 "_pow", hp$dist_pow, ".hdf5")


bf <- import_birdflow(result)

amewoo <- bf

usethis::use_data(amewoo, compress = "xz")


# Note I'm using the tuned parameters from AMEWOO for rewbla as well
# This isn't best practice for models used for inference but
# is fine for creating a second model
species <- "rewbla"
res <- 350
hp <- bf$metadata$hyperparameters

dir.create(dir, showWarnings = FALSE)
batch_species(species = species,
              grid_search_type = "old",
              dist_pow = hp$dist_pow,
              dist_weight = hp$dist_weight,
              ent_weight = hp$ent_weight,
              res = res,
              hdf_path = dir,
              base_output_path = dir,
              clip = BirdFlowPipeline::americas_clip,
              crs = as.character(BirdFlowPipeline::americas_crs)[2])



result <- paste0(dir, species, "_", res, "km/", species,
                 "_", ebirdst::ebirdst_version()$status_version_year[1], "_",
                 res, "km_obs1.0_ent",
                 hp$ent_weight,
                 "_dist", hp$dist_weight,
                 "_pow", hp$dist_pow, ".hdf5")



bf <- import_birdflow(result)
rewbla <- sparsify(bf, method = "conditional", p = .95, p_protected = 0.05)



usethis::use_data(rewbla, compress = "xz", overwrite = TRUE)



