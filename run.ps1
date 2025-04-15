$script = "S:\scripts\Kometa\kometa.py"

$libraries = @(
    "Filme",
    "Filme 4K",
    "Z Anime Filme",
    "Serien",
    "Z Anime Serien"
)

foreach ($lib in $libraries) {
    # Prepend-Name generieren
    $prepend = ($lib -replace '[^a-zA-Z0-9]', '_').ToLower()

    # Prüfen ob Prozess schon läuft
    $running = Get-Process python -ErrorAction SilentlyContinue | Where-Object {
        $_.Path -like "*python*" -and $_.StartInfo.Arguments -like "*$prepend*"
    }

    if ($running) {
        Write-Host "Läuft bereits: $lib ($prepend)"
        continue
    }

    try {
        Start-Process python -ArgumentList $script, "--run-libraries", "`"$lib`"", "--log-filename-prepend", $prepend -ErrorAction Stop
        Write-Host "Gestartet: $lib ($prepend)"
    } catch {
        Write-Host "Fehler beim Starten: $lib ($prepend) - $_"
    }
}


