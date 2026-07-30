# Investor BP Workflow

`user-supplied-data-only` `no-automatic-web-research`

## Purpose

本流程面向个人天使和专业投资机构，生成一页投资摘要与 12 页融资 BP 文案。数据质量先于叙事完整：缺失信息通过问询收集，仍然缺失就明确标注。

不得自动联网补充市场、竞品、财务、客户、收入或融资数据，也不得使用模型记忆替代用户提供的来源。一次只问一个最关键的问题，并先读取当前对话，避免重复询问。

## State

```yaml
InvestorBPInput:
  audience: angel_and_institution
  assessment_verdict: continue | adjust-and-continue | validate-first | pause | unknown
  project_one_liner: null
  product: null
  buyer: null
  problem_and_current_alternative: null
  product_workflow: null
  pricing_and_revenue_model: null
  traction: null
  acquisition: null
  delivery_and_costs: null
  market_calculation: null
  competitors_and_differentiation: null
  founder_and_opc_model: null
  funding_amount: null
  use_of_funds: null
  milestones: null
  risks: []
  evidence: []
  contradictions: []

InvestorSummary:
  project: null
  problem: null
  solution: null
  evidence: []
  business_model: null
  founder_advantage: null
  funding_request: null
  risks_or_gaps: []
  angel_lens: null
  institution_lens: null

SlideBrief:
  slide_number: 1
  role: cover | problem | solution | product | timing | traction | market | business-model | go-to-market | competition | founder | funding
  conclusion_title: null
  core_message: null
  supporting_points: []
  metrics:
    - value: null
      source: null
      scope: null
      as_of: null
  visual_suggestion: null
  investor_question: null
  evidence_status: occurred | material | to-validate
```

所有重要事实继续使用 `occurred`、`material` 或 `to-validate`。市场、竞争、财务、客户、收入和融资数字必须同时记录用户提供的来源、统计口径和日期。

## Entry and compact evidence gate

先读取当前对话和已有商业体检结果：

- 已有体检结果时，复用事实、证据状态、结论和数据冲突，不重复询问。
- 没有体检结果时，将 `assessment_verdict` 记为 `unknown`，完成精简证据核验后再决定材料类型。

按缺口优先级一次询问一个字段：

1. 项目一句话定义。
2. 具体产品、付款客户与当前替代方案。
3. 产品如何工作，用户付款后得到什么。
4. 价格、收入模式、获客与交付成本。
5. 客户、收入、使用、复购或留存证据。
6. 市场规模计算输入及其来源、口径和日期。
7. 竞争对手、替代方案和可验证差异。
8. 创始人经历与 AI OPC 运作方式。
9. 融资金额、资金用途和下一阶段里程碑。
10. 已知风险和待验证假设。

用户说“不知道”时保留缺失状态，不追问同一事实的不同说法，不用网络搜索或模型记忆补齐。

## Drafting gate

- `continue`：允许正式一页摘要和正式 12 页 BP。
- `adjust-and-continue`：允许正式材料，但必须披露当前结构性瓶颈。
- `validate-first`：只允许 `validation-version`，在标题和所有预测处明确标注验证状态。
- `pause`：只输出 `gap-only` 材料缺口和一项验证任务，不生成融资 BP。
- `unknown`：先完成精简证据核验；不能跳过门槛直接成稿。

数据口径冲突时调用主 Skill 的 `Contradiction path`，停止成稿。用户要求虚构客户、合同、收入、市场数据、团队成员或融资进度时调用 `Safety refusal path`，不输出 BP 或案例记录。

没有来源、口径或日期的数据统一写“待补数据”。不能把注册、关注、咨询、演示或意向写成付款、留存或需求成立。

## One-page investor summary

`InvestorSummary` 包含：项目一句话、客户问题、产品方案、当前阶段、关键证据、商业模式、创始人与 AI OPC 优势、融资金额与用途，以及三项主要风险或材料缺口。

- `angel-lens`：突出创始人洞察、执行速度、早期行动和第一批真实证据。
- `institution-lens`：突出数据质量、单位经济、可重复增长、市场计算和风险。

两个阅读重点只能改变信息顺序和强调程度，不能改变事实、数字或证据状态。

## Twelve-slide core

核心 BP 固定为 12 个逻辑页，顺序如下：

| 页码 | role | 必须回答的问题 |
| --- | --- | --- |
| 1 | `cover` | 项目是谁，为谁解决什么问题？ |
| 2 | `problem` | 哪个具体客户问题值得付钱解决，现有方式为何不足？ |
| 3 | `solution` | 产品怎样更直接地解决这个问题？ |
| 4 | `product` | 用户从进入到获得结果的流程是什么？ |
| 5 | `timing` | 哪些用户提供的事实说明现在值得行动？ |
| 6 | `traction` | 已经发生了哪些付款、使用、交付、复购或留存？ |
| 7 | `market` | 市场如何自下而上计算，输入从哪里来？ |
| 8 | `business-model` | 如何收费，收入、成本和单位经济如何成立？ |
| 9 | `go-to-market` | 客户从哪里来，哪条路径已有证据？ |
| 10 | `competition` | 客户还会选谁或什么方式，真实差异是什么？ |
| 11 | `founder` | 为什么这个创始人和 AI OPC 结构能执行？ |
| 12 | `funding` | 融多少钱、怎么用、换来什么里程碑？ |

每页只表达一个核心结论。`conclusion_title` 必须是结论句，不能只写“市场分析”“商业模式”等栏目名。正文包含 3 至 5 个支撑点；所有数字带 `source`、`scope` 和 `as_of`。`visual_suggestion` 只说明要表达的关系，不制造图表数据。`investor_question` 写该页最可能被追问的一件事。

风险、数据缺口、详细财务口径和佐证材料进入附录，不为凑页数塞进 12 页正文。

## Confirmation and final copy

第一轮只输出一页摘要和 12 个 `SlideBrief`，让用户确认事实、顺序和重点。用户确认后，才生成正式 BP 文案。

正式文案必须使用 `artifact-voice`：克制、准确、可核验，不出现“咱们”、昵称、人格类型、激励口号或江湖表达。卡卡东只在问询、纠错和行动建议中使用 `agent-voice`。

## Content QA

成稿前逐项检查：

1. 12 页是否形成连续的投资逻辑。
2. 每页是否只有一个结论，并由事实或明确标记的假设支撑。
3. 客户、收入、市场、成本和融资数据口径是否一致。
4. 是否把注册、关注、咨询或演示误写成付款、留存或需求成立。
5. 是否出现编造的市场规模、客户、合同、团队成员或融资进度。
6. 一页摘要与 12 页 BP 的事实是否一致。
7. `angel-lens` 与 `institution-lens` 是否只改变重点、不改变事实。
8. 卡卡东人格是否泄漏到正式材料。

任何一项失败都先修正文案或回到单问题问询，不能带着已知错误交付。
