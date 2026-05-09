![Wazuh](https://img.shields.io/badge/Wazuh-SIEM-blue)
![FortiGate](https://img.shields.io/badge/FortiGate-NGFW-red)
![MITRE ATT&CK](https://img.shields.io/badge/MITRE-ATT%26CK-green)
![NIST](https://img.shields.io/badge/NIST-SP800--61-orange)

# Enterprise Adversary Simulation & Detection Validation Lab

## MITRE ATT&CK Mapping | Attack Simulation | Detection Engineering

### Project Overview

Designed and deployed a full-scale enterprise security lab focused on adversary emulation, attack simulation, and detection validation across segmented environments. Developed as part of the Digital Egypt Pioneers Initiative (DEPI), the project demonstrates realistic offensive security techniques alongside defensive detection and incident response workflows.

The lab simulates a multi-stage attack chain including reconnaissance, brute-force attacks, privilege escalation, persistence, and lateral movement across Linux and Windows systems within a segmented VMware environment.

### Environment & Infrastructure

* FortiGate NGFW (v7.2.4)
* Wazuh SIEM & Log Analysis Platform
* Kali Linux Attacker Machine
* Ubuntu 22.04 Target System
* Windows 10 Target with Wazuh Agent
* Segmented VLAN Architecture with NAT and firewall policies


##  Project Visuals & Infrastructure

### Network Low Level Diagram (LLD)
![Network Low Level Diagram](./assets/network-lld.png)
*Detailed view of the segmented VMware environment and FortiGate routing.*

### Traffic Flow & Communication Matrix
![Traffic Flow](./assets/traffic-flow.png)

*Mapping of allowed services (SSH, Syslog, Wazuh Agent) across VLAN boundaries.*

### Asset Inventory
![Asset Inventory](./assets/asset-inventory.png)
*Endpoint classification including Ubuntu 22.04, Windows 10, and the Wazuh Manager.*

### Detailed FortiGate Interface Inventory
![FortiGate Interfaces](./assets/fortigate-interfaces.png)

---

## Cyber Attack Visualization

### Attack Flow Diagram (Kill Chain)
![Attack Kill Chain](./assets/attack-kill-chain.png)
*Visualization of the attack path from external reconnaissance to lateral movement.*

### Attack Timeline Visualization
![Attack Timeline](./assets/attack-timeline.png)
*A chronological mapping of attacker actions vs. SIEM detection alerts.*

---

### Attack Simulation & MITRE ATT&CK Mapping

Performed realistic attack scenarios mapped to the MITRE ATT&CK framework:

* Reconnaissance (T1592 / T1046)

  * Enumerated network information through weak SNMP configurations and service discovery.

* Initial Access (T1110.001)

  * Conducted SSH brute-force attacks using Hydra against Linux targets.

* Privilege Escalation (T1548.003)

  * Exploited sudo misconfigurations using GTFOBins techniques to gain root privileges.

* Persistence (T1136.001)

  * Established persistence via hidden administrative accounts and scheduled tasks.

* Lateral Movement (T1021.002)

  * Pivoted between Linux and Windows hosts through shared network services.

---

##  Defense & Incident Response
### 1. Detection & Analysis
Using the **Wazuh SIEM**, specific alerts were triggered and analyzed:
* **Rule 5712:** Detected SSHD authentication failure (Brute Force).
* **Rule 5402:** Detected successful `sudo` execution for unauthorized binaries.
* **Syslog Monitoring:** FortiGate logs captured the SNMP reconnaissance attempts.

### 2. Incident Response Playbooks
This repository includes detailed **NIST-aligned playbooks** developed during the project:
* **[Playbook: SSH Brute Force](./playbooks/ssh_brute_force.md):** Focuses on identification and automated blocking via Wazuh Active Response.
* **[Playbook: Privilege Escalation](./playbooks/priv_esc.md):** Detection of unauthorized `sudo` usage and session termination.
* **[Playbook: Network Scanning](./playbooks/net_scan.md):** Handling reconnaissance alerts and firewall policy hardening.

---

### Technical Skills Demonstrated

* Red Team Operations & Adversary Simulation
* Web & Network Reconnaissance
* Privilege Escalation Techniques
* Lateral Movement & Persistence
* Detection Engineering & SIEM Tuning
* FortiGate Firewall Administration
* Linux & Windows Security
* MITRE ATT&CK & NIST SP 800-61

---

##  Repository Structure
```

├── assets/                 # Architecture diagrams and screenshots
├── playbooks/              # NIST-mapped incident response playbooks
├── scripts/                # Detection and hardening scripts
├── attack_simulation.md    # Adversary emulation and attack commands
├── setup.md                # VMware, Wazuh, and FortiGate setup guide
├── documentation.pdf       # Full SOC investigation and IR report
└── README.md
