---
name: adr
description: Create and review Architecture Decision Records (ADRs) using Michael Nygard's canonical format and principles
trigger_keywords: ["ADR", "architecture decision record", "architectural decision", "document decision", "design decision"]
---

# Architecture Decision Records (ADRs) - Canonical Principles

Create and review Architecture Decision Records using **Michael Nygard's original format** from his seminal blog post "Documenting Architecture Decisions" (2011).

## When to Use This Skill

- Creating new ADRs for architecturally significant decisions
- Reviewing existing ADRs for format compliance
- Training team members on proper ADR structure
- Evaluating whether a decision warrants an ADR

## ADR Definition

Document **"architecturally significant"** decisions that affect:
- Structure and non-functional characteristics
- Dependencies and interfaces
- Construction techniques
- Technology choices with long-term impact

## Canonical 5-Part Structure

### 1. **Title**
- Short noun phrase describing the decision
- Format: `ADR N: [Noun Phrase]`
- Example: `ADR 1: Deployment on Ruby on Rails 3.0.10`

### 2. **Context**
- Describe forces at play: technological, political, social, project-specific
- **Value-neutral language** - present facts without judgment
- Explain tensions between competing priorities
- Provide background for why decision was needed

### 3. **Decision**
- **Active voice with "We will..." statements**
- Use full sentences, not bullet points
- State the response to the forces in Context
- Be specific and actionable

### 4. **Status**
- One of: `proposed` | `accepted` | `deprecated` | `superseded`
- If superseded, reference the replacing ADR
- Never delete old ADRs, only mark as superseded

### 5. **Consequences**
- List **all** resulting impacts: positive, negative, and neutral
- Consider effects on team, project, and future decisions
- Include trade-offs and risks

## Key Writing Guidelines

### Format & Length
- **1-2 pages maximum** for readability
- Use lightweight formatting (Markdown preferred)
- Full sentences organized in paragraphs, not bullet lists
- Include date when decision was made

### Numbering & Storage
- **Sequential numbering** - never reuse numbers
- Store in version control (e.g., `docs/adr/adr-NNN.md`)
- Consider using `adr-tools` or similar for automation

### Writing Style
- Write as **conversation with future developers**
- Explain the "why" behind decisions
- Avoid technical jargon where possible
- Focus on motivation and context, not just the decision

## ADR Template

```markdown
# ADR N: [Short Noun Phrase]

Date: YYYY-MM-DD

## Status
[proposed | accepted | deprecated | superseded by ADR-X]

## Context
[Value-neutral description of forces, constraints, and requirements that led to this decision. Explain the problem space and why a decision was needed.]

## Decision
We will [specific decision using active voice].

We will [additional decision points if needed].

## Consequences
Positive: [Benefits and improvements this decision brings]

Negative: [Costs, risks, and downsides of this decision]

Neutral: [Neither positive nor negative impacts worth noting]
```

## Quality Checklist

**Structure:**
- [ ] Title is a noun phrase describing the decision
- [ ] All 5 sections present (Title, Context, Decision, Status, Consequences)
- [ ] 1-2 pages maximum length

**Content:**
- [ ] Context explains "why" without judgment
- [ ] Decision uses active voice "We will..." statements
- [ ] Consequences cover positive, negative, and neutral impacts
- [ ] Language is clear for future developers

**Process:**
- [ ] Sequential numbering used
- [ ] Date included
- [ ] Stored in version control
- [ ] Status accurately reflects current state

## Anti-Patterns to Avoid

❌ **Bullet-point decisions** - Use full sentences with "We will..."
❌ **Evaluative context** - Keep context factual and neutral
❌ **Missing consequences** - Include both benefits and costs
❌ **Too long** - Keep to 1-2 pages for readability
❌ **Implementation details** - Focus on the decision, not how to implement
❌ **Deleting old ADRs** - Mark as superseded instead

## ADR-Tools Commands

Common commands for `adr-tools` workflow automation:

### Creating ADRs
```bash
# Create new ADR with template
adr new "Database Technology Selection"

# Create ADR that supersedes another
adr new -s 12 "Updated Database Technology Selection"
```

### Managing ADRs
```bash
# List all ADRs with status
adr list

# Generate table of contents
adr generate toc

# Create visual dependency graph (requires Graphviz)
adr generate graph
```

### Installation
```bash
# macOS with Homebrew
brew install adr-tools

# Manual installation
git clone https://github.com/npryce/adr-tools.git
# Add to PATH
```

### Configuration
- ADRs stored in `docs/adr/` by default
- Use `adr config` to change directory
- Template customization in `~/.adr-templates/`

## Related Resources

- [Original blog post by Michael Nygard](https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions)
- [adr-tools for automation](https://github.com/npryce/adr-tools)
- [ADR templates and examples](https://github.com/joelparkerhenderson/architecture_decision_record)

## Example Usage

**Creating:** "I need to document our database choice" → Use `adr new "Database Choice"`
**Reviewing:** "Check if this ADR follows proper format" → Apply quality checklist
**Training:** "Show me how to write a good ADR" → Use template and guidelines
**Automation:** "Set up ADR workflow" → Install adr-tools and configure
