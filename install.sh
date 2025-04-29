#!/bin/bash

# Colors
RED='\033[0;31m'
DARK_RED='\033[38;5;88m'
YELLOW='\033[1;33m'
NC='\033[0m' # Reset

clear

 
echo -e "${DARK_RED}"
echo "███╗   ██╗██╗████████╗███████╗███╗   ██╗████████╗"
echo "████╗  ██║██║╚══██╔══╝██╔════╝████╗  ██║╚══██╔══╝"
echo "██╔██╗ ██║██║   ██║   █████╗  ██╔██╗ ██║   ██║   "
echo "██║╚██╗██║██║   ██║   ██╔══╝  ██║╚██╗██║   ██║   "
echo "██║ ╚████║██║   ██║   ███████╗██║ ╚████║   ██║   "
echo "╚═╝  ╚═══╝╚═╝   ╚═╝   ╚══════╝╚═╝  ╚═══╝   ╚═╝   "

echo -e "${DARK_RED}"
echo "D   D   O   S    -    D   E   F   L   E   C   T   E   R"
echo -e "${NC}"
 
echo -e "${YELLOW}Enterprise Hosting Support:${NC} https://discord.gg/V4uWMy8bfP"
echo -e "${YELLOW}Technical Community:${NC} https://discord.gg/TmFZNMWuDF"


echo -e "\n${RED}⚠️ SECURITY NOTICE: This script will make significant system changes! ⚠️${NC}\n"
sleep 1


echo -e "${RED}"
echo "┌────────────────────────────────────────────┐"
echo "│  1 - Install or Update NITENT DDoS Deflecter │"
echo "│  2 - Remove NITENT DDoS Deflecter            │"
echo "│  0 - Exit                                    │"
echo "└────────────────────────────────────────────┘"
echo -e "${NC}"

read -p "Select an option: " choice

INSTALL_DIR="/opt/nitent-ddos"
DEFLECTER_SCRIPT="ddos.sh"
DOWNLOAD_URL="https://raw.githubusercontent.com/NitentNode/NITENT-DDoS-Deflecter-/main/ddos.sh"  # Raw URL from GitHub

function install_or_update() {
    echo -e "${DARK_RED}[+] Checking system...${NC}"
    sleep 1
    if [ -d "$INSTALL_DIR" ]; then
        echo -e "${RED}[~] NITENT DDoS Deflecter already installed. Updating...${NC}"
    else
        echo -e "${RED}[+] Installing NITENT DDoS Deflecter...${NC}"
        sudo mkdir -p "$INSTALL_DIR"
    fi
    echo -e "${RED}[↓] Downloading script...${NC}"
    sudo curl -fsSL "$DOWNLOAD_URL" -o "$INSTALL_DIR/$DEFLECTER_SCRIPT"
    
    # Automatically give execute permissions and run the script
    sudo chmod +x "$INSTALL_DIR/$DEFLECTER_SCRIPT"
    echo -e "${RED}[✔] Permissions set. Launching Deflecter...${NC}"
    sudo bash "$INSTALL_DIR/$DEFLECTER_SCRIPT"
}

function uninstall() {
    echo -e "${RED}[-] Removing NITENT DDoS Deflecter...${NC}"
    sudo rm -rf "$INSTALL_DIR"
    sleep 1
    echo -e "${RED}[✔] Uninstalled successfully.${NC}"
}

case $choice in
    1)
        install_or_update
        ;;
    2)
        uninstall
        ;;
    0)
        echo -e "${YELLOW}Exit. Stay protected with NITENT.${NC}"
        ;;
    *)
        echo -e "${RED}Invalid choice. Exiting.${NC}"
        ;;
esac
