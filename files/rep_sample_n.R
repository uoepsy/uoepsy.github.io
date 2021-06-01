rep_sample_n <- function(data, n, samples = 1, sample_id = "sample", ...) {
    
    df <- purrr::map_dfr(1:samples, function(i) dplyr::slice_sample(data, n = n, ...), 
                         .id = sample_id)
    
    df[[sample_id]] <- as.numeric(df[[sample_id]])
    
    return(df)
}
