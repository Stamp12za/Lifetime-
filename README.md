# MY LIFE ONLINE

เวอร์ชันออนไลน์ของ MY LIFE สำหรับ GitHub Pages + Supabase

## ต้องทำ 3 อย่าง

### 1) สร้าง Supabase project
สร้าง project ใหม่ แล้วเปิด SQL Editor

### 2) รัน `supabase.sql`
เปิดไฟล์ `supabase.sql` แล้วคัดลอกทั้งหมดไปวางใน Supabase SQL Editor จากนั้นกด Run

### 3) ใส่ Supabase URL + Publishable/Anon key
เปิด `index.html` แล้วค้นหา:

`YOUR_SUPABASE_URL`

และ

`YOUR_SUPABASE_PUBLISHABLE_KEY`

แทนด้วยค่าจาก Supabase Project Settings / API

**ห้ามใช้ `service_role` key ในเว็บ**

จากนั้นอัปโหลด `index.html` ขึ้น GitHub Pages

## Auth
เกมใช้ Supabase Auth แบบ email + password
ถ้า project เปิด email confirmation ผู้เล่นต้องกดยืนยันอีเมลก่อนเข้าสู่ระบบ

ตั้งค่า URL ของ GitHub Pages ใน Supabase Auth URL Configuration เช่น:
`https://STAMP12ZA.github.io/Life-sim/`

## สิ่งที่ได้
- สมัครสมาชิก / เข้าสู่ระบบ
- เซฟชีวิตบนคลาวด์แยกตามบัญชี
- เล่นต่อจากเครื่องอื่นได้
- Logout
- Leaderboard
- RLS ป้องกันไม่ให้ผู้เล่นอ่าน/แก้เซฟของบัญชีอื่น

## หมายเหตุเรื่องโกง
Leaderboard ในเวอร์ชันนี้เป็น client-side game จึงยังไม่ใช่ระบบ anti-cheat แบบเกมออนไลน์จริงจัง ผู้เล่นที่รู้วิธีใช้ DevTools อาจแก้ค่าที่ส่งขึ้น leaderboard ได้ ถ้าต้องการระบบกันโกงจริง ควรย้าย logic การคำนวณเดือน/เหตุการณ์/เงินไป Edge Function หรือ backend ที่เชื่อถือได้
