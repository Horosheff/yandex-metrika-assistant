# Обмен кода подтверждения Яндекс OAuth на access_token (для API Метрики).
# 1) Откройте в браузере ссылку авторизации (response_type=code).
# 2) После входа скопируйте параметр "code" с verification_code.
# 3) Запустите скрипт и вставьте код.
#
# Секрет не храните в файле: передайте через переменную окружения или ввод.

$ErrorActionPreference = "Stop"

$clientId = $env:YANDEX_OAUTH_CLIENT_ID
if (-not $clientId) {
  $clientId = Read-Host "YANDEX_OAUTH_CLIENT_ID (или задайте env)"
}

$clientSecret = $env:YANDEX_OAUTH_CLIENT_SECRET
if (-not $clientSecret) {
  $secure = Read-Host "YANDEX_OAUTH_CLIENT_SECRET" -AsSecureString
  $ptr = [Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
  try { $clientSecret = [Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr) }
  finally { [Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr) }
}

$redirectUri = $env:YANDEX_OAUTH_REDIRECT_URI
if (-not $redirectUri) {
  $redirectUri = "https://oauth.yandex.ru/verification_code"
}

$code = Read-Host "Код подтверждения (из URL после авторизации)"
$code = $code.Trim()

$body = @{
  grant_type    = "authorization_code"
  code          = $code
  client_id     = $clientId
  client_secret = $clientSecret
  redirect_uri  = $redirectUri
}

try {
  $response = Invoke-RestMethod -Method Post -Uri "https://oauth.yandex.ru/token" `
    -ContentType "application/x-www-form-urlencoded" `
    -Body $body
} catch {
  Write-Host "Ошибка запроса:" -ForegroundColor Red
  if ($_.ErrorDetails.Message) { Write-Host $_.ErrorDetails.Message }
  throw
}

Write-Host ""
Write-Host "access_token (для заголовка Authorization: OAuth ...):" -ForegroundColor Green
Write-Host $response.access_token
Write-Host ""
if ($response.refresh_token) {
  Write-Host "refresh_token (сохраните для продления):" -ForegroundColor Cyan
  Write-Host $response.refresh_token
}
if ($response.expires_in) {
  Write-Host ""
  Write-Host "expires_in (сек): $($response.expires_in)"
}
if ($response.scope) {
  Write-Host "scope: $($response.scope)"
}
