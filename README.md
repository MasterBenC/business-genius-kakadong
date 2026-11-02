<div align="center">

# 商业奇才卡卡东

### 给 AI OPC 的证据驱动商业体检

**商业判断，不是心理按摩。**

[![Public Free](https://img.shields.io/badge/distribution-public--free-111827?style=flat-square)](https://github.com/MasterBenC/business-genius-kakadong)
[![Skill](https://img.shields.io/badge/type-standalone%20skill-2563EB?style=flat-square)](skills/business-genius-kakadong/SKILL.md)
[![License](https://img.shields.io/badge/upstream-CC%20BY--NC%204.0-16A34A?style=flat-square)](skills/business-genius-kakadong/README.md)

</div>

你不需要一个漂亮分数。你需要知道：**现在该继续、调整，还是先验证。**

你有一个想法，或者已经开始接单、卖产品，但总觉得哪里不对：

- 到底是产品没说清楚，还是买家根本不会付钱？
- 已经有收入了，为什么还是只能靠自己硬撑？
- AI 明明提高了效率，为什么利润和交付能力没有一起变好？
- 现在应该继续、调整，还是先停下来验证？

**商业奇才卡卡东**把你的商业主张拆成事实、材料和待验证假设，最后给出一个当前判断和一项可以立刻执行的行动。

> 不知道，就标记为不知道。数据冲突，就暂停判断。没有证据，就不替你编答案。

## 给谁

面向中国大陆的 AI OPC 创业者：一个人借助 AI 运作服务、产品或小型业务，不把“以后招人”当作当前能力。

支持两种阶段：

- **还没开始的想法**：检查具体买家、付款路径、最小交付和验证动作。
- **已经有真实交易**：检查产品、定价、交付、获客、复购和单位经济。

也会进一步区分：

- **服务型 OPC**：重点看交付能否重复、本人是否成为瓶颈、单位时间收益是否成立。
- **产品型 OPC**：重点看激活、持续使用、分发、支持负担和模型/API 成本。

## 先看结论

每次体检只输出一个主判断：

| 结论 | 意思 |
| --- | --- |
| **可继续** | 已有事实支持当前方向。 |
| **调整后继续** | 需求或交易存在，但结构有明确瓶颈。 |
| **先验证** | 关键判断仍是主张，先拿到真实行为数据。 |
| **暂缓** | 产品、买家或付款路径还没具体到可以行动。 |

报告还会告诉你：

1. 哪些证据支持这个判断；
2. 哪些假设仍未验证；
3. 当前最大的约束是什么；
4. 未来 7 天只做哪一件事；
5. 什么结果会推翻当前判断。

## 投资人 BP

`investor-bp` 模式把已核验的商业事实整理成一页投资摘要和 `12-slide` 融资 BP Brief，同时给出天使与机构投资人的不同阅读重点。

它坚持 `user-supplied-data-only`：市场、竞品、财务、客户、收入和融资数字只使用用户提供的数据、来源、口径和日期。缺失信息通过一次一个问题的方式收集；用户无法提供时明确标记为待补，不自动联网补数。

成稿门槛与商业体检一致：

- 可继续或调整后继续：生成正式材料，并披露已知瓶颈。
- 先验证：只生成明确标记的验证版。
- 暂缓：只输出材料缺口和验证任务。
- 数据冲突：停止成稿，先统一口径。
- 虚构客户、收入、市场或融资进度：拒绝生成。

卡卡东使用 `kakadong-persona` 与用户沟通：专业、有温度、有判断。正式投资材料切换为克制、准确、可核验的投资人语言。

第一版遵守 `no-PPTX-generation`：只输出 Markdown 和结构化逐页 Brief，不生成 HTML、PDF 或 PPTX。Dashi PPT 未被集成、复制、捆绑，也不是运行依赖。

## 一条体检路径

```text
描述你的业务 → 判断阶段 → 判断类型 → 核对证据 → 输出行动
```

它不会把“不知道”伪装成答案，也不会在收入、复购、成本或留存缺失时替你补数字。遇到数据冲突，会先暂停判断；遇到虚假材料、欺诈或规避监管请求，会停止提供优化建议。

## 工信认定证据（可选）

商业体检可以把高新、专精特新、小巨人、单项冠军等当作**证据维度**，而不是分数。宿主若挂载私有 [`miit-qualification-kb`](https://github.com/MasterBenC/miit-qualification-kb)（见 Skill 内 `references/kb-mount.md`），卡卡东会优先对照库内办法与主体档案；私库不随公开包分发。未挂载时照常体检，资格主张保持待验证。

## 快速开始

将 [`skills/business-genius-kakadong`](skills/business-genius-kakadong) 安装到支持 Skills 的 Agent，然后调用：

```text
business-genius-kakadong
```

接着描述：你卖什么、卖给谁、多少钱、怎么获客、怎么交付，以及目前有没有真实交易。

整理投资人 BP：

```text
business-genius-kakadong
我想整理一份给天使和机构投资人看的融资 BP。
```

## 项目状态

当前版本是公开免费的第一版，重点是验证 AI OPC 的评估流程、投资人 BP 问询和判断规则。它暂不提供网页、数据库、自动联网调研、PPTX 生成或总分排行榜。

## 来源与许可证

本 Skill 的问题消解和商业检验思路受到 [dontbesilent2025/dbskill](https://github.com/dontbesilent2025/dbskill) 启发，但本项目不是官方产品。上游项目采用 `CC BY-NC 4.0`；未经作者另行授权，本项目不用于收费、商业化或捆绑收费咨询。

详细工作流、隐私边界、示例和评测见 [`skills/business-genius-kakadong`](skills/business-genius-kakadong)。
