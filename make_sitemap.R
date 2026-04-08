# where are your git repos stored? 
fpath = "../../uoepsy_courses/"
# what repos do we want to add?
repos = c("dapr1","dapr2","dapr3","usmr","msmr","lmm","lv")
# let's exclude most of previous years
rmyear = c("1920","2021","2122","2223")

# here are the index files
indf = c(list.files("files", recursive = TRUE, full.names = TRUE),
         list.files(".", recursive = TRUE, full.names = TRUE)
)
indf = indf[grepl("\\.html|\\.pdf",indf)]
indf = gsub("\\./","",indf)
indf = paste0("https://uoepsy.github.io/",indf)

allurl <- indf
for(r in repos){
    # list all the files in docs for each dir
    allf = list.files(paste0(fpath,r,"/docs"),
               recursive = TRUE,
               full.names = TRUE)
    # keep only htmls or pdfs
    allf = allf[grepl("\\.html|\\.pdf",allf)]
    allf = allf[!grepl(paste0(rmyear,collapse="|"), allf)]
    allf = gsub(fpath, "https://uoepsy.github.io/",allf)
    allf = gsub("/docs","",allf)
    allurl <- c(allurl, allf)
}

allurl = c(allurl[grepl("index.html",allurl)],
           allurl[!grepl("index.html",allurl)])

library(xml2)
root <- xml_new_root("urlset", 
                     xmlns = "http://www.sitemaps.org/schemas/sitemap/0.9")

for (u in allurl) {
    url_node <- xml_add_child(root, "url")
    xml_add_child(url_node, "loc", u)
    if(grepl("index.html",u)){
        xml_add_child(url_node, "priority", 1)
    } else {
        xml_add_child(url_node, "priority", .5)
    }
    xml_add_child(url_node, "changefreq", "always")
}
write_xml(root, "sitemap.xml")
