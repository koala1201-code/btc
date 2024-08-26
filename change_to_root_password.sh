#!/bin/bash

# ฟังก์ชันเพื่อเปลี่ยนรหัสผ่าน root
change_root_password() {
    echo "โปรดใส่รหัสผ่านใหม่สำหรับ root:"
    read -s new_password

    echo "ยืนยันรหัสผ่านใหม่:"
    read -s confirm_password

    if [ "$new_password" != "$confirm_password" ]; then
        echo "รหัสผ่านไม่ตรงกัน กรุณาลองอีกครั้ง" 1>&2
        return 1
    fi

    echo "root:$new_password" | chpasswd

    if [ $? -eq 0 ]; then
        echo "รหัสผ่านของ root ถูกเปลี่ยนเรียบร้อยแล้ว"
    else
        echo "เกิดข้อผิดพลาดในการเปลี่ยนรหัสผ่าน" 1>&2
        return 1
    fi
}

# ฟังก์ชันสำหรับแสดงกรอบและเมนู
show_menu() {
    clear
    echo "**************************************************"
    echo "*                เมนูการจัดการรหัสผ่าน           *"
    echo "**************************************************"
    echo "* 1. เปลี่ยนรหัสผ่าน root                        *"
    echo "* 2. ออกจากโปรแกรม                               *"
    echo "**************************************************"
    echo -n "กรุณาเลือกตัวเลือก [1-2]: "
}

# ตรวจสอบว่าถูกเรียกใช้ด้วยสิทธิ์ root หรือไม่
if [ "$(id -u)" != "0" ]; then
    echo "คุณต้องใช้สิทธิ์ root เพื่อเปลี่ยนรหัสผ่าน" 1>&2
    exit 1
fi

# เมนูหลัก
while true; do
    show_menu
    read -r choice
    case $choice in
        1)
            change_root_password
            ;;
        2)
            echo "ออกจากโปรแกรม"
            exit 0
            ;;
        *)
            echo "ตัวเลือกไม่ถูกต้อง กรุณาลองอีกครั้ง" 1>&2
            ;;
    esac
done
