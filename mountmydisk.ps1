$disks = Get-Disk | Where PartitionStyle -eq 'raw' | sort Number

$letters = 70..89 | ForEach-Object {[char]$_}
$count = 0
$labels = "data1","data2"

foreach($disk in $disks){
    $driverletter = $letters[$count].ToString()
    $disk |
    Initialize-Disk -PartitionStyle MBR -PassThru |
    New-Partition -UseMaximumSize -DriveLetter $driverletter |
    Format-Volume -FileSystem NTFS -NewFileSystemLabel $labels[$count] -Confirm:$false -Force
    $count++
}
