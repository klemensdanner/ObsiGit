# Ordnerstruktur:
#   UE{i}\abgabe -> hier liegt das Skript + pas + PDFs
#   "i" wird zwei Ebenen höher aus dem Ordnernamen geholt

# -----------------------------
# UE-Nummer aus Ordnername lesen
# -----------------------------
$ueFolder = Split-Path (Split-Path $PSScriptRoot -Parent) -Leaf
# Falls Ordnername "UE3" ist, Nummer extrahieren:
$ueNumber = ($ueFolder -replace '\D','')

if (-not $ueNumber) {
    Write-Host "Konnte UE-Nummer nicht aus Ordner '$ueFolder' bestimmen." -ForegroundColor Red
    exit
}

# -----------------------------
# Dateinamen erzeugen
# -----------------------------
$zipName = "G1_Ue${ueNumber}_Danner_Klemens.zip"
$mergedPdf = "G1_Ue${ueNumber}_Danner_Klemens.pdf"

# -----------------------------
# 1. Alle .pas Dateien zippen
# -----------------------------
Compress-Archive -Path "$PSScriptRoot\*.pas" -DestinationPath "$PSScriptRoot\$zipName" -Force

Write-Host "ZIP erstellt: $zipName"

# -----------------------------
# 2. PDF mergen (pdftk muss installiert sein)
#    PRO1*.pdf  +  UE{i}.pdf
# -----------------------------
$proPdf = Get-ChildItem "$PSScriptRoot" -Filter "PRO1*.pdf" | Select-Object -First 1
$uePdf = Get-ChildItem "$PSScriptRoot" -Filter "UE$ueNumber*.pdf" | Select-Object -First 1

if (-not $proPdf -or -not $uePdf) {
    Write-Host "Eine der PDFs fehlt! Gefunden:" -ForegroundColor Red
    Write-Host "PRO1*: $proPdf"
    Write-Host "UE$ueNumber*: $uePdf"
    exit
}

# Merge Befehl
pdftk $proPdf.FullName $uePdf.FullName cat output "$PSScriptRoot\$mergedPdf"

Write-Host "PDF gemerged: $mergedPdf"
