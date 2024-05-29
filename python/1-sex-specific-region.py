

if __name__ == '__main__':
    gfa_data = open("../data/bsp8_mf/bsp8.gfa").read().split("\n")
    gfa_data = [a.split("\t") for a in gfa_data]

    regions = [a for a in gfa_data if len(a) == 3]
    # Sort by the length
    regions = [a for a in regions if len(a[2]) > 1]
    regions = sorted(regions, key=lambda x: len(x[2]), reverse=True)

    output_fasta = []
    for region in regions:
        seq = region[2]
        seq = "\n".join([seq[i:i+70] for i in range(0, len(seq), 70)])
        output_fasta.append(f">S_{region[1]}\n{seq}")
    open("../data/bsp8_mf/region_of_interest.fasta", "w").write("\n".join(output_fasta))
    print("Done")
    print()
    # TACAGGTCATATCCAGGGTTTCAACGACCAATGTCCCGCTCCCTA
    #