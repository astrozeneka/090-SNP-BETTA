

if __name__ == '__main__':
    # Open the vcf file
    vcf_content = open("../data/plink/populations.snps.vcf").read().strip().split("\n")
    header = [a for a in vcf_content if "#" in a]
    vcf_content = [a.split("\t") for a in vcf_content if "#" not in a]
    # Count the number of snps per scaffold
    scaffold_snps = {}
    for row in vcf_content:
        scaffold = row[0]
        if scaffold not in scaffold_snps:
            scaffold_snps[scaffold] = 0
        scaffold_snps[scaffold] += 1
    # Get list of scaffolds having more than 5 snps
    scaffold_snps = {a:scaffold_snps[a] for a in scaffold_snps if scaffold_snps[a] > 5}
    # Get all the vcf row that has a scaffold in the scaffold_snps
    vcf_content = [a for a in vcf_content if a[0] in scaffold_snps]
    # Build the output
    outptut = []
    for row in vcf_content:
        outptut.append("\t".join(row))
    outptut = header + outptut
    # write the output
    open("../data/plink/populations.snps.filtered.vcf", "w").write("\n".join(outptut))
    print()
