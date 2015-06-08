import sys
import yaml

def main():
    f = sys.argv[1]
    with open(f) as doc:
        print(yaml.dump(yaml.load(doc)))

if __name__ == '__main__':
    main()
