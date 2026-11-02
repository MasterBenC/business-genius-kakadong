# 商业奇才卡卡东

商业奇才卡卡东是一个公开免费的 standalone Skill，面向中国大陆 AI OPC 创业者做证据驱动的商业体检。

`distribution: public-free`  
`commercial-status: non-commercial`

## 支持范围

- 未启动想法与已有真实交易
- 服务型 OPC 与产品型 OPC
- 输出可继续、调整后继续、先验证或暂缓，以及未来 7 天的一项行动
- `investor-bp`：一页投资摘要与 `12-slide` 融资 BP Brief

它不输出总分，不替用户填补缺失事实，也不提供法律、税务、融资审批或投资回报保证。

## 投资人 BP 边界

- `user-supplied-data-only`：市场、竞品、财务、客户、收入和融资数据由用户提供，并保留来源、口径和日期。
- 缺失数据逐项问询；仍无法确认时标记为待补，不自动联网补数。
- 可继续/调整后继续可生成正式材料，先验证只生成验证版，暂缓只输出材料缺口。
- 卡卡东的 `kakadong-persona` 用于问询和纠错；正式 BP 使用克制的投资人语言。
- `no-PPTX-generation`：第一版不生成 HTML、PDF 或 PPTX。
- Dashi PPT 不集成、不复制、不捆绑，也不是本 Skill 的依赖。

## 使用方式

将 `skills/business-genius-kakadong` 安装到支持 Skills 的 Agent 中，调用 `business-genius-kakadong`，然后描述你的产品、买家、价格和当前阶段。

投资人 BP 示例：

```text
business-genius-kakadong
我想整理一份给天使和机构投资人看的融资 BP。
```

## 隐私

默认不写盘、不调用外部服务、不保存原始材料或身份信息。只有用户明确同意后，才输出脱敏结构化案例记录。

## 来源与许可证边界

本 Skill 的问题消解和商业检验思路受到 [dontbesilent2025/dbskill](https://github.com/dontbesilent2025/dbskill) 启发，但本 Skill 不是官方产品。公开免费使用时请保留来源说明。上游项目采用 `CC BY-NC 4.0`；未经作者另行授权，本 Skill 不用于收费、商业化或捆绑收费咨询。

## 工信认定知识库（可选）

触及高新 / 专精特新 / 小巨人 / 单项冠军 / 行业领军时，按 `references/kb-mount.md` 挂载私有 [`miit-qualification-kb`](https://github.com/MasterBenC/miit-qualification-kb)（环境变量 `MIIT_QUALIFICATION_KB_ROOT` 或 sibling `../miit-qualification-kb`）。私库正文**不**打进本 Skill；未挂载时仍可体检，认定相关主张标 `needs_verification` / `to-validate`。行业领军国家级办法在库内为 `PENDING`，不得当有效文件引用。

## 目录

- `SKILL.md`：完整工作流、判断规则和报告模板
- `examples/`：四条分支的脱敏输入与输出示例
- `evals/cases.json`：四条体检分支的契约评测数据
- `evals/bp-cases.json`：六类投资人 BP 行为评测
- `references/`：人格、投资人 BP 工作流、以及 `kb-mount.md`（工信认定私库挂载）
