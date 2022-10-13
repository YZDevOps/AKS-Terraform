#### Parameters

$keyvaultname = "aksdemocluster-kv"
$location = "West Europe"
$keyvaultrg = "aksdemos-rg"
$sshkeysecret = "akssshpubkey"
$spnclientid = "983801e3-20b7-41fd-86ee-2d18aebc5b78"
$clientidkvsecretname = "spn-id"
$spnclientsecret = "U6Z8Q~IGEyGLHSB~uwAWBL4DL_eENUWfjDXz9cQG"
$spnkvsecretname = "spn-secret"
$spobjectID = "5e12627b-b889-45cd-b5c8-ebe2cb2da8d5"
$userobjectid = "d08f4a0a-cc4d-4d03-9a35-22e6822f9ed0"


#### Create Key Vault

New-AzResourceGroup -Name $keyvaultrg -Location $location

New-AzKeyVault -Name $keyvaultname -ResourceGroupName $keyvaultrg -Location $location

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -UserPrincipalName $userobjectid -PermissionsToSecrets get,set,delete,list

#### create an ssh key for setting up password-less login between agent nodes.

ssh-keygen  -f ~/.ssh/id_rsa_terraform


#### Add SSH Key in Azure Key vault secret

$pubkey = cat ~/.ssh/id_rsa_terraform.pub

$Secret = ConvertTo-SecureString -String $pubkey -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $sshkeysecret -SecretValue $Secret


#### Store service principal Client id in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientid -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $clientidkvsecretname -SecretValue $Secret


#### Store service principal Secret in Azure KeyVault

$Secret = ConvertTo-SecureString -String $spnclientsecret -AsPlainText -Force

Set-AzKeyVaultSecret -VaultName $keyvaultname -Name $spnkvsecretname -SecretValue $Secret


#### Provide Keyvault secret access to SPN using Keyvault access policy

Set-AzKeyVaultAccessPolicy -VaultName $keyvaultname -ServicePrincipalName $spobjectID -PermissionsToSecrets Get,Set
