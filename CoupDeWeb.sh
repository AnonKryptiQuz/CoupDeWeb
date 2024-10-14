#!/bin/bash

display_welcome_message() {
    clear
    echo -e "\033[0;32m   _____                  _____    __          __  _     "
    echo -e "\033[0;32m  / ____|                |  __ \   \ \        / / | |    "
    echo -e "\033[0;32m | |     ___  _   _ _ __ | |  | | __\ \  /\  / /__| |__  "
    echo -e "\033[0;32m | |    / _ \| | | | '_ \| |  | |/ _ \ \/  \/ / _ \ '_ \ "
    echo -e "\033[0;32m | |___| (_) | |_| | |_) | |__| |  __/\  /\  /  __/ |_) |"
    echo -e "\033[0;32m  \_____\___/ \__,_| .__/|_____/ \___| \/  \/ \___|_.__/ "
    echo -e "\033[0;32m                   | |                                   "
    echo -e "\033[0;32m                   |_|                                   "
    echo ""

    created_by_text="Program created by: AnonKryptiQuz"
    ascii_width=59
    
    padding=$(( (ascii_width - ${#created_by_text}) / 2 ))
    
    printf "%${padding}s" ""
    echo -e "\033[0;31m$created_by_text\033[0m"
    
    echo ""
}

command_exists() {
    command -v "$1" &> /dev/null
}

add_to_rc() {
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
    else
        SHELL_RC="$HOME/.bashrc"
    fi

    if ! grep -q 'export PATH=$PATH:$HOME/go/bin' "$SHELL_RC"; then
        echo -e "\033[1;33m[i] Go path added to $SHELL_RC.\033[0m"
    fi

    source "$SHELL_RC"
    echo -e "\033[1;32m[i] Environment variables reloaded from $SHELL_RC.\033[0m"
}

is_valid_url() {
    local url_pattern="^(http|https)://[a-zA-Z0-9.-]+(\.[a-zA-Z]{2,})?(/.*)?$"
    [[ $1 =~ $url_pattern ]]
}

filter_exists() {
    local filter_file="$HOME/.gf/$1.json"
    [[ -f "$filter_file" ]]
}

handle_exit() {
    echo -e "\n\033[0;31m[!] Program interrupted by the user. Exiting...\033[0m"
    exit 1
}

trap handle_exit SIGINT

install_golang() {
    if ! command_exists go; then
        echo -e "\033[0;31m[?] Golang: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing Golang...\033[0m"
        if ! sudo apt update; then
            echo -e "\033[0;31m[!] Failed to update package list. Exiting...\033[0m"
            exit 1
        fi
        if ! sudo apt install golang-go -y; then
            echo -e "\033[0;31m[!] Failed to install Golang. Exiting...\033[0m"
            exit 1
        fi
        add_to_rc
    else
        echo -e "\033[0;32m[i] Golang: Installed\033[0m"
    fi
}

install_waybackurls() {
    if ! command_exists waybackurls; then
        echo -e "\033[0;31m[?] waybackurls: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing waybackurls...\033[0m"
        if ! go install github.com/tomnomnom/waybackurls@latest; then
            echo -e "\033[0;31m[!] Failed to install waybackurls. Exiting...\033[0m"
            exit 1
        fi
    else
        echo -e "\033[0;32m[i] waybackurls: Installed\033[0m"
    fi
}

install_gf() {
    if ! command_exists gf; then
        echo -e "\033[0;31m[?] gf: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing gf...\033[0m"
        if ! go install github.com/tomnomnom/gf@latest; then
            echo -e "\033[0;31m[!] Failed to install gf. Exiting...\033[0m"
            exit 1
        fi

        if [ ! -d "$HOME/.gf" ]; then
            mkdir -p "$HOME/.gf" || { echo -e "\033[0;31m[!] Failed to create directory $HOME/.gf. Exiting...\033[0m"; exit 1; }
            if ! git clone https://github.com/1ndianl33t/Gf-Patterns "$HOME/.gf"; then
                echo -e "\033[0;31m[!] Failed to clone Gf-Patterns. Exiting...\033[0m"
                exit 1
            fi
            cp -n "$HOME/.gf/*.json" "$HOME/.gf/" >/dev/null 2>&1 || echo -e "\033[1;33m[i] Failed to copy json files. Proceeding...\033[0m"
        else
            echo -e "\033[0;32m[i] $HOME/.gf directory already exists. Skipping clone.\033[0m"
        fi
    else
        echo -e "\033[0;32m[i] gf: Installed\033[0m"
    fi
}

install_cmake() {
    if ! command_exists cmake; then
        echo -e "\033[0;31m[?] cmake: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing cmake...\033[0m"
        if ! sudo apt install cmake -y; then
            echo -e "\033[0;31m[!] Failed to install cmake. Exiting...\033[0m"
            exit 1
        fi
    fi
}

install_make() {
    if ! command_exists make; then
        echo -e "\033[0;31m[?] make: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing make...\033[0m"
        if ! sudo apt install make -y; then
            echo -e "\033[0;31m[!] Failed to install make. Exiting...\033[0m"
            exit 1
        fi
    fi
}

install_urldedupe() {
    if ! command_exists urldedupe; then
        echo -e "\033[0;31m[?] urldedupe: Not Installed\033[0m"
        echo -e "\033[1;33m[+] Installing urldedupe...\033[0m"
        if ! git clone https://github.com/ameenmaali/urldedupe.git; then
            echo -e "\033[0;31m[!] Failed to clone urldedupe. Exiting...\033[0m"
            exit 1
        fi
        cd urldedupe || exit
        if ! cmake CMakeLists.txt; then
            echo -e "\033[0;31m[!] cmake failed. Exiting...\033[0m"
            exit 1
        fi
        if ! make; then
            echo -e "\033[0;31m[!] make failed. Exiting...\033[0m"
            exit 1
        fi
        if ! sudo cp urldedupe /usr/bin/; then
            echo -e "\033[0;31m[!] Failed to copy urldedupe to /usr/bin/. Exiting...\033[0m"
            exit 1
        fi
        cd .. || exit
    else
        echo -e "\033[0;32m[i] urldedupe: Installed\033[0m"
    fi
}

get_website_url() {
    while true; do
        read -p "[?] Enter the URL of the website you want to scan: " website_url

        if [[ -z "$website_url" ]]; then
            echo -e "\033[0;31m[!] You must provide a valid URL.\033[0m"
            echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
            read -r
            clear
            display_welcome_message
        elif ! is_valid_url "$website_url"; then
            echo -e "\033[0;31m[!] You must provide a valid URL.\033[0m"
            echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
            read -r
            clear
            display_welcome_message
        else
            break
        fi
    done
}

get_filter() {
    while true; do
        read -p "[?] Enter the filter (e.g., xss): " filter

        if ! filter_exists "$filter"; then
            echo -e "\033[0;31m[!] You must provide a valid filter.\033[0m"
            echo -e "\033[1;33m[i] Press Enter to try again...\033[0m"
            read -r
            clear
            display_welcome_message
        else
            break
        fi
    done
}

perform_scan() {
    echo ""
    echo -e "\033[1;33m[i] Loading, Please Wait...\033[0m"
    sleep 3
    clear

    echo -e "\033[1;34m[i] Starting $filter scan for $website_url \033[0m"
    echo ""

    start_time=$(date +%s)
    total_found=0
    scan_output=$(echo "$website_url" | waybackurls | gf "$filter" | urldedupe)

    if [[ -z "$scan_output" ]]; then
        echo -e "\033[0;31m[!] No results found.\033[0m"
        echo ""
    else
        while IFS= read -r line; do
            echo -e "\033[0;32mFound:\033[0m \033[0;37m$line\033[0m"
            echo ""
            ((total_found++))
        done <<< "$scan_output"
    fi

    end_time=$(date +%s)
    elapsed_time=$((end_time - start_time))

    echo -e "\033[1;33m[i] Scanning finished!\033[0m"
    echo -e "\033[1;33m[i] Total Found: $total_found\033[0m"
    echo -e "\033[1;33m[i] Time Taken: ${elapsed_time} seconds.\033[0m"

    if [[ $total_found -gt 0 ]]; then
        echo ""
        read -p "[?] Do you want to save the vulnerable URLs to myURLs.txt? (y/n, press Enter for n): " save_choice
        if [[ "$save_choice" == "y" ]]; then
            if ! echo "$scan_output" > myURLs.txt; then
                echo -e "\033[0;31m[!] Failed to save URLs to myURLs.txt. Exiting...\033[0m"
                exit 1
            fi
            echo -e "\033[0;32m[+] URLs saved to myURLs.txt\033[0m"
        else
            echo -e "\033[1;33mVulnerable URLs will not be saved.\033[0m"
        fi
    fi
}

main() {
    clear
    echo -e "\033[1;33mChecking requirements...\033[0m"
    echo ""

    install_golang
    install_waybackurls
    install_gf
    install_cmake
    install_make
    install_urldedupe

    add_to_rc
    sleep 3
    clear

    display_welcome_message
    get_website_url
    get_filter
    perform_scan
}

main
