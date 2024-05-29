import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
# set the palette as rocket_r
sns.set_palette("rocket_r")

SLUG="BSP8"
if __name__ == '__main__':

    # Load the LD file (tab separated)
    DF = open(f"../data/gstacks-{SLUG}/sex.ld").read().strip().split("\n")
    DF = [a.split() for a in DF]
    DF = pd.DataFrame(DF[1:], columns=DF[0])

    chromosome_list = list(DF["CHR_A"].unique())

    #for chromosome in chromosome_list[:]:
    for chromosome in chromosome_list[:]  :
        print(f"Processing chromosome {chromosome}")
        # Only fetch for the chr : id=_MINIGRAPH_|s1
        df = DF[DF["CHR_A"] == chromosome]

        # Filter only the thousand first rows
        df["BP_A"] = df["BP_A"].astype(int)
        df["BP_B"] = df["BP_B"].astype(int)
        df["R2"] = df["R2"].astype(float)

        # The tuple "BP_A, BP_B" should be unique
        df = df.groupby(["BP_A", "BP_B"]).mean().reset_index()

        fig, ax = plt.subplots(figsize=(10, 10))
        # Plot heatmap of the 'R' Column, the X will be the BP_A, the Y will be the BP_B
        # sns.heatmap(df.pivot("BP_A", "BP_B", "R"), ax=ax)
        # Use scatterplot instead of heatmap (use square points, to make it similar to heatmap)
        ax.scatter(df["BP_A"], df["BP_B"], c=df["R2"], s=1, marker="s", cmap="rocket_r")
        # draw the diagonal line in red, width 0.
        max_val = max(df["BP_A"].max(), df["BP_B"].max())
        min_val = min(df["BP_A"].min(), df["BP_B"].min())
        ax.plot([min_val, max_val], [min_val, max_val], color="red", linewidth=0.1)
        # put legend colorbar
        plt.colorbar(ax.collections[0], ax=ax, label="R2")

        # Save it to svg
        # plt.show()
        plt.savefig(f"../data/gstacks-{SLUG}/ld-figures/{chromosome.replace('id=_MINIGRAPH_|', '')}.svg")


    print()