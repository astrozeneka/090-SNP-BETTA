import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

SLUG="BSP8"
if __name__ == '__main__':
    # Open the SNP bonferonni file
    DF = pd.read_csv(f"../data/gstacks-{SLUG}/populations.snps.bonferonni.csv")
    chromosome_list = list(DF["chrom"].unique())
    for chromosome in chromosome_list:
        print(f"Processing chromosome {chromosome}")
        df = DF[DF["chrom"] == chromosome]
        df["pos"] = df["pos"].astype(int)
        male_snps = df[df["male_specificity"] > 0]
        female_snps = df[df["male_specificity"] < 0]
        # Plot the SNP positions
        fig, ax = plt.subplots(figsize=(10, 10))
        ax.scatter(male_snps["pos"], male_snps["pos"], s=1, marker="s", color="blue")
        # décaler de 1 pour éviter de superposer les points
        female_snps["pos_"] = female_snps["pos"] + 1000
        ax.scatter(female_snps["pos"], female_snps["pos_"], s=1, marker="s", color="red")
        # make the dot semi transparent

        plt.xlabel("Position")
        # save
        plt.savefig(f"../data/gstacks-{SLUG}/snp-position/{chromosome.replace('id=_MINIGRAPH_|', '')}.svg")
        print()