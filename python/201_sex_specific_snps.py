import argparse
from scipy.stats import ttest_ind
import pandas as pd

def avg(a):
    return sum(a)/len(a)

fish_sex = {
    "ERR3332435.sorted": "male",
    "ERR3332436.sorted": "male",
    "SRR18231392.sorted": "male",
    "SRR18231393.sorted": "male",
    "SRR18231394.sorted": "male",
    "SRR18231395.sorted": "male",
    "SRR18231396.sorted": "male",
    "SRR18231397.sorted": "male",
    "SRR18231399.sorted": "male",
    "SRR18231401.sorted": "female",
    "SRR18231402.sorted": "female",
    "SRR18231403.sorted": "male",
    "SRR18231404.sorted": "female",
    "SRR18231405.sorted": "female",
    "SRR18231406.sorted": "male",
    "SRR18231407.sorted": "female",
    "SRR18231408.sorted": "female",
    "SRR18231409.sorted": "male",
    "SRR18231412.sorted": "female",
    "SRR18231415.sorted": "female",
    "SRR18231416.sorted": "female"
}

parser = argparse.ArgumentParser(description = 'Find sex specific SNPs')
parser.add_argument('--vcf', type = str, help = 'VCF file', required=True)
args = parser.parse_args()

if __name__ == '__main__':
    vcf_content = open(args.vcf).read().strip().split("\n")
    header = [a for a in vcf_content if "#" in a]
    vcf_body = [a.split("\t") for a in vcf_content if "#" not in a]
    vcf_body = [a[0:8]+[a[9:]] for a in vcf_body]
    indiv_list = header[-1].split("\t")[9:]
    print()

    output_vcf = {"male":[],"female":[]}
    output = []

    for snp in vcf_body:
        # separate the snps found in male and in female
        per_sex_genotype = {"male": [], "female": []}
        for i, (indiv, genotype) in enumerate(zip(indiv_list, snp[8])):
            sex = fish_sex[indiv]
            if genotype == "./.":
                per_sex_genotype[sex].append(0) # Absent
            else:
                per_sex_genotype[sex].append(1) # Present

        # Perform independant t-test
        t,p = ttest_ind(per_sex_genotype["male"], per_sex_genotype["female"])
        male_specificity = avg(per_sex_genotype["male"]) - avg(per_sex_genotype["female"])
        if p < 0.05:
            output.append({
                "chrom": snp[0],
                "pos": snp[1],
                "id": snp[2],
                "ref": snp[3],
                "alt": snp[4],
                "male_array": per_sex_genotype["male"],
                "female_array": per_sex_genotype["female"],
                "t": t,
                "p": p,
                "male_specificity": male_specificity
            })
            if male_specificity > 0:
                output_vcf["male"].append(snp[0:8]+snp[8])
            else:
                output_vcf["female"].append(snp[0:8]+snp[8])

    # Prepare the vcf output for the two output file
    male_outfile = args.vcf.replace(".vcf", ".male.vcf")
    open(male_outfile, "w").write("\n".join(header + ["\t".join(a) for a in output_vcf["male"]]))

    female_outfile = args.vcf.replace(".vcf", ".female.vcf")
    open(female_outfile, "w").write("\n".join(header + ["\t".join(a) for a in output_vcf["female"]]))

    # Write the output to csv (use dataframe first)
    df = pd.DataFrame(output)
    df.to_csv(args.vcf.replace(".vcf", ".csv"), index=False)
    print()