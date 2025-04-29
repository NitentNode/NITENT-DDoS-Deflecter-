

```markdown
# Nitent DDoS Protection Tool

## Overview
The **Nitent DDoS Protection Tool** is designed to monitor and protect your Linux server from potential DDoS (Distributed Denial of Service) attacks. This tool provides real-time monitoring of incoming and outgoing traffic, automatically blocks suspicious IP addresses, and allows you to manage blocked IPs manually. It is a useful tool for securing your VPS or server from high-volume traffic that could lead to downtime or server overload.

This tool offers various features including automatic DDoS detection, IP blocking, and a professional menu interface to easily manage your server's security.

## Features
- **DDoS Monitoring**: Monitors incoming and outgoing traffic in real-time.
- **Automatic IP Blocking**: Automatically blocks IPs that exceed a specified connection threshold.
- **Manual IP Management**: Manually block or unblock IP addresses.
- **VPS Optimization**: Option to optimize your server with one simple command for better performance.
- **Live Connection Display**: See real-time active connections with incoming and outgoing traffic details.
- **Logging**: Logs blocked IPs and actions for future reference.
- **Color-coded Interface**: Color-coded terminal output for easy identification of actions and status.

## Prerequisites
- A **Linux-based VPS or Server** running Ubuntu/Debian/CentOS.
- **iptables** installed for firewall management.
- Basic knowledge of how to use the Linux terminal.

## Installation

1. Download the script to your server:
   ```bash
   wget https://github.com/NitentNode/Nitent-DDoS-Protect/raw/main/ddos.sh
   ```

2. Make the script executable:
   ```bash
   chmod +x ddos.sh
   ```

3. Run the script:
   ```bash
   ./ddos.sh
   ```

4. Optionally, optimize your server with the following command:
   ```bash
   bash <(curl -s https://raw.githubusercontent.com/NitentNode/Nitent-Node-VPS-Optimizer/main/install.sh)
   ```

## Usage

Once the script is executed, you will see a main menu with the following options:
1. **DDoS Monitoring (Auto IP Block)**: Starts the DDoS monitoring and automatically blocks IPs that exceed the connection threshold.
2. **Manually Block an IP**: Block a specific IP address.
3. **Manually Unblock IP**: Unblock a previously blocked IP address.
4. **Exit**: Exit the script.

### DDoS Monitoring
The tool continuously monitors incoming and outgoing traffic, identifies potential DDoS threats, and blocks malicious IP addresses based on a defined threshold. All blocked IPs are logged and can be reviewed later.

### VPS Optimization
The script provides an option to optimize your VPS, which enhances server performance and adds layers of protection against DDoS attacks.

## Disclaimer

By utilizing this tool, you expressly acknowledge and assume full responsibility for any risks, consequences, or damages that may arise from improper usage, execution, or configuration.

Proceed with caution and diligence.

Any modifications made to your server using this tool are done entirely at your own risk.

We strongly recommend thorough testing before applying changes to production systems.

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details.

## Support

For support or questions, please feel free to open an issue or contact the developer at:

**raju**, Owner of Nitent Node

---
