rep_randomize <- function(data, columns, samples = 1, sample_id = "sample", ...) {
    
    df <- purrr::map_dfr(1:samples,
                         ~ tibble::as_tibble(modelr::resample_permutation(data, columns)),
                         .id = sample_id)
    
    df[[sample_id]] <- as.numeric(df[[sample_id]])
    
    return(df)
}