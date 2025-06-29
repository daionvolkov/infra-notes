# infra-notes 🛠

Практические заметки инженера.  
Никакого хайпа. Только работающие скрипты, конфиги и инфраструктура руками.

## 📌 О чём это

Здесь я собираю всё, что применяю в реальных проектах — от DevOps в стартапе до администрирования серверов:

- 🧱 Bash-скрипты: чистка логов, бэкапы, автоматизация
- 🐳 Docker и docker-compose для PostgreSQL, reverse proxy, мониторинга
- 📊 Promtail, Grafana, Loki — всё, что помогает видеть, что у тебя горит
- 🧠 Примеры cron-задач, systemd, алертов, Telegram-интеграций
- 📂 Структура и подход, как я её применяю на VPS

## 🗂 Структура

```bash
infra-notes/
├── scripts/               # полезные bash-скрипты
│   └── cleanup_logs.sh    # удаление старых логов + Telegram-уведомление
├── backups/               # скрипты резервного копирования
│   └── backup_pg.sh       # дамп PostgreSQL + удаление старых копий
├── monitoring/            # конфиги promtail, dashboards, алерты
│   └── promtail-config.yml
├── docker/                # docker-compose и шаблоны
│   └── docker-compose-postgres.yml
└── README.md              # вы его сейчас читаете
