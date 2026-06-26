# ============================================
# Create EC2 SSH Key Pair
# ============================================

param(
    [string]$KeyName = "ec2"
)

$ErrorActionPreference = "Stop"

$SshFolder = Join-Path $HOME ".ssh"
$PrivateKey = Join-Path $SshFolder $KeyName
$PublicKey = "$PrivateKey.pub"

Write-Host ""
Write-Host "========================================="
Write-Host " EC2 SSH Key Pair Generator"
Write-Host "========================================="
Write-Host ""

# Create .ssh folder if it doesn't exist
if (!(Test-Path $SshFolder)) {
    Write-Host "Creating .ssh folder..."
    New-Item -ItemType Directory -Path $SshFolder -Force | Out-Null
}

# Check OpenSSH
if (!(Get-Command ssh-keygen -ErrorAction SilentlyContinue)) {
    Write-Host ""
    Write-Host "ERROR: OpenSSH (ssh-keygen) is not installed."
    Write-Host ""
    exit 1
}

# Check if key already exists
if ((Test-Path $PrivateKey) -and (Test-Path $PublicKey)) {

    Write-Host "SSH Key Pair already exists."
    Write-Host ""
    Write-Host "Private Key : $PrivateKey"
    Write-Host "Public Key  : $PublicKey"
    Write-Host ""

    exit 0
}

Write-Host "Generating SSH Key Pair..."
Write-Host ""

try {

    # Generate RSA 4096-bit key with NO passphrase
    $cmd = "ssh-keygen -t rsa -b 4096 -f `"$PrivateKey`" -N `"`""

    cmd.exe /c $cmd

    if ($LASTEXITCODE -ne 0) {
        throw "ssh-keygen exited with code $LASTEXITCODE"
    }

}
catch {

    Write-Host ""
    Write-Host "ERROR: Failed to generate SSH key."
    Write-Host $_.Exception.Message
    exit 1

}

# Verify files were created
if ((Test-Path $PrivateKey) -and (Test-Path $PublicKey)) {

    Write-Host ""
    Write-Host "========================================="
    Write-Host " SSH Key Pair Created Successfully"
    Write-Host "========================================="
    Write-Host ""
    Write-Host "Private Key : $PrivateKey"
    Write-Host "Public Key  : $PublicKey"
    Write-Host ""

}
else {

    Write-Host ""
    Write-Host "ERROR: SSH key files were not created."
    exit 1

}