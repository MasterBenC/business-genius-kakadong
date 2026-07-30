$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest

$root = Split-Path -Parent $PSScriptRoot
$skillPath = Join-Path $root 'skills/business-genius-kakadong/SKILL.md'
$readmePath = Join-Path $root 'skills/business-genius-kakadong/README.md'
$casesPath = Join-Path $root 'skills/business-genius-kakadong/evals/cases.json'
$safetyCasesPath = Join-Path $root 'skills/business-genius-kakadong/evals/safety-cases.json'
$personaPath = Join-Path $root 'skills/business-genius-kakadong/references/persona.md'
$bpReferencePath = Join-Path $root 'skills/business-genius-kakadong/references/investor-bp.md'
$bpCasesPath = Join-Path $root 'skills/business-genius-kakadong/evals/bp-cases.json'
$bpExamplePath = Join-Path $root 'skills/business-genius-kakadong/examples/investor-bp-operating.md'
$rootReadmePath = Join-Path $root 'README.md'

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

Assert-True (Test-Path -LiteralPath $personaPath) 'Persona reference must exist.'

$persona = Get-Content -Raw -Encoding UTF8 $personaPath
foreach ($term in @(
    'commercial-assessment',
    'investor-bp',
    'kakadong-persona',
    'agent-voice',
    'artifact-voice'
)) {
    Assert-Contains ($skill + $persona) $term "Skill and persona contract must contain '$term'."
}
Assert-Contains $persona 'professional-but-warm' 'Persona must be professional but warm.'
Assert-Contains $persona 'one-question-at-a-time' 'Persona must ask one question at a time.'
Assert-Contains $persona 'no-empty-encouragement' 'Persona must forbid empty encouragement.'

Assert-True (Test-Path -LiteralPath $bpReferencePath) 'Investor BP reference must exist.'
Assert-True (Test-Path -LiteralPath $bpCasesPath) 'Investor BP cases must exist.'
Assert-True (Test-Path -LiteralPath $bpExamplePath) 'Investor BP example must exist.'

$bp = Get-Content -Raw -Encoding UTF8 $bpReferencePath
$bpCases = Get-Content -Raw -Encoding UTF8 $bpCasesPath | ConvertFrom-Json
$rootReadme = Get-Content -Raw -Encoding UTF8 $rootReadmePath

foreach ($term in @(
    'InvestorBPInput',
    'InvestorSummary',
    'SlideBrief',
    'user-supplied-data-only',
    'no-automatic-web-research',
    'angel-lens',
    'institution-lens',
    'validation-version',
    'gap-only'
)) {
    Assert-Contains $bp $term "Investor BP contract must contain '$term'."
}

Assert-True ($bpCases.Count -eq 6) 'Investor BP evaluations must contain six cases.'
$requiredKinds = @('full-bp','validation-bp','gap-only','missing-source','data-conflict','safety-refusal')
foreach ($kind in $requiredKinds) {
    Assert-True (($bpCases.kind | Sort-Object -Unique) -contains $kind) "Investor BP evaluation kind '$kind' is required."
}
foreach ($case in $bpCases) {
    Assert-True ($null -ne $case.input_facts) "BP case $($case.id) must include input facts."
    Assert-True ($null -ne $case.expected_assertions) "BP case $($case.id) must include expected assertions."
}

foreach ($term in @(
    'investor-bp',
    '12-slide',
    'user-supplied-data-only',
    'no-PPTX-generation',
    'kakadong-persona'
)) {
    Assert-Contains ($rootReadme + $readme) $term "Public docs must contain '$term'."
}

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
