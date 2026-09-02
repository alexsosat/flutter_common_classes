# Gemini / Antigravity AI Skills for `flutter_common_classes` (`fod_flutter_template`)

This directory contains specialized **AI Skills** designed for Gemini and Antigravity AI assistants. These skills teach AI pair programmers how to correctly architect and construct Flutter applications using the `flutter_common_classes` package.

---

## Included Skills

| Skill Directory | Skill Name | Description |
| :--- | :--- | :--- |
| [`fod-architecture-setup/`](./fod-architecture-setup/SKILL.md) | `fod-architecture-setup` | App initialization, Dependency Injection (`DependencyInjection`), environment & flavor configuration (`EnvironmentConfig`, `Flavor`), and core services (`NetworkInfo`, `SecureStorageService`, `LoggerService`). |
| [`fod-clean-domain-data/`](./fod-clean-domain-data/SKILL.md) | `fod-clean-domain-data` | Clean Architecture Domain & Data layers (`UseCaseAsync`, `UseCase`, `Params`, `NoParams`, `Failure`, `AppFailure`, `HttpCallFailure`, `Either<Failure, T>`). |
| [`fod-state-management/`](./fod-state-management/SKILL.md) | `fod-state-management` | State management primitives (`StateMixin<T>`, `AutoLoaderCubit<T>`, `ValueLoaderCubit<T, J>`, `LoaderCubit<T>`, `safeEmit`). |
| [`fod-ui-views-and-widgets/`](./fod-ui-views-and-widgets/SKILL.md) | `fod-ui-views-and-widgets` | Reactive full-page screens (`PageLoaderWidget`), state builders (`CubitWidgetStateBuilder`, `CubitSkeletonizerStateBuilder`), searchable form bottom sheets (`FormBuilderSearchableBottomSheet`), error views (`FailureView`), and theme/string extensions. |

---

## How to Install Skills in a Consumer Flutter Project

When building a Flutter application that depends on `flutter_common_classes`, install these skills so that AI assistants automatically follow the package patterns.

### Method 1: Project-Level Installation (Recommended for Teams)
Copy the skill folders into the `.agents/skills/` directory at the root of your consumer Flutter application:

```bash
mkdir -p my_flutter_app/.agents/skills/
cp -r /path/to/fod_flutter_template/ai_skills/* my_flutter_app/.agents/skills/
```

### Method 2: Global Machine Installation
Copy the skill folders into your global Gemini configuration root:

```bash
mkdir -p ~/.gemini/config/skills/
cp -r /path/to/fod_flutter_template/ai_skills/* ~/.gemini/config/skills/
```

---

## How AI Agents Use These Skills

Once installed, Gemini / Antigravity will automatically detect these skills when working on your Flutter codebase. The AI reads `SKILL.md` frontmatter descriptions to decide when to activate each skill for tasks such as:
- Initializing app structure and DI
- Creating new feature domain use cases and repositories
- Implementing Cubits for data fetching
- Building full-page `PageLoaderWidget` screens and searchable form fields
