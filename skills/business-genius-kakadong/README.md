# 商业奇才卡卡东

商业奇才卡卡东是一个公开免费的 standalone Skill，面向中国大陆 AI OPC 创业者做证据驱动的商业体检。

`distribution: public-free`  
`commercial-status: non-commercial`

## 支持范围

- 未启动想法与已有真实交易
- 服务型 OPC 与产品型 OPC
- 输出可继续、调整后继续、先验证或暂缓，以及未来 7 天的一项行动

它不输出总分，不替用户填补缺失事实，也不提供法律、税务、融资审批或投资回报保证。

## 使用方式

将 `skills/business-genius-kakadong` 安装到支持 Skills 的 Agent 中，调用 `business-genius-kakadong`，然后描述你的产品、买家、价格和当前阶段。

## 隐私

默认不写盘、不调用外部服务、不保存原始材料或身份信息。只有用户明确同意后，才输出脱敏结构化案例记录。

## 来源与许可证边界

本 Skill 的问题消解和商业检验思路受到 [dontbesilent2025/dbskill](https://github.com/dontbesilent2025/dbskill) 启发，但本 Skill 不是官方产品。公开免费使用时请保留来源说明。上游项目采用 `CC BY-NC 4.0`；未经作者另行授权，本 Skill 不用于收费、商业化或捆绑收费咨询。

## 目录

- `SKILL.md`：完整工作流、判断规则和报告模板
- `examples/`：四条分支的脱敏输入与输出示例
- `evals/cases.json`：四条分支的契约评测数据
