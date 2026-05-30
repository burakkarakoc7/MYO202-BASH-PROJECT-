#!/bin/bash
# Burak Karakoç
# 2420191012
#https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=bx1hL8dmv4
#https://www.btkakademi.gov.tr/portal/certificate/validate?certificateId=0Koh8evW6v
#https://credsverse.com/credentials/1dbbf13f-55de-49e9-bdc2-3d0477de5d74



read -p "şifreyi giriniz: " SIFRE
SIFRE=$(echo "$SIFRE" | tr -d '\r')
echo ""

if [ "$SIFRE" != "MYO+202" ]; then
    echo "hatalı,sifre."
    exit 1
fi
echo "dogru"

DOSYA="report.log"
TARIH=$(date -Iseconds)

echo "calisma zamani: $TARIH" > $DOSYA


echo "işlemci" >> $DOSYA
wmic.exe cpu get name >> $DOSYA 

echo "RAM" >> $DOSYA
wmic.exe computersystem get totalphysicalmemory >> $DOSYA 

echo "anakart" >> $DOSYA
wmic.exe baseboard get product,Manufacturer >> $DOSYA 

echo "disk seri no" >> $DOSYA
wmic.exe diskdrive get serialnumber >> $DOSYA 

echo "disk turu (SSD/HDD)" >> $DOSYA
wmic.exe '/namespace:\\root\microsoft\windows\storage' path MSFT_PhysicalDisk get FriendlyName,MediaType >> $DOSYA

echo "mac adress" >> $DOSYA
getmac.exe >> $DOSYA 

echo "Bilgiler dosyaya yazıldı, şifreleme başlatılıyor"

gpg --symmetric --batch --yes --cipher-algo AES256 --passphrase "$SIFRE" $DOSYA

rm $DOSYA

echo "işlem tamamlandi"