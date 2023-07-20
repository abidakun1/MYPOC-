#!/bin/bash

G='\033[0;32m'
R='\033[0;31m'

function usage {
    echo -e "USAGE: $0 [-w wordlist_file | -u single_domain]\n"
    echo "Options:"
    echo "  -w <wordlist_file>   Specify a wordlist file containing subdomains, one per line."
    echo "  -u <single_domain>   Specify a single domain to check for HTTP Strict Transport Security (HSTS)."
    echo "  -h, --help           Display this help message."
    exit 1
}

function check_hsts {
    curl -s -D- "$1"/ | grep -i strict

    if [ $? == 0 ]; then
        echo -e "\n${R}NOT VULNERABLE -: Http Strict TS present"
    else
        echo -e "\n${G}VULNERABLE -: Http Strict TS absent"
    fi
}

if [ $# -eq 0 ]; then
    usage
fi

while getopts "hw:u:" option; do
    case $option in
        h)
            usage
            ;;
        w)
            wordlist_file="$OPTARG"
            if [ ! -f "$wordlist_file" ]; then
                echo "Error: Wordlist file not found: $wordlist_file"
                exit 1
            fi

            while read -r domain || [[ -n "$domain" ]]; do
                echo -e "\n${R}CHECK: HTTP STRICT TRANSPORT VULNERABILITY for $domain"
                check_hsts "$domain"
            done < "$wordlist_file"
            exit 0
            ;;
        u)
            single_domain="$OPTARG"
            echo -e "\n${R}CHECK: HTTP STRICT TRANSPORT VULNERABILITY for $single_domain"
            check_hsts "$single_domain"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            usage
            ;;
    esac
done

# If no valid options are provided
usage
