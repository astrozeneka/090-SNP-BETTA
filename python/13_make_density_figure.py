import matplotlib.pyplot as plt
import pandas as pd
import argparse
import sys
import seaborn as sns
import numpy as np

parser = argparse.ArgumentParser(description = 'Plot figure')
parser.add_argument('--input', type = str, help = 'Input file', default='../data/reads_density/ERR3332435.coverage_s1.tsv')
parser.add_argument('--output', type = str, help = 'Output file', default=None)
args = parser.parse_args()

if __name__ == '__main__':


    # load data
    if(args.input):
        data = pd.read_csv(args.input, sep=' ', names=['chr', 'window', 'density'])
    else:
        # Load the data from stdin
        data = pd.read_csv(sys.stdin, sep=' ', names=['chr', 'window', 'density'])

    # truncate te data to include only 100 rows
    #data = data.head(2000)

    # Calculate the median of the density

    median = data['density'].median()
    palette = sns.color_palette("viridis", len(data))
    # sort by density
    rank = data['density'].argsort().argsort() # http://stackoverflow.com/a/6266510/1628638
    # Set figure size
    plt.figure(figsize=(40, 8))
    # plot barplot, make each bar stick to each other
    sns.barplot(x='window', y='density', data=data, palette=np.array(palette[::-1])[rank])
    # Passing `palette` without assigning `hue` is deprecated and will be removed in v0.14.0. Assign the `x` variable to `hue` and set `legend=False` for the same effect.

    # Save as svg
    # convert data['window'] to a native list
    xticks = np.array(data['window'].tolist())
    #plt.xticks(xticks, rotation=90)
    # plt.xticks(data['window'], data['window'], rotation=90)
    plt.ylim(0, 1000)
    # plt.xticks(range(0, 33000, 1000), range(0, 33), rotation=90)

    scaffold_length = max(data['window']) # 119000
    # Plot one tick every 1000 bp
    plt.xticks(range(0, scaffold_length//100, 1000), range(0, scaffold_length//100, 1000), rotation=90)
    # plt.xticks(range(0, scaffold_length, 1000), range(0, scaffold_length), rotation=90)

    plt.ylabel('Density')
    plt.xlabel('Position (Mbp)')
    # set xrange
    basename = args.input.split('/')[-1].split('.')[0]
    outfile = args.output if args.output else f'../data/density-figures/{basename}.svg'
    plt.savefig(outfile)
    print()
    # Replace the yticks by every 1000000 by using numpy
