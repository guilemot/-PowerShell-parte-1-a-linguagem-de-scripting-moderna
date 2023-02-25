#Parameter of exportation
param($ExportType)

#Changing Error Action Preference from default to Stop
$ErrorActionPreference = "Stop"

#Hashable to list name of the files
$FileName = @{
	Label = "Nome do Arquivo";
	Expression = {$_.Name}
}
#Hashable to list size of the files in KB
$FileSize = @{
	Label = "Tamanho";
	Expression = {"{0:N2} KB" -f ($_.Length /1KB)}
}
#Creating Variables
$SelParam = $FileName, $FileSize

#Store result in a variable
$Result = 
gci -Recurse -File |
? Name -Like "*.pdf"|
Select $SelParam

if($ExportType -eq "HTML"){
	$Styles = Get-Content "C:\Styles.css"
	$StyleTag = "<style> $Styles </style>"
	$PageTitle = "Report of Downloaded Files"
	$PageBody = "<h1> $PageTitle </h1>"
		
	#Exportar result to a file
	$Result |
	ConvertTo-Html -Head $StyleTag -Title $PageTitle -Body $PageBody |
	Out-File C:\Users\guihf\Downloads\Alura_Project\Report.html

}elseif ($ExportType -eq "JSON"){
	$Result |
	ConvertTo-Json |
	Out-File C:\Users\guihf\Downloads\Alura_Project\Report.json
} elseif ($ExportType -eq "CSV"){
	$Result |
	ConvertTo-Csv |
	Out-File C:\Users\guihf\Downloads\Alura_Project\Report.csv
}
