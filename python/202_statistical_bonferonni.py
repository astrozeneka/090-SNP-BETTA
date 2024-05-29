import pandas as pd

SLUG="BSP8"

if __name__ == '__main__':
    # Open the csv file
    #csv_content = open("../data/gstacks-BSP9/populations.snps.csv").read().strip().split("\n")
    #csv_content = [a.split(",") for a in csv_content]
    df = pd.read_csv(f"../data/gstacks-{SLUG}/populations.snps.csv")
    row_count = df.shape[0]
    bonferonni_threshold = 0.05 / row_count
    print("Bonferonni threshold is", bonferonni_threshold)
    # Filter the data
    df["p"] = df["p"].astype(float)
    df_sig = df[df["p"] < bonferonni_threshold]
    # Write to a new csv file
    df_sig.to_csv(f"../data/gstacks-{SLUG}/populations.snps.bonferonni.csv", index=False)

    # The number of row where the 'male_specificity' is positive
    len_male = df_sig[df_sig['male_specificity'] > 0].shape[0]
    len_female = df_sig[df_sig['male_specificity'] < 0].shape[0]
    print("Male specific SNPs : ", len_male)
    print("Female specific SNPs : ", len_female)
    print()