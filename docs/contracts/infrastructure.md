# Infrastructure engineering maxims and contracts

> **The rule, in one line.** Every piece of shippable infrastructure abides by the twenty-four contracts below. A contract is not a preference. Infrastructure earns no exemption for being configuration: it is the layer where a mistake is measured in data loss rather than a failed test.

**The infrastructure half of one standard.** The [development contracts](development.md) are the other half, and code that crosses the line answers to both; the [security contracts](security.md) cover what code does when someone is trying to make it do something else. Twenty-eight maxims guide judgment; twenty-four contracts state requirements; Part VII says honestly which of them a command decides and which rest on a person remembering.

**Items are citable.** A maxim is `INF-M12`, a contract `INF-C7`, a design principle `INF-D3`, a security principle `INF-S2`, an operations principle `INF-O1`, a clause `INF-H1`. Cite them in reviews, commit messages and audits the same way `DEV-C12` cites the development side.

## Infrastructure philosophy

**Infrastructure is software with consequences.**

Infrastructure is not merely configuration. It determines availability, security, performance, scalability, recoverability, operational cost, data protection and developer experience, so it is built with the discipline of application software, and held to the same gates.

## Industry standards

Infrastructure is designed against recognised frameworks as reference points rather than invented from first principles each time.

### AWS Well-Architected Framework

Cloud architecture is evaluated against the six pillars: Operational Excellence, Security, Reliability, Performance Efficiency, Cost Optimization and Sustainability.

Well-Architected is not a replacement for engineering judgment. It is the baseline that judgment argues with.

### NIST Cybersecurity Framework

Infrastructure security aligns with NIST CSF 2.0 and its six functions: Govern, Identify, Protect, Detect, Respond, Recover. The framework's value is a common taxonomy for risk, not a checklist.

### CIS Critical Security Controls

Security baselines reference CIS Controls v8.1: prioritised, measurable safeguards built around prevalent attack patterns in cloud and hybrid environments. The controls touched most: asset inventory, identity management, access control, vulnerability management, audit logging, network security, data protection, incident response and service-provider management.

## Part I: infrastructure maxims

Twenty-eight defaults. Each may be departed from with a written reason.

### INF-M1. Infrastructure is code

Version controlled, reviewable, reproducible, testable, documented, automated, auditable. Manual production configuration is technical debt that nobody is tracking.

### INF-M2. Declarative before imperative

Declare what the desired state is rather than how to reach it by hand. Terraform, Kubernetes, Ansible and CloudFormation over undocumented shell commands typed into a session that closed.

### INF-M3. Everything should be reproducible

> If infrastructure cannot be recreated, it is not fully defined.

A production environment is reconstructable from source control, configuration, secret references, approved external dependencies and a documented bootstrap procedure. A server that exists because "somebody configured it three years ago" is not infrastructure, it is an undocumented artifact.

### INF-M4. Immutable where practical

Prefer replacing infrastructure over modifying it in place.

```text
build -> validate -> deploy -> replace
```

beats

```text
SSH -> modify -> hope
```

Mutable infrastructure requires a justification, not a habit.

### INF-M5. Configuration must have an owner

Every configuration value has one defined source of truth: a Terraform variable, an environment variable, a secrets manager, a Kubernetes Secret, a configuration file, a parameter store. One of them, not several.

### INF-M6. No snowflake infrastructure

Two servers performing the same role are materially equivalent. Differences are intentional, documented and reproducible, or they are drift with a good story.

### INF-M7. Least privilege is the default

Every identity gets the minimum permission required: users, IAM roles, applications, containers, service accounts, CI/CD systems, Terraform, Ansible, monitoring. Never grant `AdministratorAccess`, `root` or `cluster-admin` because it is convenient at 6pm.

### INF-M8. Identity before network

> Network location is not a substitute for identity.

"It's inside the VPC" is a statement about topology, not about who is calling. Authenticate and authorise on identity wherever practical.

### INF-M9. Zero trust by default

Every access path answers: who is accessing, what are they accessing, why, with which permissions, and how is the access recorded?

### INF-M10. Secrets are never configuration

Secrets do not live in Terraform files, git repositories, Dockerfiles, Kubernetes manifests, CI configuration, shell scripts, application source, machine images or container images. They are retrieved from a secret-management system at the moment of use.

### INF-M11. Encryption is the default

