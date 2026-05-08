# 1. VMware Network Configuration

## VMware Network Topology

| Network | Purpose                         | Subnet         |
| ------- | ------------------------------- | -------------- |
| VMnet1  | Internal Endpoint VLAN          | 172.16.10.0/24 |
| VMnet2  | SIEM Management VLAN            | 172.16.20.0/24 |
| VMnet8  | NAT / External Attacker Network | 192.168.1.0/24 |

---

## VMware Adapter Configuration

### FortiGate Interfaces

| Interface | Connected Network | IP Address    |
| --------- | ----------------- | ------------- |
| Port1     | VMnet8            | 192.168.1.100 |
| Port2     | VMnet1            | 172.16.10.1   |
| Port3     | VMnet2            | 172.16.20.1   |

---

## Endpoint Configuration

### Ubuntu Client

* Network Adapter: VMnet1
* IP Address: 172.16.10.2
* Gateway: 172.16.10.1

### Windows 10 Client

* Network Adapter: VMnet1
* IP Address: 172.16.10.3
* Gateway: 172.16.10.1

### Wazuh Manager

* Network Adapter: VMnet2
* IP Address: 172.16.20.2
* Gateway: 172.16.20.1

### Kali Linux Attacker

* Network Adapter: VMnet8
* IP Address: 192.168.1.200
* Gateway: 192.168.1.100

---

# 2. Wazuh SIEM Installation

## Install Wazuh All-in-One Server (Ubuntu)

Update packages:

```bash
sudo apt update && sudo apt upgrade -y
```

Install curl and unzip:

```bash
sudo apt install curl unzip -y
```

Download Wazuh installation assistant:

```bash
curl -sO https://packages.wazuh.com/4.7/wazuh-install.sh
```

Make script executable:

```bash
chmod +x wazuh-install.sh
```

Run Wazuh all-in-one installation:

```bash
sudo ./wazuh-install.sh -a
```

After installation completes, retrieve generated credentials:

```bash
sudo tar -O -xvf wazuh-install-files.tar wazuh-install-files/wazuh-passwords.txt
```

Access the Wazuh dashboard:

```text
https://<WAZUH_SERVER_IP>
```

Default username:

```text
admin
```

---

# 3. Configure FortiGate Syslog Forwarding

## Configure Syslog Settings

Navigate to:

```text
Log & Report → Log Settings
```

Enable:

* Remote Logging
* Syslog Forwarding

Set:

| Setting   | Value       |
| --------- | ----------- |
| Server IP | 172.16.20.2 |
| Port      | 514         |
| Mode      | UDP         |
|           |             |

---

# 4. Wazuh Agent Installation

## Ubuntu Agent Installation

Add Wazuh repository:

```bash
curl -s https://packages.wazuh.com/key/GPG-KEY-WAZUH | sudo apt-key add -
```

```bash
echo "deb https://packages.wazuh.com/4.x/apt/ stable main" | sudo tee /etc/apt/sources.list.d/wazuh.list
```

Update packages:

```bash
sudo apt update
```

Install agent:

```bash
sudo WAZUH_MANAGER='172.16.20.2' apt install wazuh-agent -y
```

Enable and start service:

```bash
sudo systemctl daemon-reload
sudo systemctl enable wazuh-agent
sudo systemctl start wazuh-agent
```

Check service status:

```bash
sudo systemctl status wazuh-agent
```

---

## Windows Agent Installation

Download Wazuh agent:

```text
https://packages.wazuh.com/4.x/windows/wazuh-agent-4.x.x-1.msi
```

Install using PowerShell:

```powershell
msiexec.exe /i wazuh-agent-4.x.x-1.msi /q WAZUH_MANAGER="172.16.20.2"
```

Start the agent service:

```powershell
NET START WazuhSvc
```

Verify service status:

```powershell
Get-Service WazuhSvc
```

---

# 5. Verify Agent Connectivity

On the Wazuh Manager:

```bash
sudo /var/ossec/bin/agent_control -l
```

Expected output:

```text
Ubuntu Agent - Active
Windows Agent - Active
```

---

# 6. Enable File Integrity Monitoring (FIM)

Edit:

```bash
/var/ossec/etc/ossec.conf
```

Example configuration:

```xml
<syscheck>
  <frequency>3600</frequency>
  <directories check_all="yes">/etc,/usr/bin</directories>
</syscheck>
```

Restart Wazuh manager:

```bash
sudo systemctl restart wazuh-manager
```

---

# 7. Enable Sysmon on Windows

Download Sysmon from Microsoft Sysinternals.

Install Sysmon:

```powershell
Sysmon64.exe -i
```

Verify logs appear inside Wazuh dashboard under:

```text
Security Events → Sysmon
```

---

# 8. Validation Checklist

| Task                       | Status    |
| -------------------------- | --------- |
| FortiGate reachable        | Completed |
| Wazuh dashboard accessible | Completed |
| Ubuntu agent connected     | Completed |
| Windows agent connected    | Completed |
| Syslog forwarding working  | Completed |
| FIM alerts generated       | Completed |
| Sysmon logs visible        | Completed |

---

# 9. Recommended Hardening

## Linux Hardening

* Disable root SSH login
* Configure Fail2Ban
* Limit sudo privileges
* Enforce strong password policies

## Windows Hardening

* Enable Windows Defender
* Restrict PowerShell execution
* Enable Firewall rules
* Apply local account lockout policy

## FortiGate Hardening

* Restrict SNMP access
* Disable unused services
* Configure IPS profiles
* Apply geo-blocking if required

---

# 10. Notes

This lab environment was created for educational and defensive cybersecurity purposes only.

The infrastructure demonstrates:

* SOC monitoring
* Incident response workflows
* Threat detection
* Log analysis
* Network segmentation
* Security hardening
* MITRE ATT&CK mapping
* NIST SP 800-61 implementation
