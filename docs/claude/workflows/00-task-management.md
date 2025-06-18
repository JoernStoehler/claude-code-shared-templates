# Task Management Workflows

## Overview

Structured workflows ensure consistent, high-quality task completion. Choose the appropriate template based on task complexity.

## Long Task Template

For complex, multi-step tasks requiring careful planning:

### 1. Environment Setup ✓
Usually pre-completed:
- Remote CI/CD configured
- Devcontainer running
- Git worktree created
- Dependencies installed

### 2. Task Understanding
- Read task description carefully
- Check @docs/roadmap.md for context
- Check @docs/changelog.md for recent changes
- Check @docs/tasks for handoff documents
- Ask Jörn for clarification if needed
- Create/update task documentation in @docs/tasks

### 3. Context Exploration
- Identify relevant modules and files
- Use parallel tool calls for efficiency:
  ```
  Grep(), Glob(), Read() without waiting
  ```
- Use Task() agents for complex searches
- Document findings in @docs/tasks

### 4. Planning
- Define success criteria and observables
- Decompose into manageable steps
- Include reflection checkpoints
- Make architectural decisions upfront
- Consider ADRs/RFCs for complex decisions
- Document plan in @docs/tasks

### 5. Plan Review
- Critically evaluate your plan
- Request Jörn's feedback if uncertain
- Update documentation based on feedback

### 6. Implementation
- Follow TDD: tests first, then code
- Update task status in real-time
- Address problems as they arise
- Maintain high code quality throughout
- Run tests frequently

### 7. Final Review
- Ensure all tests pass
- Run linting and type checking
- Submit PR with `gh pr create`
- Fix CI/CD issues
- Request Jörn's review

## Short Task Template

For straightforward, well-defined tasks:

1. **Setup** ✓ (pre-completed)
2. **Read task** and clarify requirements
3. **Explore codebase** for context
4. **Plan** using Todo() tool
5. **Review plan** briefly
6. **Execute** the plan
7. **Review** implementation
8. **Submit PR** and handle CI/CD
9. **Request review** from Jörn

## Using the Todo Tool

The Todo() tool is essential for task tracking:

```python
# Create initial todos
TodoWrite(todos=[
    {"id": "analyze", "content": "Analyze existing code structure", 
     "status": "pending", "priority": "high"},
    {"id": "implement", "content": "Implement new feature", 
     "status": "pending", "priority": "high"},
    {"id": "test", "content": "Write comprehensive tests", 
     "status": "pending", "priority": "medium"},
])

# Update as you progress
TodoWrite(todos=[
    {"id": "analyze", "content": "Analyze existing code structure", 
     "status": "completed", "priority": "high"},
    # ... other todos
])
```

## Best Practices

1. **Frequent Updates**: Mark todos complete immediately after finishing
2. **Granular Tasks**: Break large tasks into smaller, trackable pieces
3. **Priority Management**: Focus on high-priority items first
4. **Documentation**: Keep @docs/tasks updated throughout
5. **Communication**: Proactively communicate blockers or concerns

## Decision Points

Ask Jörn for review when:
- Architecture decisions have broad impact
- You're uncertain about the approach
- The task affects core functionality
- Creating ADRs or RFCs

Proceed independently when:
- Following established patterns
- Making localized changes
- Implementing agreed-upon plans
- Fixing obvious bugs