At rest, in transit, in backups, and during replication where appropriate. Plaintext transmission of sensitive data is a defect, not a trade-off.

### INF-M12. Network access must be explicit

Every exposed path answers: who needs access, from where, to what, on which protocol, on which port, and why. `0.0.0.0/0` appears only where the service genuinely serves the public.

### INF-M13. Public exposure must be deliberate

Every publicly reachable resource is classified: public by design, public infrastructure, public application endpoint, temporary, or accidental. Accidental public exposure is a security defect, and the classification exercise is how it gets found.

### INF-M14. Default deny

Deny first, allow explicitly: firewalls, security groups, IAM, Kubernetes RBAC, network policies, API access, storage policies.

### INF-M15. Infrastructure must be observable

Availability, errors, capacity, performance, resource utilisation, security events, deployment activity. If infrastructure fails and nobody can determine why, the infrastructure is incomplete.

### INF-M16. Monitoring must be actionable

Every alert answers: what should the operator do?

| Bad | Better |
|---|---|
| `CPU > 80%` | Application CPU saturated for 10 minutes, so inspect workload saturation and decide whether traffic, a runaway process, or a capacity constraint is responsible |

### INF-M17. Alerting is not monitoring

Monitoring says what is happening. An alert says something requires action, now, by someone. Not every metric earns one, and a channel full of alerts nobody acts on trains people to ignore the one that mattered.

### INF-M18. Design for failure

Instances fail, containers crash, nodes disappear, availability zones fail, networks partition, DNS fails, databases become unavailable, credentials expire, certificates expire, storage fills, dependencies vanish. Design as though all of it is scheduled, because over a long enough window it is.

### INF-M19. Recovery is a feature

Surviving failure is not resilience on its own: the system must also be recoverable. Every critical system defines a backup strategy, a restore strategy, an RPO, an RTO and a disaster-recovery procedure.

### INF-M20. Backups are not proven until restored

> A backup that has never been restored is an assumption wearing a backup's clothes.

### INF-M21. Availability must match requirements

Multi-region, multi-AZ, Kubernetes and active-active are not free, and they are not decorations. Availability architecture corresponds to a business requirement someone stated.

### INF-M22. Reliability has a budget

99.0%, 99.9%, 99.95%, 99.99%: each step up costs money, complexity and operational burden. Pick deliberately, then design to the number rather than to the vibe.

### INF-M23. Capacity must be intentional

A known scaling model: vertical, horizontal, autoscaling, queue-based, scheduled, or explicitly manual. "We'll add a bigger server when it gets slow" is a plan to be surprised in public.

### INF-M24. Cost is an architectural property

Considered during design rather than discovered on an invoice: compute, storage, network, managed services, logging, monitoring, data transfer, backup, licensing.

### INF-M25. Resource ownership must be visible

Every resource carries metadata where the platform supports it: `Name`, `Environment`, `Application`, `Owner`, `ManagedBy`, `CostCenter`, `DataClassification`. This is what makes an audit possible later; an untagged estate cannot be cleaned up safely.

### INF-M26. Environments must be deliberate

`development`, `testing`, `staging`, `production`, and every difference between them intentional and written down.

### INF-M27. Production is not a development environment

Nobody experiments against production. Production changes require review, authorisation, auditability and a recovery strategy.

### INF-M28. Local development should be production-compatible

Local reproduces production interfaces and architecture, at reduced scale:

| Production | Local |
|---|---|
| AWS + Kubernetes + RDS + Redis + S3 | Kubernetes + MariaDB/PostgreSQL + Redis + MinIO |

The implementation may differ. The architecture stays conceptually compatible, because the bugs that only exist on one side are the expensive ones.

## Part II: infrastructure contracts

Twenty-four requirements. Each says what decides it, and where nothing mechanical decides it, that is said rather than implied.

### INF-C1. All infrastructure is version controlled

No production infrastructure depends on undocumented manual configuration.

**Enforced by** review, plus drift detection (`INF-C4`). A resource nothing declares shows up as drift the first time anyone looks.

### INF-C2. All infrastructure changes are reviewable

```text
change -> pull request -> validation -> plan / diff -> review -> approval -> apply
```

**Enforced by** a CI pipeline in which a protected environment gates the apply. Where no pipeline stands in front of a deployment, see `INF-H2`.

### INF-C3. No direct production changes

