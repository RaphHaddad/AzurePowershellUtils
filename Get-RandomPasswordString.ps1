param(
    [Parameter(Mandatory=$True)]
    [Int]
    $Length
)

$allowedNumsAscii = 48..57
$capitalLettersAscii = 65..90
$smallLettersAscii = 97..122

$allowedAscii = $allowedNumsAscii + $capitalLettersAscii + $smallLettersAscii
$allowedChars = '!','@','#', '%'

foreach ($asciiChar in $allowedAscii) {
    $allowedChars += [char]$asciiChar
}

$lastAllowedCharsIndex = $allowedChars.Length - 1

$password = ""
foreach ($int in (0..($Length-1))) {
    $randomCharIndex = Get-Random -Minimum 0 -Maximum ($lastAllowedCharsIndex)
    $password += $allowedChars[$randomCharIndex]
}

$password
