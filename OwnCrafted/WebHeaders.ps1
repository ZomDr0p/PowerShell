$url = Read-Host -Prompt 'Input an URL'
$req = [System.Net.WebRequest]::Create($url)

try{
$res = $req.GetResponse()
}catch [System.Net.WebException]{
$res = $_.Exception.Response
}
$res.Headers