Manual production changes are prohibited except for emergency response, incident mitigation, or an explicitly authorised operational procedure. An emergency change is reconciled back into infrastructure code afterwards, and the reconciliation is part of the incident, not a follow-up someone might get to.

**Enforced by** review and drift detection. Nothing prevents a console click; only detection finds it.

### INF-C4. Drift must be detectable

There is a way to answer declared state versus actual state. Drift is detected, investigated, corrected, and documented where it turns out to be intentional.

**Enforced by** `terraform plan` against a clean tree, `ansible-playbook --check --diff`, and an account audit for what exists in an account at all.

### INF-C5. Infrastructure must be idempotent

Running the same automation repeatedly converges on the same state. Apply, then apply again, and the second run reports nothing.

**Enforced by** a second `terraform plan` returning no changes, and an Ansible run whose second pass reports zero `changed`. This is a check you run, not one that runs itself: a task that is not idempotent passes CI happily.

### INF-C6. Destructive operations require intent

`terraform destroy`, database deletion, volume deletion, bucket deletion, cluster destruction: each requires deliberate confirmation, and automation is designed to make accidental destruction difficult.

**Enforced by** a team rule with real weight: anything destructive takes a dry-run flag, and anything irreversible or outward-facing prints its plan and prompts, with a flag to skip the prompt for unattended use. Provider-side guards (deletion protection, delete-on-termination, snapshots pinned to machine images) are named before a command is handed over.

### INF-C7. State must be protected

Infrastructure state may contain sensitive values. It is stored securely, access controlled, backed up, versioned where appropriate, encrypted, and protected from unauthorised modification.

**Enforced by** backend configuration, and the permissions on the state store.

### INF-C8. Secrets must not be stored in state unnecessarily

Where a secret must exist in state: encrypt the state, restrict access, understand the exposure, and prefer secret references over secret values.

**Enforced by** review, plus a full-history secret scan when a repository is about to be published.

### INF-C9. No hardcoded credentials

```text
username = "admin"
password = "SuperSecret123"  # pragma: allowlist secret
api_key  = "..."
```

is forbidden in every file. Credentials come from an approved secret-management mechanism.

> **The tree is not the thing that gets published.** A key removed in a later commit is still in the object store, and a push publishes every commit. Scan the history before a first push, and rotate rather than delete.

**Enforced by** a secret scanner on every commit, with a full-history scan owed before a first push.

### INF-C10. Infrastructure dependencies must be pinned

Terraform providers and modules, container images, Kubernetes versions, Helm charts, Ansible collections, OS images. Avoid `latest`, `main`, `master` and `*` for anything production depends on.

**Enforced by** lockfiles where the tool has them (`.terraform.lock.hcl`, a requirements file with versions), a known-vulnerability scan on commit, a check for a mutable action reference or a floating base image, a check that an action pinned to a SHA is a real commit, and review everywhere else.

### INF-C11. Images must be traceable

Every production image traces to a source repository, a commit, a build, a version and a dependency set. Prefer immutable digest references over mutable tags.

**Enforced by** review and build metadata, plus pattern checks for a mutable base image, an `ADD` from a remote URL, or `curl | sh`, where a project has them.

### INF-C12. Infrastructure must be validated before deployment

Automated validation appropriate to the technology, at minimum:

| Technology | Validation chain |
|---|---|
| Terraform | `fmt`, then `validate`, lint, security scan, `plan` |
| Kubernetes | schema validation, lint, policy validation, security scan |
| Ansible | syntax check, `ansible-lint`, `yamllint`, molecule or tests where appropriate |

**Enforced by** those tools in CI, where a stack has them. The chain is often thinner in practice than its documentation suggests, and that is a gap to report rather than a rule to relax.

### INF-C13. Security scanning is part of CI

Infrastructure is automatically checked for public storage, excessive IAM permissions, open security groups, privileged containers, missing encryption, weak TLS, vulnerable images and exposed secrets.

**Enforced by** an infrastructure-as-code scanner (for example `checkov` or `trivy config`), a secret scanner, a host access audit and an account audit.

### INF-C14. Production changes must produce a diff

Before applying, the operator can answer what is going to change. No blind deployment.

**Enforced by** `terraform plan` as a required pipeline stage, and `--check --diff` for Ansible. A command handed over for someone to run states plainly what it will destroy before they run it.

