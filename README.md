# Yandex Metrika Assistant

OpenClaw / агентный навык и справка по **API Яндекс.Метрики**: OAuth, отчёты `stat`, Logs, управление счётчиками, импорт данных, типовые вопросы пользователей.

Официальный хаб API: [yandex.ru/dev/metrika](https://yandex.ru/dev/metrika)

## Установка (OpenClaw)

1. Клонируйте репозиторий или скопируйте папку в каталог навыков/плагинов вашего OpenClaw.
2. Подключите плагин с id **`yandex-metrika-assistant`** (файл [`openclaw.plugin.json`](./openclaw.plugin.json)).
3. В настройках плагина задайте **`oauthToken`** (OAuth-токен Яндекса с правами Метрики). Опционально: **`defaultCounterId`**, **`oauthClientId`**.
4. Агенту подключается инструкция из [`SKILL.md`](./SKILL.md).

Переменная окружения (если удобнее): **`YANDEX_METRIKA_OAUTH_TOKEN`**.

## Содержимое репозитория

| Файл | Назначение |
|------|------------|
| [SKILL.md](./SKILL.md) | Поведение агента OpenClaw: секреты, сценарии, маршрутизация API |
| [openclaw.plugin.json](./openclaw.plugin.json) | Контракт плагина и `configSchema` |
| [docs/INSTRUCTION-GET-TOKEN-RU.md](./docs/INSTRUCTION-GET-TOKEN-RU.md) | Как получить токен (для людей) |
| [docs/10-user-intents-matrix.md](./docs/10-user-intents-matrix.md) | Матрица «что спрашивают → какой API» |
| [docs/01–09](./docs/) | Справка по разделам API (ссылки и выжимки) |
| [scripts/exchange-yandex-oauth-code.ps1](./scripts/exchange-yandex-oauth-code.ps1) | Обмен кода OAuth на токен (PowerShell) |

## Безопасность

Не коммитьте токены и секреты. Файл [`.gitignore`](./.gitignore) исключает типичные файлы с секретами.

## Лицензия

MIT — см. [LICENSE](./LICENSE).
