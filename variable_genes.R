library(dplyr)
library(tidyr)
library(ggplot2)
setwd("/Users/anna/Desktop/test")
folder <- "./htseq_output/"

files <- list.files(folder, pattern="*.txt", full.names=TRUE)
all_data <- data.frame()

for (file in files) {
  temp_data <- read.table(file, sep="\t", header=FALSE, col.names=c("Gene", "Expression"))
  temp_data$Sample <- file
  all_data <- rbind(all_data, temp_data)
}

variability <- all_data %>%
  group_by(Gene) %>%
  summarise(Var = var(Expression), .groups = 'drop')

top_genes <- variability %>% 
  arrange(desc(Var)) %>%
  slice_head(n = 5000)

top_genes_data <- all_data %>% 
  filter(Gene %in% top_genes$Gene)

p <- ggplot(top_genes_data, aes(x=Gene, y=Expression)) +
  geom_violin(scale = "width", adjust = 0.5, fill = '#A4A4A4') +
  theme_minimal() + 
  theme(axis.text.x = element_blank(),
        axis.title.x = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank()) +
  labs(y = "Gene expression", 
       title = "Violin plot of top 5000 variable genes")

ggsave("top_genes_plot.pdf", plot = p)
library(biomaRt)

ensembl <- useMart("ensembl",dataset="hsapiens_gene_ensembl")
genes <- getBM(filters="ensembl_gene_id_version", 
               attributes=c('ensembl_gene_id_version', 'external_gene_name'), 
               values=top_genes$Gene, 
               mart= ensembl)