### INF-C15. Rollback must be considered before deployment

Every significant change answers: what happens if this fails, how do we recover, can we roll back, and if not, how do we restore?

**Enforced by** review, and a pattern check for a Terraform change with no data-loss guard where a project has one. The answer belongs in the change description, not in the incident.

### INF-C16. Database changes are special

Migrations account for backward compatibility, data integrity, locking, runtime duration, rollback, replication, backup and application compatibility.

```text
expand -> migrate -> contract
```

beats a destructive one-step migration in every case where the application is running while it happens.

**Enforced by** review, and by the migration tooling of the stack in question.

### INF-C17. Network boundaries must be documented

Important paths are represented architecturally, and the reason for every trust boundary is understood.

```text
internet -> load balancer -> application -> cache, database, external API
```

**Enforced by** review, against the architecture documentation.

### INF-C18. IAM must be auditable

Every privileged identity has an owner, a purpose, defined permissions, a lifecycle and an audit trail. Unused privileges are removed, and "unused" is a measurement rather than an impression.

**Enforced by** an account audit, run by the account owner. See `INF-H1`.

### INF-C19. Administrative access must be controlled

Prefer SSO, MFA, short-lived credentials, bastion and session management and audited access over a shared root password, a shared SSH key or permanent administrator credentials.

**Enforced by** a host access audit for the host side, and provider configuration for the rest.

### INF-C20. Infrastructure must have an owner

Every production system answers: who maintains this, who receives its alerts, who approves its changes, who responds to its incidents?

**Enforced by** the `Owner` tag of `INF-M25`, and review.

### INF-C21. Every production system needs documentation

Purpose, architecture, dependencies, deployment, configuration, secrets, monitoring, alerts, backup, recovery, failure modes, ownership.

**Enforced by** a team rule: the documentation lands as part of the work, never as an offer afterwards.

### INF-C22. Runbooks are required for critical operations

Deployment, rollback, failure recovery, database recovery, certificate renewal, credential rotation, scaling, disaster recovery.

**Enforced by** review. A runbook that has never been followed by someone other than its author is a draft.

### INF-C23. Infrastructure must be tested

```text
syntax -> static validation -> security validation -> unit/module -> integration -> deployment -> recovery
```

Not every system needs every level. Critical infrastructure needs more than syntax validation, which is exactly the level most infrastructure stops at.

**Enforced by** the validation chain of `INF-C12`, as far as it goes.

### INF-C24. Disaster recovery must be tested

A disaster-recovery plan that has never been tested is incomplete. Periodically exercise restore, failover, recovery, backup integrity, dependency recovery, DNS changes and credential recovery.

**Enforced by** nothing mechanical. This is the contract most likely to be quietly unmet, in every organisation, forever.

## Part III: design principles

### INF-D1. Prefer managed services when they reduce operational risk

Consider them when they meaningfully reduce maintenance, security burden, availability risk or operational complexity. But managed does not mean automatically better: evaluate cost, lock-in, operational control, performance, failure modes and portability.

### INF-D2. Minimise blast radius

One failure should not compromise everything. Use accounts, VPCs, subnets, security groups, IAM boundaries, namespaces, network policies, service boundaries and database boundaries deliberately.

### INF-D3. Separate control planes from workloads

Monitoring, secrets, CI/CD, identity, backups and logging keep an appropriate independence from the workloads they manage. A monitoring system that dies with the thing it monitors reports nothing at the only moment it mattered.

### INF-D4. Prefer ephemeral compute

VMs, containers, pods, workers and runners are disposable units, not pets with names and histories.

### INF-D5. Persistent data requires special treatment

Storage, backups, replication, recovery, consistency, durability and migration are each deliberate decisions for stateful systems. Prefer stateless where practical, because it moves the problem to the layer that has already solved it.

### INF-D6. Separate state from compute

```text
compute -> external persistent state
```

rather than critical state embedded inside a resource designed to be replaced.

> **The bind mount that recreated itself.** Docker records the absolute host path of a bind mount inside the container's own config. Renaming a bind-mounted directory does not error: the running container keeps working through the inode, and the next `docker compose up` recreates it against the recorded path, creating an empty directory there rather than refusing. A database then initialised a fresh empty data directory while the real one sat one rename away, and nothing failed loudly. After moving anything a container mounts, read back `docker inspect` for every container, running and stopped, and recreate with `--force-recreate`.

