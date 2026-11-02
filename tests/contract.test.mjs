import assert from 'node:assert/strict';
import { readFileSync, existsSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import test from 'node:test';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const skillPath = join(root, 'skills/business-genius-kakadong/SKILL.md');
const readmePath = join(root, 'skills/business-genius-kakadong/README.md');
const casesPath = join(root, 'skills/business-genius-kakadong/evals/cases.json');
const safetyCasesPath = join(root, 'skills/business-genius-kakadong/evals/safety-cases.json');
const personaPath = join(root, 'skills/business-genius-kakadong/references/persona.md');
const bpReferencePath = join(root, 'skills/business-genius-kakadong/references/investor-bp.md');
const kbMountPath = join(root, 'skills/business-genius-kakadong/references/kb-mount.md');
const bpCasesPath = join(root, 'skills/business-genius-kakadong/evals/bp-cases.json');
const bpExamplePath = join(root, 'skills/business-genius-kakadong/examples/investor-bp-operating.md');
const rootReadmePath = join(root, 'README.md');
const changelogPath = join(root, 'CHANGELOG.md');

const read = (p) => readFileSync(p, 'utf8');

test('required files exist', () => {
  for (const p of [
    skillPath, readmePath, casesPath, safetyCasesPath, personaPath,
    bpReferencePath, kbMountPath, bpCasesPath, bpExamplePath, rootReadmePath, changelogPath,
  ]) {
    assert.ok(existsSync(p), `missing ${p}`);
  }
});

test('persona and mode contract terms', () => {
  const blob = read(skillPath) + read(personaPath);
  for (const term of [
    'commercial-assessment', 'investor-bp', 'kakadong-persona', 'agent-voice', 'artifact-voice',
  ]) {
    assert.ok(blob.includes(term), term);
  }
  const persona = read(personaPath);
  assert.ok(persona.includes('professional-but-warm'));
  assert.ok(persona.includes('one-question-at-a-time'));
  assert.ok(persona.includes('no-empty-encouragement'));
});

test('investor BP contract', () => {
  const bp = read(bpReferencePath);
  for (const term of [
    'InvestorBPInput', 'InvestorSummary', 'SlideBrief', 'user-supplied-data-only',
    'no-automatic-web-research', 'angel-lens', 'institution-lens', 'validation-version', 'gap-only',
  ]) {
    assert.ok(bp.includes(term), term);
  }
  assert.ok(bp.includes('kb-mount.md'));
  const bpCases = JSON.parse(read(bpCasesPath));
  assert.equal(bpCases.length, 6);
  const kinds = new Set(bpCases.map((c) => c.kind));
  for (const kind of ['full-bp', 'validation-bp', 'gap-only', 'missing-source', 'data-conflict', 'safety-refusal']) {
    assert.ok(kinds.has(kind), kind);
  }
  for (const c of bpCases) {
    assert.ok(c.input_facts != null, c.id);
    assert.ok(c.expected_assertions != null, c.id);
  }
});

test('public docs mention investor BP terms', () => {
  const blob = read(rootReadmePath) + read(readmePath);
  for (const term of [
    'investor-bp', '12-slide', 'user-supplied-data-only', 'no-PPTX-generation', 'kakadong-persona',
  ]) {
    assert.ok(blob.includes(term), term);
  }
});

test('SKILL.md core labels', () => {
  const skill = read(skillPath);
  for (const term of [
    'business-genius-kakadong', 'AI OPC', 'idea-stage', 'operating-stage', 'service-model',
    'product-model', 'occurred', 'material', 'to-validate', 'continue', 'adjust-and-continue',
    'validate-first', 'pause', 'seven-day-action', 'explicit-consent', 'no-raw-material-storage',
    'safety-boundary', 'Safety refusal path', 'Contradiction path', 'CC BY-NC 4.0',
  ]) {
    assert.ok(skill.includes(term), term);
  }
  assert.ok(!skill.includes('total score'));
});

test('evaluation cases', () => {
  const cases = JSON.parse(read(casesPath));
  const safetyCases = JSON.parse(read(safetyCasesPath));
  assert.equal(cases.length, 4);
  assert.equal(new Set(cases.map((c) => c.stage)).size, 2);
  assert.equal(new Set(cases.map((c) => c.model)).size, 2);
  for (const c of cases) {
    assert.ok(c.input_facts != null, c.id);
    assert.ok(c.expected_assertions != null, c.id);
    assert.equal(c.expected_assertions.verdict, c.expected_verdict);
  }
  assert.ok(safetyCases.length >= 2);
  const kinds = new Set(safetyCases.map((c) => c.kind));
  assert.ok(kinds.has('safety-refusal'));
  assert.ok(kinds.has('data-conflict'));
  for (const c of safetyCases) {
    assert.ok(c.expected_assertions != null, c.id);
  }
});

test('skill README distribution tags', () => {
  const readme = read(readmePath);
  assert.ok(readme.includes('public-free'));
  assert.ok(readme.includes('non-commercial'));
});

test('miit kb-mount contract', () => {
  const skill = read(skillPath);
  const kbMount = read(kbMountPath);
  const changelog = read(changelogPath);
  const docs = read(rootReadmePath) + read(readmePath);
  for (const term of [
    'miit-qualification-kb', 'MIIT_QUALIFICATION_KB_ROOT', '高新技术企业', '专精特新',
    'needs_verification', 'PENDING', '03-企业主体库', 'Do not invent',
  ]) {
    assert.ok(kbMount.includes(term), term);
  }
  assert.ok(skill.includes('references/kb-mount.md'));
  assert.ok(skill.includes('miit-qualification-kb'));
  assert.ok(docs.includes('miit-qualification-kb'));
  assert.ok(changelog.includes('miit-qualification-kb'));
  assert.ok(!skill.includes('工信部企业〔2022〕63号'));
  assert.ok(!kbMount.includes('各省、自治区、直辖市及计划单列市、新疆生产建设兵团工业和信息化主管部门'));
});
