#!/bin/bash

# อัปเดตแพ็คเกจในระบบ
echo -e "\033[1;32m[+] Updating system packages...\033[0m"
apt-get update -y && apt-get upgrade -y

# ติดตั้งแพ็คเกจที่จำเป็น
echo -e "\033[1;32m[+] Installing necessary packages...\033[0m"
apt-get install -y curl wget vim ufw

# ตั้งค่าไฟร์วอลล์
echo -e "\033[1;32m[+] Setting up firewall...\033[0m"
ufw allow OpenSSH
ufw --force enable

# สร้างผู้ใช้ใหม่ (ในกรณีที่คุณต้องการผู้ใช้เพิ่มเติม)
NEW_USER="newuser"
PASSWORD="password123"
echo -e "\033[1;32m[+] Creating a new user: $NEW_USER...\033[0m"
useradd -m -s /bin/bash $NEW_USER
echo "$NEW_USER:$PASSWORD" | chpasswd
usermod -aG sudo $NEW_USER

# ตั้งค่า SSH (ปิดการเข้าถึง root ผ่าน SSH)
echo -e "\033[1;32m[+] Configuring SSH...\033[0m"
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart sshd

# แสดงข้อมูลสำคัญ
echo -e "\033[1;34m==================================================\033[0m"
echo -e "\033[1;33m   Please save this VPS account information\033[0m"
echo -e "\033[1;34m==================================================\033[0m"
echo -e "\033[1;36m   Username : $NEW_USER\033[0m"
echo -e "\033[1;36m   Password : $PASSWORD\033[0m"
echo -e "\033[1;34m==================================================\033[0m"

echo -e "\033[1;32m[+] Root.sh script execution completed.\033[0m"
