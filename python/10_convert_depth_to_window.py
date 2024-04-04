import sys
import argparse

parser = argparse.ArgumentParser(description = 'Convert the depth to window')
parser.add_argument('--window', type = int, help = 'Window size', default=100)
args = parser.parse_args()

if __name__ == '__main__':
    # load from stdin
    window_depth = 0
    current_window = -1
    for line in sys.stdin:
        line = line.strip().split()
        window_id = (int(line[1]) // args.window) * args.window

        if window_id != current_window:
            if current_window != -1:
                window_depth = (window_depth / args.window)
                print(current_window, window_depth)
            current_window = window_id
            window_depth = 0
        window_depth += int(line[2])