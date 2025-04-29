#!/bin/bash


THRESHOLD=100
LOG_FILE="ddos_log.txt"
CHECK_INTERVAL=10
BLOCKED_IPS_FILE="blocked_ips.txt"


RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'


display_header() {
    clear
    echo -e "${CYAN}============================================"
    echo -e "         NITENT DDOS PROTECTION v1.2"
    echo -e "============================================${NC}"
}


block_ip() {
    local ip="$1"
    if iptables -C INPUT -s "$ip" -j DROP &>/dev/null; then
        echo -e "${YELLOW}[!] IP $ip is already blocked.${NC}"
    else
        iptables -A INPUT -s "$ip" -j DROP
        echo "$ip" >> "$BLOCKED_IPS_FILE"
        echo -e "${GREEN}[+] Blocked IP: $ip${NC}"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Blocked IP: $ip" >> "$LOG_FILE"
    fi
}


unblock_ip_menu() {
    blocked_ips=$(cat "$BLOCKED_IPS_FILE")
    if [ -z "$blocked_ips" ]; then
        echo -e "${YELLOW}[!] No IPs currently blocked.${NC}"
        sleep 2
        return
    fi

    ip=$(dialog --menu "Blocked IPs" 15 50 8 $(echo "$blocked_ips" | nl -w2 -s' ' | awk '{print $1, $2}') 3>&1 1>&2 2>&3)
    if [ -n "$ip" ]; then
        selected_ip=$(echo "$blocked_ips" | sed -n "${ip}p")
        iptables -D INPUT -s "$selected_ip" -j DROP
        grep -v "$selected_ip" "$BLOCKED_IPS_FILE" > temp && mv temp "$BLOCKED_IPS_FILE"
        echo -e "${GREEN}[+] Unblocked IP: $selected_ip${NC}"
        echo "$(date '+%Y-%m-%d %H:%M:%S') - Unblocked IP: $selected_ip" >> "$LOG_FILE"
    fi
}


manual_block_ip() {
    ip=$(dialog --inputbox "Enter IP to block:" 8 40 3>&1 1>&2 2>&3)
    if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
        block_ip "$ip"
    else
        echo -e "${RED}[!] Invalid IP address.${NC}"
    fi
}


show_blocked_ips() {
    echo -e "${YELLOW}[Blocked IPs]${NC}"
    if [[ -f "$BLOCKED_IPS_FILE" ]]; then
        cat "$BLOCKED_IPS_FILE"
    else
        echo -e "${RED}No blocked IPs recorded yet.${NC}"
    fi
    read -p "Press Enter to return..."
}


ddos_monitoring() {
    echo -e "${CYAN}[*] Live DDoS Monitoring Started... Press Ctrl+C to stop.${NC}"
    while true; do
        clear
        echo -e "${CYAN}========== LIVE CONNECTION MONITOR ==========${NC}"
        echo -e "${YELLOW}Incoming Connections (Remote ➜ Local):${NC}"
        ss -ntu state established | awk 'NR>1 {split($5,a,":"); split($4,b,":"); printf "%-20s ➜ %-20s\n", a[1] ":" a[2], b[1] ":" b[2]}'         | sort | uniq -c | sort -nr         | while read count line; do
            ip=$(echo "$line" | cut -d: -f1)
            echo -e "${RED}🔻 [$count]${NC} $line"
            if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ && "$count" -gt "$THRESHOLD" ]]; then
                echo -e "${RED}[!] DDoS Alert: $ip has $count connections! Blocking...${NC}"
                echo "$(date '+%Y-%m-%d %H:%M:%S') - $ip exceeded $count connections" >> "$LOG_FILE"
                block_ip "$ip"
            fi
        done

        echo -e "\n${GREEN}Outgoing Connections (Local ➜ Remote):${NC}"
        ss -ntu state established | awk 'NR>1 {split($4,a,":"); split($5,b,":"); printf "%-20s ➜ %-20s\n", a[1] ":" a[2], b[1] ":" b[2]}'         | sort | uniq -c | sort -nr         | while read count line; do
            echo -e "${GREEN}🔺 [$count]${NC} $line"
        done

        echo -e "${CYAN}=============================================${NC}"
        sleep "$CHECK_INTERVAL"
    done
}


vps_optimization() {
    echo -e "${CYAN}[+] Running VPS Optimization Script from Nitent...${NC}"
    bash <(curl -s https://raw.githubusercontent.com/NitentNode/Nitent-Node-VPS-Optimizer/main/install.sh)
    read -p "Press Enter to return..."
}


main_menu() {
    while true; do
        display_header
        echo -e "${CYAN}1.${NC} DDoS Monitoring (Auto IP Block)"
        echo -e "${CYAN}2.${NC} Manually Block an IP"
        echo -e "${CYAN}3.${NC} Manually Unblock IP"
        echo -e "${CYAN}4.${NC} View Blocked IP List"
        echo -e "${CYAN}5.${NC} VPS Optimization & DDoS Hardening"
        echo -e "${CYAN}6.${NC} Exit"
        echo -ne "${YELLOW}Select an option: ${NC}"
        read choice
        case $choice in
            1) ddos_monitoring ;;
            2) manual_block_ip ;;
            3) unblock_ip_menu ;;
            4) show_blocked_ips ;;
            5) vps_optimization ;;
            6) exit ;;
            *) echo -e "${RED}[!] Invalid option.${NC}" ;;
        esac
    done
}


main_menu
