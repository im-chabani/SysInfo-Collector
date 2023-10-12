# Function to get computer information
function Get-ComputerInfo {
    $brand = (Get-WmiObject -Class Win32_ComputerSystem).Manufacturer
    $model = (Get-WmiObject -Class Win32_ComputerSystem).Model
    $OS = (Get-WmiObject -Class Win32_OperatingSystem).Caption
    $serialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber
    $computerName = $env:COMPUTERNAME
    $currentUser = $env:USERNAME

    $computerInfo = @{
        "Brand" = $brand
        "Model" = $model
        "OS" = $OS
        "SerialNumber" = $serialNumber
        "ComputerName" = $computerName
        "CurrentUser" = $currentUser
    }

    return $computerInfo
}

$currentpath = Get-Location

$computerInfo = Get-ComputerInfo

$fileName = "ComputerInfo_$($computerInfo['CurrentUser']).txt"

$computerInfo | Out-File (Join-Path -Path $currentpath -ChildPath $fileName)