## Part IV: security principles

### INF-S1. Security must exist at multiple layers

```text
identity -> network -> host -> container -> application -> data -> monitoring
```

Defense in depth means no single control is load-bearing on its own.

### INF-S2. Security controls must be measurable

| Level | Statement |
|---|---|
| Bad | "The infrastructure should be secure." |
| Better | "No production storage bucket may be publicly readable." |
| Best | policy, then automated scan, then CI failure |

This is the codification ladder of the development contracts applied to security. A control that cannot be measured cannot be claimed.

### INF-S3. Patch management must be deliberate

A strategy for OS updates, container updates, Kubernetes updates, runtime updates, security patches and dependency updates. "Eventually" is not a patch strategy.

### INF-S4. Vulnerability management must have priorities

Not every vulnerability carries equal risk. Prioritise on severity, exploitability, exposure, asset criticality, available mitigations and business impact.

## Part V: operations principles

### INF-O1. Every service has an SLO

Critical services define an availability target, a latency target and an error-rate target. These become the basis for operational decisions rather than decoration on a dashboard.

### INF-O2. Alerts should represent symptoms

Prefer high request failure rate, database unavailable, queue backlog growing and service unavailable over arbitrary infrastructure metrics that may indicate nothing at all.

### INF-O3. Every incident produces learning

Determine what happened, why, what contributed, what detection missed, what recovery lacked, and what corrective action follows. Avoid blame-oriented postmortems: they produce silence, and silence is the one thing an incident review cannot survive.

### INF-O4. Infrastructure changes must be observable

```text
change -> deployment -> metrics -> logs -> errors
```

Every significant deployment can be correlated with what happened next. Without that correlation, an incident review is guesswork with timestamps.

## Part VI: clauses learned in practice

Five clauses, each from something specific that went wrong.

### INF-H1. Cloud is executed by the account owner, never on their behalf

Nothing in an AI session runs against a cloud account, not even for dry runs or read-only describes. Commands are delivered in fenced code blocks, one per block, with what they will destroy stated plainly and every guardrail named: deletion protection, delete-on-termination, snapshots pinned to machine images. Analysis is built from what comes back, not from a describe call made to gather it.

Why: a single session once terminated several compute instances, deleted a database cluster with no final snapshot, deleted dozens of volume snapshots, deleted two VPN endpoints and released an elastic IP, all irreversible. The decision to execute against live cloud infrastructure belongs to the account owner.

### INF-H2. Automation with no pipeline in front of it has one gate

Where deployment automation runs from a workstation to live hosts, the pull-request flow of `INF-C2` does not exist, which makes `--check --diff` and a read of the diff the only gate between an edit and production. Treat every run as an apply without review, because that is what it is.

### INF-H3. A path is a pointer or a statement about the past

When infrastructure moves, a pointer gets rewritten: a tool default, a compose volume, a documented `location:`, an `.env` variable. A statement about the past does not: a run record, a change log, a dated note. Rewriting a statement produces a document that is internally consistent and factually wrong.

### INF-H4. A move sweeps further than the repository

A reorganisation has to sweep tool defaults, `.env` files, compose volume paths, application registries, bookmarks and the shebang line of every console script inside a Python virtualenv. A virtualenv survives a move while its `bin/pytest` fails with a bare "No such file or directory". Search for the old path in all of them, before and after.

### INF-H5. Proving infrastructure work where no account exists yet

Not carried into this kit: it governs a tool specific to one estate.

## Part VII: enforcement, honestly

A contract is enforced at one of three levels, and the report says which:

- **Mechanically enforced.** A command fails and the work stops.
- **Partially enforced.** A gate exists but its coverage is incomplete, or it is installed in some places and not others.
- **Review-only.** No mechanical check exists. The contract still binds; only its enforcement is human.

Drift detection (`INF-C4`), the diff before an apply (`INF-C14`) and the secret scan on commit (`INF-C9`) are the contracts most easily made mechanical. `INF-C3`, `INF-C16`, `INF-C17`, `INF-C20` and `INF-C22` are usually review-only.

**`INF-C24` is the one to worry about.** Everything else that is review-only fails visibly the first time someone looks; an untested recovery procedure fails exactly once, at the worst possible moment, and until then it looks identical to a tested one. A rule decides a pattern, not a contract: a base image pinned by tag is caught, an image nobody can trace to a build is not.

