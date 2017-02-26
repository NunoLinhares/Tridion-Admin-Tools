<#
**************************************************
* Public members
**************************************************
#>


Function Get-TridionEventSystemExtensions
{
    <#
    .Synopsis
    Gets a list of assemblies currently defined as Event System Extensions in Tridion

    .Description
    Looks at the configuration in Tridion.ContentManager.Config and determines which assemblies are currently listed as Event System Extensions.

    .Notes
    It will only work on a machine with Tridion installed.

    .Inputs
    None.

    .Outputs
    Returns a list of files.

    .Example
    Get-TridionEventSystemExtensions

    #>

    Begin
    {
        Write-Debug "Starting to parse Tridion.ContentManager.Config";
        $TridionPath = $env:TRIDION_CM_HOME;
        if($TridionPath -eq $null)
        {
            Write-Error "Could not read environment variable TRIDION_CM_HOME - exiting";
            exit;
        }
       
    }

    Process
    {
        Write-Debug "Found Tridion root at $TridionPath";
        $configPath = $TridionPath + "Config\Tridion.ContentManager.Config";
        [xml] $TCMConfig = Get-Content $configPath;
        foreach($node in $TCMConfig.configuration.extensions.add)
        {
            Write-Host "==========================================================";
            $asm = $null;
            if($node.assemblyFileName -ne $null) 
            { 
                Write-Host "File: " $node.assemblyFileName;

                $asm = [Reflection.Assembly]::LoadFile($node.assemblyFileName);
                
            }
            

            if($node.assemblyName -ne $null) 
            { 
                Write-Host "Assembly: " $node.assemblyName;
                $asm = [Reflection.Assembly]::Load($node.assemblyName);
            }
            Write-Host "==========================================================";
           


            if($asm -ne $null)
            {
             #   $asm.GetTypes() | ?{$_.IsPublic} | ?{$_.BaseType.FullName -eq "Tridion.ContentManager.Extensibility.TcmExtension"} | select DeclaredMethods | sort BaseType | ft -groupby BaseType
            }

            foreach($type in $asm.GetTypes())
            {
                if($type.IsPublic)
                {
                    if($type.BaseType.FullName -eq "Tridion.ContentManager.Extensibility.TcmExtension")
                    {
                        foreach($method in $type.DeclaredMethods)
                        {
                            $isEvent = $false;
                            $hasTridionSubject = $false;
                            $hasEventPhase = $false;
                            $hasArgs = $false;
                            if($method.GetParameters().Count -eq 3)
                            {
                                $message = "";

                                #Write-Host $method.Name
                                foreach($parameter in $method.GetParameters())
                                {
                                    #Write-Host "  " $parameter.ParameterType.FullName;
                                    if($parameter.ParameterType.FullName.StartsWith("Tridion.ContentManager")) { $hasTridionSubject = $true }
                                    if($parameter.ParameterType.FullName.EndsWith("EventArgs")) { $hasArgs = $true }
                                    if($parameter.ParameterType.FullName.EndsWith("EventPhases")) { $hasEventPhase = $true }
                                }
                                
                                #Write-Host $parameters[0];

                                if($hasTridionSubject -and $hasArgs -and $hasEventPhase)
                                {
                                    $isEvent = $true;
                                }

                                if($isEvent)
                                {
                                    $message = " Method ";
                                    $message += $method.Name;
                                    $message += " extends object ";
                                    $message += $method.GetParameters()[0].ParameterType.Name;
                                    $message += " on ";
                                    $message += $method.GetParameters()[1].ParameterType.Name.Replace("EventArgs", "");
                                    #$message += " in phase ";
                                    #$message += $method.GetParameters()[2].ParameterType.Name;
                                    Write-Host $message;
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}


Get-TridionEventSystemExtensions
