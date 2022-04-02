$ErrorActionPreference = "Stop"

Get-WmiObject Win32_LogicalDisk | Where-Object { $_.DriveType -eq "3" } | Select-Object SystemName, 
@{ Name = "Drive" ; Expression = { ( $_.DeviceID ) } }, 
@{ Name = "Size (GB)" ; Expression = { "{0:N1}" -f ( $_.Size / 1gb) } }, 
@{ Name = "FreeSpace (GB)" ; Expression = { "{0:N1}" -f ( $_.Freespace / 1gb ) } }, 
@{ Name = "PercentFree" ; Expression = { "{0:P1}" -f ( $_.FreeSpace / $_.Size ) } } |
Format-Table -AutoSize | Out-String

# VS 2015
$qt_dirs = @{
    @("5.6", "5.6.3") = @(
        "mingw49_32"
        "msvc2013"
        "msvc2013_64"        
        "msvc2015"
        "msvc2015_64"
    )
    @("5.7") = @(
        "mingw53_32"     
        "msvc2015"
    )      
    @("5.9", "5.9.9") = @(
        "mingw53_32"
        "msvc2013_64"
        "msvc2015"
        "msvc2015_64"
    )
    @("5.10", "5.10.1") = @(
        "mingw53_32"
        "msvc2013_64"
        "msvc2015"
        "msvc2015_64"
    )
    @("5.11", "5.11.3") = @(
        "mingw53_32"
        "msvc2015"
        "msvc2015_64"
    )      
    @("5.12", "5.12.6") = @(
        "mingw73_32"
        "mingw73_64"
        "msvc2015_64"
    )
    @("5.13", "5.13.2", "latest") = @(
        "mingw73_32"
        "mingw73_64"
        "msvc2015_64"
    )
    @("tools") = @(
        "mingw492_32"
        "mingw530_32"
        "mingw730_32"
        "mingw730_64"
        "QtCreator"
        "QtInstallerFramework"
    )
    @("QtIFW2.0.1") = @(
        ""
    )
    @("QtIFW-3.0.1") = @(
        ""
    )    
}

# VS 2017
if (test-path "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community") {
    $qt_dirs = @{
        @("5.6", "5.6.3") = @(
            "mingw49_32"
            "msvc2015"
            "msvc2015_64"
        )    
        @("5.9", "5.9.9") = @(
            "mingw53_32"
            "msvc2015"
            "msvc2017_64"
        )
        @("5.10", "5.10.1") = @(
            "mingw53_32"
            "msvc2015"
            "msvc2017_64"
        )
        @("5.11", "5.11.3") = @(
            "mingw53_32"
            "msvc2015"
            "msvc2017_64"
        )      
        @("5.12", "5.12.6") = @(
            "mingw73_32"
            "mingw73_64"
            "msvc2017"
            "msvc2017_64"
        )
        @("5.13", "5.13.2", "latest") = @(
            "mingw73_32"
            "mingw73_64"
            "msvc2017"
            "msvc2017_64"
        )
        @("tools") = @(
            "mingw492_32"
            "mingw530_32"
            "mingw730_32"
            "mingw730_64"
            "QtCreator"
            "QtInstallerFramework"
        )
        @("QtIFW-3.0.1") = @(
            ""
        )    
    }
}

# VS 2019 or VS 2022
if ((test-path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community") -or
    (test-path "C:\Program Files (x86)\Microsoft Visual Studio\2019\Preview") -or
    (test-path "C:\Program Files\Microsoft Visual Studio\2022\Community")) {
    $qt_dirs = @{
        @("5.9", "5.9.9") = @(
            "mingw53_32"
            "msvc2015"
            "msvc2017_64"
        )
        @("5.15", "5.15.2", "latest") = @(
            "mingw81_32"
            "mingw81_64"
            "msvc2019"
            "msvc2019_64"
        )
        @("6.0", "6.0.4") = @(
            "mingw81_64"
            "msvc2019_64"
        )
        @("6.1", "6.1.3") = @(
            "mingw81_64"
            "msvc2019_64"
        )
        @("6.2", "6.2.4") = @(
            "mingw_64"
            "msvc2019_64"
        )
        @("6.3", "6.3.0") = @(
            "mingw_64"
            "msvc2019_64"
        )
        @("tools") = @(
            "mingw530_32"
            "mingw810_32"
            "mingw810_64"
            "mingw1120_64"
            "QtCreator"
            "QtInstallerFramework\4.3"
        )    
    }
}

foreach($qt_dir in $qt_dirs.GetEnumerator()) {
    foreach($qt_ver in $qt_dir.Key) {
        foreach($qt_sub_dir in $qt_dir.Value) {
            $fullPath = "C:\Qt\$qt_ver\$qt_sub_dir"
            Write-Host "$fullPath"
            if (-not (Test-Path $fullPath)) {
                throw "$fullPath not found"
            }
        }
    }
}
