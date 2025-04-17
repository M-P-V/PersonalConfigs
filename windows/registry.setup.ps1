$configPath = Join-Path -Path $PSScriptRoot -ChildPath "\configs\registry.entries.json";
$regestryConfig = Get-Content $configPath | ConvertFrom-Json;

foreach($regestryStep in $regestryConfig){
  Write-Host "Regestring $($regestryStep.displayName)";
  try {
        foreach($obj in $regestryStep.keys) {
                Write-Host "Adding $($obj.name) key to the $($obj.path)";
		
		if(!(Test-Path $obj.path)){
			Write-Host "Creating $($obj.path) missing path";
			New-Item -Path $obj.path | Out-Null;
		}
                if($obj.name -ne $null){
                        Write-Host "Changing $($obj.name) key value";
                        Set-ItemProperty -Path $obj.path -Name $obj.name -Value $obj.value;
                        Write-Host "Key was added";
                }
           }
      }
  catch {
        Write-Host "Exception occured during registry update";
        Write-Error $_;
  }
}