## Part VIII: the infrastructure quality gate

Every infrastructure change passes through this, in this order. The stages before review are machine work; the stages after are judgment.

1. Formatting.
2. Syntax check.
3. Static validation.
4. Security scanning.
5. Policy checks.
6. Dependency checks.
7. Test and integration.
8. Plan or deployment diff.
9. Review.
10. Approval.
11. Deployment.
12. Post-deploy checks.
13. Observability.

**Shippable infrastructure is anything that will run somewhere other than the session that wrote it:** a playbook, a module, a manifest, a compose file, a cron entry, and every command handed over to be pasted into a terminal. The five questions of the [development contracts](development.md) apply unchanged; question 4 resolves to the stages above.

## Part IX: the infrastructure constitution

> **Infrastructure must be secure by default, reproducible by design, observable in operation, recoverable under failure, reviewable before deployment, and automated wherever practical.**

Infrastructure must have a source of truth and an owner; be version controlled, reproducible, declarative where practical and idempotent where applicable; minimise privileges and blast radius; encrypt sensitive information and protect secrets; produce observable changes and detectable drift; have defined failure behaviour and tested recovery procedures; avoid unnecessary complexity; and prefer automation over manual operation.

## Part X: the short version

Forty lines.

1. Infrastructure is software.
2. Everything must be reproducible.
3. Declarative before imperative.
4. Immutable before mutable.
5. No snowflake infrastructure.
6. Everything has an owner.
7. Everything important has a source of truth.
8. Least privilege by default.
9. Zero trust by default.
10. Default deny.
11. Secrets never belong in source code.
12. Encrypt sensitive data.
13. Public exposure must be deliberate.
14. Minimise blast radius.
15. Design for failure.
16. Recovery is a feature.
17. Backups are worthless until restored.
18. Drift must be detectable.
19. Destructive operations require intent.
20. Every production change produces a diff.
21. Infrastructure is validated before deployment.
22. Security scanning belongs in CI.
23. Dependencies are controlled and traceable.
24. Images are immutable and traceable.
25. Monitoring must be actionable.
26. Alerts represent things requiring action.
27. Cost is an architectural property.
28. Availability matches business requirements.
29. Local infrastructure stays production-compatible.
30. Production changes are reviewable.
31. Emergency changes are reconciled back into infrastructure code.
32. Critical operations require runbooks.
33. Disaster recovery must be tested.
34. Infrastructure security must be measurable.
35. Every abstraction earns its existence.
36. Every operational burden has a reason.
37. Automate what can be automated.
38. Document what cannot be automated.
39. Measure what matters.
40. Leave the infrastructure better than you found it.

## The five laws

> **The infrastructure law.** Build infrastructure that can be understood, reproduced, secured, observed, destroyed and rebuilt without depending on tribal knowledge.

> **The operational law.** If we cannot explain how infrastructure is built, how it fails, how we detect that failure and how we recover from it, we do not yet understand the infrastructure.

> **The automation law.** If a human must repeatedly perform an operation, the operation should eventually become automation.

> **The security law.** Trust nothing by default, grant nothing unnecessarily, expose nothing accidentally, and record everything important.

> **The reliability law.** Assume components fail; design the system so failure is survivable and recovery is repeatable.

## Framework alignment

| Principle area | Primary reference |
|---|---|
| Cloud architecture | AWS Well-Architected Framework |
| Operational excellence | AWS Well-Architected |
| Cloud security | AWS Well-Architected + CIS Controls |
| Cybersecurity governance | NIST CSF 2.0 |
| Security safeguards | CIS Controls v8.1 |
| Asset inventory | CIS Control 1 |
| Identity and access | CIS Controls + NIST CSF |
| Incident response | NIST CSF + CIS Controls |
| Reliability, performance, cost, sustainability | AWS Well-Architected |
| Infrastructure as Code | declarative IaC engineering principles |
| Kubernetes | cloud-native and IaC principles |
| Terraform | declarative IaC principles |
| Ansible | idempotent configuration-management principles |
| CI/CD | automated quality and security gates |
| Disaster recovery | reliability and resilience principles |

These frameworks are reference standards, not substitutes for applicable legal, regulatory, contractual or organisational requirements. Where a formal compliance regime applies, its requirements take precedence.
