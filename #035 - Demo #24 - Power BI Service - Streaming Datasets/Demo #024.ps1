$endpoint = "https://api.powerbi.com/beta/9d57c25b-f22d-423b-bb40-20b1a7a05f95/datasets/71468ddc-971d-483f-91da-506605aee601/rows?key=WofG9a7u3cUOyw4qodhiDJVsQwXmnbeigeIhPU6y%2Bs%2FbSwTe5XajmBHGPuSeVUy%2FVnctl4PZMY9UX8fjSBGfBQ%3D%3D"

while($true)
{
    ############################## Values #####################################

    $ComputerName = $env:computername
    $DomainName = (Get-WmiObject win32_computersystem).DNSHostName+"."+(Get-WmiObject win32_computersystem).Domain
    $IPAddress = (Get-NetIPConfiguration | Where-Object { $_.IPv4DefaultGateway -ne $null -and $_.NetAdapter.Status -ne "Disconnected" }).IPv4Address.IPAddress
    $Drives = Get-WmiObject -Class win32_Logicaldisk -ComputerName localhost |  
                      where {($_.DriveType -eq 3 -or $_.DriveType -eq 2) -and $_.FileSystem -ne $null } |  
                      Select -Property @{Name = 'Volume';Expression = {$_.DeviceID -replace ":",""}}, 
                                       @{Name = 'Size';Expression = { "{0:N2}" -f ($_.Size / 1gb) } }, 
                                       @{Name = 'FreeSpace';Expression = { "{0:N2}" -f ($_.FreeSpace / 1gb) } },
                                       @{Name = 'Free';Expression = { "{0:N2}%" -f (($_.FreeSpace/$_.Size) * 100) } }
    
    $CPU = (Get-WmiObject  -Class win32_processor -ErrorAction Stop | Measure-Object -Property LoadPercentage -Average | Select-Object Average).Average
    $ComputerMemory = Get-WmiObject  -Class win32_operatingsystem #-ErrorAction Stops 
    $TotalMemory = $ComputerMemory.TotalVisibleMemorySize / 1mb 
    $FreeMemory = $ComputerMemory.FreePhysicalMemory / 1mb 
    
    $UsedMemory = $TotalMemory - $FreeMemory
    $Memory = [math]::Round((($UsedMemory / $TotalMemory)*100), 2)

    $LogDate = Get-Date -DisplayHint Date -Format yyyy-MM-ddTHH:mm:ss


     ############################ Display ####################

        Write-Host "======>  Log Date: " $LogDate " <========"
        Write-Host "ComputerName => " $ComputerName
        Write-Host "DomainName => " $DomainName
        Write-Host "IPAddress => " $IPAddress

        Write-Host "Drives => " ($Drives | ConvertTo-Json )

        Write-Host "CPU => " $CPU"%"
    
        Write-Host "TotalMemory => " $TotalMemory
        Write-Host "FreeMemory => " $FreeMemory
        Write-Host "Memory => " $Memory"%"


    ############################ Send the data to the streaming dataset  ####################
 

 
     $payload = @{
        "LogDate" = $LogDate
        "DmonainName" = $DomainName
        "ComputerName" =  $ComputerName
        "IPAddress" = $IPAddress 
        "CPU" = $CPU
        "TotalMemory" = $TotalMemory
        "FreeMemory" = $FreeMemory
        "Memory" = $Memory
        "Drives" = ($Drives | ConvertTo-Json )  
    } 



    Invoke-RestMethod -Method Post -Uri "$endpoint" -Body (ConvertTo-Json @($payload)) 


    ############################ Add the log to the database ####################

     
    #Prepare Insert Statement
    $insert = @'
	    INSERT INTO [Monitoring].[dbo].[Resources] ([LogDate],[DomainName],[ComputerName],[IPAddress],[CPU],[TotalMemory],[FreeMemory],[Memory],[Drives])
	    VALUES ('{0}','{1}','{2}','{3}',{4},{5},{6},{7},'{8}')
'@

     try {
         #define connction string of target database
 	    $connectionstring = "data source=.;initial catalog=Monitoring;user id=zanoonlab;password=123456;"
         # connection object initialization
 	    $conn = new-object system.data.sqlclient.sqlconnection($connectionstring)
         #open the connection 
 	    $conn.open()
         # prepare the sql 
 	    $cmd = $conn.createcommand()
 		$cmd.commandtext = $insert -f $LogDate,$DomainName, $ComputerName,  $IPAddress, $CPU, $TotalMemory, $FreeMemory, $Memory, ($Drives | convertto-json)
 		$cmd.executenonquery() 
         #write-host $cmd.commandtext
 
         #close the connection
 	    $conn.close()
     }
     catch {
 	    throw $_
     }



    Sleep 1 #sec

}