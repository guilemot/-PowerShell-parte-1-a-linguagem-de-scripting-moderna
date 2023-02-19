$FileName = @{
	Label = "Nome do Arquivo";
	Expression = {$_.Name}
}

$FileSize = @{
	Label = "Tamanho";
	Expression = {"{0:N2} KB" -f ($_.Length /1KB)}
}

$SelParam = $FileName, $FileSize

gci -Recurse -File |
? Name -Like "*.pdf"|
Select $SelParam
