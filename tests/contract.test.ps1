$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$skillPath = Join-Path $root 'skills/business-genius-kakadong/SKILL.md'
$readmePath = Join-Path $root 'skills/business-genius-kakadong/README.md'
$casesPath = Join-Path $root 'skills/business-genius-kakadong/evals/cases.json'
$safetyCasesPath = Join-Path $root 'skills/business-genius-kakadong/evals/safety-cases.json'

function Assert-True {
    param(
        [bool]$Condition,
        [string]$Message
    )

    if (-not $Condition) {
        throw "ASSERTION FAILED: $Message"
    }
}

function Assert-Contains {
    param(
        [string]$Text,
        [string]$Needle,
        [string]$Message
    )

    Assert-True ($Text.Contains($Needle)) $Message
}

Assert-True (Test-Path -LiteralPath $skillPath) 'SKILL.md must exist.'
Assert-True (Test-Path -LiteralPath $readmePath) 'README.md must exist.'
Assert-True (Test-Path -LiteralPath $casesPath) 'Evaluation cases must exist.'
Assert-True (Test-Path -LiteralPath $safetyCasesPath) 'Safety evaluation cases must exist.'

$skill = Get-Content -Raw -Encoding UTF8 $skillPath
$readme = Get-Content -Raw -Encoding UTF8 $readmePath
$cases = Get-Content -Raw -Encoding UTF8 $casesPath | ConvertFrom-Json
$safetyCases = Get-Content -Raw -Encoding UTF8 $safetyCasesPath | ConvertFrom-Json

foreach ($term in @(
    'business-genius-kakadong',
    'AI OPC',
    'idea-stage',
    'operating-stage',
    'service-model',
    'product-model',
    'occurred',
    'material',
    'to-validate',
    'continue',
    'adjust-and-continue',
    'validate-first',
    'pause',
    'seven-day-action',
    'explicit-consent',
    'no-raw-material-storage',
    'safety-boundary',
    'Safety refusal path',
    'Contradiction path',
    'CC BY-NC 4.0'
)) {
    Assert-Contains $skill $term "SKILL.md must contain '$term'."
}

Assert-True (-not $skill.Contains('total score')) 'The Skill must not use a total score as its primary output.'
Assert-True ($cases.Count -eq 4) 'There must be exactly four branch evaluation cases.'
Assert-True (($cases.stage | Sort-Object -Unique).Count -eq 2) 'Cases must cover two stages.'
Assert-True (($cases.model | Sort-Object -Unique).Count -eq 2) 'Cases must cover two business models.'
foreach ($case in $cases) {
    Assert-True ($null -ne $case.input_facts) "Case $($case.id) must include input facts."
    Assert-True ($null -ne $case.expected_assertions) "Case $($case.id) must include expected assertions."
    Assert-True ($case.expected_assertions.verdict -eq $case.expected_verdict) "Case $($case.id) verdict assertion must match expected_verdict."
}
Assert-True ($safetyCases.Count -ge 2) 'Safety cases must cover refusal and contradiction paths.'
Assert-True (($safetyCases.kind | Sort-Object -Unique) -contains 'safety-refusal') 'A safety refusal case is required.'
Assert-True (($safetyCases.kind | Sort-Object -Unique) -contains 'data-conflict') 'A data conflict case is required.'
foreach ($case in $safetyCases) {
    Assert-True ($null -ne $case.expected_assertions) "Safety case $($case.id) must include expected assertions."
}

Assert-Contains $readme 'public-free' 'README must state the public free distribution scope.'
Assert-Contains $readme 'non-commercial' 'README must state the current non-commercial boundary.'

Write-Output 'PASS: business-genius-kakadong contract'
