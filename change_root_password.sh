#!/bin/bash

# ตรวจสอบว่าถูกเรียกใช้ด้วยสิทธิ์ root หรือไม่
if [ "$(id -u)" != "0" ]; then
   echo "คุณต้องใช้สิทธิ์ root เพื่อเปลี่ยนรหัสผ่าน" 1>&2
   exit 1
fi

# ขอให้ผู้ใช้ใส่รหัสผ่านใหม่
echo "โปรดใส่รหัสผ่านใหม่สำหรับ root:"
read -s new_password

# ยืนยันรหัสผ่าน
echo "ยืนยันรหัสผ่านใหม่:"
read -s confirm_password

# ตรวจสอบว่ารหัสผ่านที่ใส่ตรงกันหรือไม่
if [ "$new_password" != "$confirm_password" ]; then
    echo "รหัสผ่านไม่ตรงกัน กรุณาลองอีกครั้ง" 1>&2
    exit 1
fi

# ใช้คำสั่ง passwd เพื่อเปลี่ยนรหัสผ่าน root
echo "root:$new_password" | chpasswd

if [ $? -eq 0 ]; then
    echo "รหัสผ่านของ root ถูกเปลี่ยนเรียบร้อยแล้ว"
else
    echo "เกิดข้อผิดพลาดในการเปลี่ยนรหัสผ่าน" 1>&2
    exit 1
fi
