import pandas as pd
# Using sliding window algorithm, find the region enriched in the male/female specific SNPs



# Output
# chrom, start, end, male_count, female_count, ratio, sex
SLUG="BSP8"
if __name__ == '__main__':
    output = []
    # Read the SNP_list file
    DF = pd.read_csv(f"../data/gstacks-{SLUG}/populations.snps.bonferonni.csv")
    chromosome_list = list(DF["chrom"].unique())
    for chromosome in chromosome_list:
        df = DF[DF["chrom"] == chromosome]
        chromosome_len = df["pos"].max() - df["pos"].min()

        offset = df["pos"].min()
        window_size = chromosome_len
        while True:
            sub_df = df[(df["pos"] >= offset) & (df["pos"] <= offset + window_size)]
            sub_df_male = sub_df[sub_df["male_specificity"] > 0]
            sub_df_female = sub_df[sub_df["male_specificity"] < 0]
            male_density = len(sub_df_male) / window_size
            female_density = len(sub_df_female) / window_size
            male_ratio = len(sub_df_male) / len(sub_df)
            if male_ratio > 0.75 or male_ratio < 0.25:
                output.append({
                    "chrom": chromosome,
                    "start": offset,
                    "end": offset + window_size,
                    "male_ratio": male_ratio,
                    "male_count": len(sub_df),
                    "total_count": len(sub_df)
                })
            break
    # Convert output to pandas dataframe and export to csv
    output = pd.DataFrame(output)
    output.to_csv(f"../data/gstacks-{SLUG}/male_specific_region.csv", index=False)
    print("Done")
    print()