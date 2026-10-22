# Neovim Config

Персональная конфигурация Neovim на Lua. Менеджер плагинов — `lazy.nvim`, лидер-клавиша — `,`, локальный лидер — `\`.

Репозиторий с конфигом инициализирован в `~/.config/nvim`: изменения можно отслеживать через `git status`, `git diff` и `git log`.

## Быстрый старт

```text
,ff        открыть файл
,fg        поиск по содержимому проекта
,e         дерево файлов
,gs        git status в Telescope
]c / [c    следующий / предыдущий git hunk
,ga        stage hunk
,gl        включить inline blame
,gv        полноэкранный diff (Diffview)
```

Полная шпаргалка — в разделе [Клавиши](#клавиши).

## Возможности

- **Git**: `gitsigns` (hunks, stage/reset, blame), `diffview` (полный diff и история), `fugitive` (`:Git`), Telescope-пикеры, git-источник Neo-tree.
- **LSP**: `lua_ls`, `pyright`, `gopls`, `ts_ls`, `clangd`, `neocmakelsp`, `bashls`, `sqls`.
- **Автодополнение**: `nvim-cmp`, `LuaSnip`, `cmp-nvim-lsp`, buffer/path-источники.
- **Форматирование**: `conform.nvim` — `stylua`, `black`, `prettier`, `clang-format`, `sqruff`.
- **Навигация**: Telescope + fzf-native, Neo-tree.
- **Редактирование**: mini.comment, nvim-autopairs, neoscroll, toggleterm.
- **Внешний вид**: jellybeans по умолчанию, доступны kanagawa, gruvbox, melange, прозрачный фон.
- **Фолдинг**: Treesitter + nvim-ufo.
- **AI**: avante.nvim с провайдером Gemini.
- **SQL**: `sqls.nvim` и выполнение запросов из буфера.

## Требования

- Neovim **0.11+** (конфиг проверен на 0.12.5).
- `git`.
- `ripgrep` (`rg`) — для `live_grep`.
- `fd` — желательно для `find_files` (иначе используется встроенный поиск).
- `make` и C-компилятор — для сборки `telescope-fzf-native` и парсеров Treesitter.
- Nerd Font — для иконок.
- WSL: `win32yank.exe` по пути `/home/xyz/bin/win32yank.exe` для системного буфера. На обычном Linux этот блок нужно убрать или заменить.
- Опционально: `node`/`npm` (pyright, ts_ls, prettier), `python3` (pyright, black), `go`, `clang`, JDK, `cargo` (сборка avante), `jupytext` (ноутбуки).

## Установка

```bash
# скопируйте или клонируйте конфиг
git clone <repo-url> ~/.config/nvim
# или уже существующий каталог:
cd ~/.config/nvim
```

Запустите Neovim:

```bash
nvim
```

`lazy.nvim` установится автоматически, затем:

```vim
:Lazy sync
:checkhealth
:Mason
```

Для установки LSP-серверов и инструментов:

```vim
:MasonInstall pyright gopls typescript-language-server clangd bash-language-server sqls
:TSUpdate
```

## Структура

```text
~/.config/nvim
├── init.lua              -- точка входа, lazy.nvim, leader, colorscheme
├── lazy-lock.json        -- зафиксированные версии плагинов
├── lua/
│   ├── config/           -- настройки модулей
│   └── plugins/          -- спецификации плагинов
├── snippets/             -- LuaSnip-сниппеты (java, python)
└── README.md
```

### Какие модули подключены

| Файл | Статус | Назначение |
|---|---|---|
| `lua/config/opt.lua` | подключён | общие опции Neovim |
| `lua/config/keymaps.lua` | подключён | глобальные клавиши |
| `lua/config/lsp_config.lua` | подключён | настройка LSP-серверов |
| `lua/config/formatters.lua` | подключён | conform и `,f` |
| `lua/config/git.lua` | подключён | gitsigns, lualine, git-клавиши |
| `lua/config/neo-tree.lua` | через плагин | настройка Neo-tree |
| `lua/config/treesitter.lua` | через плагин | парсеры и подсветка |
| `lua/config/ufo.lua` | через плагин | фолдинг |
| `lua/config/core.lua` | вспомогательный | строковые утилиты, нужен только `java.lua` |
| `lua/config/aoutocomands.lua` | **не подключён** | запуск файлов по `<C-h>`, автоформат C/C++ |
| `lua/config/ipy.lua` | **не подключён** | Jupyter/Molten |
| `lua/config/java.lua` | **не подключён** | расширенная настройка jdtls |
| `lua/config/linters.lua` | **не подключён** | nvim-lint |

## Клавиши

Обозначения:

- `<leader>` = `,`
- `<localleader>` = `\`
- `<Space>` = клавиша пробел (не лидер)
- Режимы: `n` — normal, `v` — visual, `i` — insert, `x` — visual block.

### Базовые

| Режим | Клавиши | Действие |
|---|---|---|
| `i` | `jk` | выйти в normal |
| `n` | `,<Space>` | снять подсветку поиска |
| `n` | `H` | предыдущая вкладка |
| `n` | `L` | следующая вкладка |
| `n` | `gw` | перейти на предыдущий буфер и закрыть текущий |
| `n` | `,e` | Neo-tree: открыть и показать текущий файл |
| `n` | `,d` | Neo-tree: toggle |
| `n` | `<C-t>` | toggleterm: плавающий терминал |
| `n` | `<C-u>`, `<C-d>`, `<C-b>`, `<C-f>`, `<C-y>`, `<C-e>`, `zt`, `zz`, `zb` | плавный скролл (neoscroll) |

### Поиск и файлы

| Режим | Клавиши | Действие |
|---|---|---|
| `n` | `,ff` | Telescope: найти файл |
| `n` | `,fg` | Telescope: поиск по тексту (`live_grep`) |
| `n` | `,gf` | Telescope: git-файлы |
| `n` | `,gb` | Telescope: git-ветки |
| `n` | `,gc` | Telescope: git-коммиты |
| `n` | `,gs` | Telescope: git status |
| `n` | `<C-d>` в `git_status` | открыть выбранный файл в Diffview |

### Git: просмотр и staging

Клавиши работают в буферах, где `gitsigns` подключён к git-репозиторию.

| Режим | Клавиши | Действие |
|---|---|---|
| `n` | `]c` | следующий hunk |
| `n` | `[c` | предыдущий hunk |
| `n` | `,gp` | preview hunk во всплывающем окне |
| `n` | `,ga` | stage текущий hunk |
| `v` | `,ga` | stage выделенные hunks |
| `n` | `,gr` | reset текущего hunk |
| `v` | `,gr` | reset выделенных hunks |
| `n` | `,gA` | stage весь буфер |
| `n` | `,gR` | reset весь буфер |
| `n` | `,gl` | включить/выключить inline blame |
| `n` | `,gB` | полный blame текущей строки |
| `n` | `,gd` | diff рабочей копии с индексом |
| `n` | `,gD` | diff рабочей копии с `HEAD` |
| `n` | `,gt` | показать/скрыть удалённые строки |

### Git: Diffview и Fugitive

| Режим | Клавиши | Действие |
|---|---|---|
| `n` | `,gv` | `DiffviewOpen` — полный diff |
| `n` | `,gq` | `DiffviewClose` |
| `n` | `,gH` | история текущего файла |
| `n` | `,gC` | история всего репозитория |
| `n` | `,gg` | Fugitive: `:Git` (status) |
| `n` | `,gL` | Fugitive: `git log --oneline --graph --decorate --all` |
| `n` | `,gN` | Neo-tree: источник `git_status` |

В окне Diffview нажмите `g?`, чтобы увидеть его собственные клавиши.

В окне `:Git` (Fugitive) работают стандартные действия: `s` — stage, `u` — unstage, `-` — stage/unstage, `cc` — commit, `dv` — diff, `X` — discard.

### LSP

Клавиши появляются в буфере после подключения LSP-сервера.

| Режим | Клавиши | Действие |
|---|---|---|
| `n` | `gd` | переход к определению |
| `n` | `K` | hover-документация |
| `n` | `<Space>rn` | переименование |
| `n` | `gi` | реализации |
| `n` | `<C-k>` | подсказка сигнатуры |
| `n` | `<Space>ca` | code action |
| `n` | `gr` | references через Telescope |
| `n` | `<Space>e` | диагностика во всплывающем окне |
| `n` | `[d` | предыдущая диагностика |
| `n` | `]d` | следующая диагностика |
| `n` | `<Space>q` | диагностика в loclist |
| `n` | `<Space>f` | форматирование через LSP |
| `n`/`v` | `,sr` | выполнить SQL-запрос (sqls) |

Обратите внимание: `<Space>...` — это именно пробел, а не `,`.

### Форматирование и комментарии

| Режим | Клавиши | Действие |
|---|---|---|
| `n`/`v` | `,f` | форматировать через conform |
| `n`/`v` | `,c` | комментарий (mini.comment) |
| `n`/`v` | `gc` | textobject комментариев (например, `gcip`) |

Форматтеры по типам файлов:

| filetype | formatter |
|---|---|
| lua | stylua |
| python | black |
| javascript / typescript | prettier |
| c / cpp | clang-format |
| sql | sqruff |
| java | LSP fallback, если Java LSP подключён (по умолчанию выключен) |

Инструменты должны быть установлены в `PATH`. Проверить: `:ConformInfo`.

### Фолдинг

| Режим | Клавиши | Действие |
|---|---|---|
| `n` | `,zR` | раскрыть все фолды |
| `n` | `,zM` | свернуть все фолды |
| `n` | `,za` | переключить текущий фолд |
| `n` | `,zo` | открыть текущий фолд |
| `n` | `,zc` | закрыть текущий фолд |
| `n` | `zR`, `zM`, `za`, `zo`, `zc` | стандартные команды Vim также работают |

### Neo-tree

Открытие: `,e` (с reveal текущего файла), `,d` (toggle), `,gN` (git status).

Внутри окна Neo-tree:

| Клавиши | Действие |
|---|---|
| `l` | открыть |
| `h` | закрыть узел |
| `<CR>` | открыть |
| `A` | создать директорию |
| `a` | создать файл |
| `d` | удалить |
| `r` | переименовать |
| `y` | копировать в буфер обмена |
| `p` | вставить из буфера обмена |
| `q` | показать/скрыть скрытые файлы |
| `v` | открыть в vertical split |
| `s` | открыть в horizontal split |
| `t` | открыть в новой вкладке |
| `P` | preview |

### Автодополнение и сниппеты

В режиме вставки (`nvim-cmp`):

| Клавиши | Действие |
|---|---|
| `<C-Space>` | открыть меню дополнения |
| `<C-e>` | закрыть меню |
| `<CR>` | подтвердить выбор |
| `<C-p>` / `<Up>` | предыдущий пункт |
| `<C-n>` / `<Down>` | следующий пункт |

`nvim-autopairs` работает автоматически в insert mode.

Сниппеты лежат в `snippets/java.lua` и `snippets/python.lua`. По умолчанию загрузчик LuaSnip для них **не настроен**; как включить — см. раздел [Неактивные модули](#неактивные-модули).

## Гайд по работе с Git

### 1. Посмотреть, что изменено

```text
,gs
```

Откроется Telescope со списком изменённых файлов. Внутри:

- `<CR>` — открыть файл;
- `<C-d>` — открыть выбранный файл в Diffview.

Альтернативы:

```text
,gg     Fugitive status
,gd     diff текущего файла с индексом
,gD     diff текущего файла с HEAD
,gv     Diffview по всему репозиторию
```

### 2. Перемещаться по изменениям

В открытом файле:

```text
]c      следующий hunk
[c      предыдущий hunk
,gp     посмотреть hunk во всплывающем окне
```

### 3. Stage / reset

```text
,ga     stage hunk под курсором
,gr     reset hunk под курсором
,gA     stage весь буфер
,gR     reset весь буфер
```

Для частичного stage:

1. Выделите строки в visual mode.
2. Нажмите `,ga`.

### 4. Blame

```text
,gl     включить/выключить inline blame
,gB     показать полный blame строки
```

Inline blame показывает автора, время и summary коммита в конце строки.

### 5. История файла

```text
,gH     история текущего файла в Diffview
,gC     история всего репозитория
,gL     git log в виде графа (Fugitive)
```

Дополнительные команды Diffview:

```vim
:DiffviewOpen HEAD~2
:DiffviewOpen -- path/to/file
:DiffviewFileHistory %
:DiffviewClose
```

### 6. Neo-tree git status

```text
,gN
```

Открывает Neo-tree с источником `git_status`. Удобно для обзора изменённых файлов и переключения между ними.

## Гайд по LSP

Подключённые серверы:

| Сервер | Языки |
|---|---|
| `lua_ls` | Lua |
| `pyright` | Python |
| `gopls` | Go |
| `ts_ls` | JavaScript / TypeScript |
| `clangd` | C / C++ |
| `neocmakelsp` | CMake |
| `bashls` | Bash / Sh |
| `sqls` | SQL |

Установка и управление:

```vim
:Mason
:MasonInstall pyright gopls typescript-language-server clangd bash-language-server sqls
:checkhealth vim.lsp
```

Python-настройки используют `.venv` в текущем проекте:

```lua
pythonPath = "./.venv/bin/python"
venvPath = "./"
venv = ".venv"
```

Если виртуальное окружение лежит в другом месте, поправьте `lua/config/lsp_config.lua`.

### SQL

Для `sqls` в `lua/config/lsp_config.lua` заданы подключения-заглушки. Замените параметры подключения на свои:

```lua
dataSourceName = "host=... port=... user=... password=... dbname=... sslmode=disable"
```

Не коммитьте реальные пароли. Выполнение запроса:

```text
,sr     выполнить строку или выделенный SQL
```

## Гайд по форматированию

Ручной запуск:

```text
,f
```

Проверка доступных форматтеров:

```vim
:ConformInfo
```

Автоформат при сохранении в этом конфиге **не включён**. Если нужен — есть два варианта:

1. Включить `lua/config/aoutocomands.lua` (там есть `BufWritePre` для C/C++).
2. Добавить свой `BufWritePre` с `require("conform").format({ async = false })`.

## Гайд по фолдингу

Используется `nvim-ufo` + Treesitter. По умолчанию фолды раскрыты (`foldlevel = 99`).

```text
,zM     свернуть всё
,zR     раскрыть всё
,za     переключить фолд
```

## Терминал

`<C-t>` открывает/закрывает плавающий терминал (`toggleterm`, ширина 20, позиция float).

Команды:

```vim
:ToggleTerm
:TermExec cmd="ls"
```

## AI (avante.nvim)

Провайдер — Gemini, модель `gemini-2.5-flash`. Для работы нужен API-ключ Gemini в окружении или в настройках провайдера.

Основные команды:

```vim
:AvanteAsk
:AvanteChat
:AvanteEdit
:AvanteToggle
```

Если при установке avante пишет `cargo: No such file or directory`, установите Rust/Cargo для полной сборки нативного компонента.

## Внешний вид

По умолчанию включён `jellybeans` (`init.lua`). Доступные альтернативы:

- `kanagawa` — прозрачная тема, настроена в `lua/plugins/ui.lua`;
- `gruvbox`;
- `melange`.

Чтобы сменить тему, раскомментируйте нужную строку в `init.lua`:

```lua
-- vim.cmd([[colorscheme kanagawa]])
-- vim.cmd([[colorscheme gruvbox]])
-- vim.cmd([[colorscheme melange]])
vim.cmd([[colorscheme jellybeans]])
```

`transparent.nvim` делает прозрачными `NormalFloat`, `NeoTreeNormal`, `NeoTreeNormalNC`.

## Управление плагинами

```vim
:Lazy          " UI менеджера
:Lazy sync     " установить/обновить/удалить
:Lazy update   " обновить плагины
:Lazy clean    " удалить неиспользуемые
:Lazy profile  " профилирование времени загрузки
```

Новый плагин добавляется файлом `lua/plugins/<name>.lua`, который возвращает спецификацию lazy.nvim:

```lua
return {
  "author/plugin.nvim",
  event = "VeryLazy",
  opts = {},
}
```

`lazy-lock.json` хранит зафиксированные версии и должен быть в git.

### Основные плагины

| Категория | Плагины |
|---|---|
| Менеджер | lazy.nvim |
| Базовые | plenary.nvim, nui.nvim, nvim-web-devicons |
| Поиск | telescope.nvim, telescope-fzf-native.nvim |
| Дерево | neo-tree.nvim |
| Git | gitsigns.nvim, diffview.nvim, vim-fugitive, vim-rhubarb |
| LSP | nvim-lspconfig, mason.nvim, mason-tool-installer.nvim |
| Автодополнение | nvim-cmp, cmp-nvim-lsp, cmp-buffer, cmp-path, LuaSnip, cmp_luasnip |
| Форматирование | conform.nvim |
| Редактирование | mini.comment, nvim-autopairs, neoscroll.nvim |
| UI | lualine.nvim, kanagawa.nvim, gruvbox.nvim, melange-nvim, jellybeans.vim, transparent.nvim, which-key.nvim, dressing.nvim |
| Treesitter | nvim-treesitter, nvim-ufo, promise-async |
| Терминал | toggleterm.nvim |
| AI | avante.nvim, mega.logging, mega.cmdparse |
| SQL | sqls.nvim |
| Прочее | vim-dispatch, auto-save.nvim (установлен, но не настроен) |

## Неактивные модули

Некоторые файлы уже есть в конфиге, но не подключены в `init.lua`. Их можно включить при необходимости.

### `aoutocomands.lua`

Даёт `<C-h>` для запуска текущего файла:

- Lua: `lua %`
- Python: `python3 %`
- C: `gcc % -o out; ./out`
- Sh/Go: `%`
- Java: `javac % && java %:r`

Также включает автоформат C/C++ при сохранении. Включение:

```lua
require("config.aoutocomands")
```

### `linters.lua`

Настроен `nvim-lint` для Python, JavaScript и Java. Нужно установить сам `nvim-lint` (сейчас его нет в `lazy-lock.json`) и раскомментировать:

```lua
require("config.linters")
```

### `java.lua`

Расширенная настройка `jdtls`: Java 8/11/17/21/23/25 через sdkman, Lombok, debug/test-адаптеры, команды запуска тестов. Требует `jdtls` и соответствующие JDK. Включение в `init.lua`:

```lua
require("config.java").setup()
```

### `ipy.lua`

Поддержка Jupyter-ноутбуков через `jupytext` и `molten-nvim`. Требует установки `jupytext`, `molten-nvim`. Клавиши после включения:

```text
,rr     выполнить строку / выделение
,rc     выполнить cell
,ra     выполнить весь буфер
,ro     показать вывод
,rk     перезапустить
```

### auto-save

Плагин установлен, но `require("auto-save").setup()` закомментирован. Если включить, файлы будут сохраняться автоматически — используйте осознанно.

### Сниппеты LuaSnip

Файлы `snippets/java.lua` и `snippets/python.lua` не загружаются автоматически. Добавьте в `lua/plugins/cmp.lua` в `config`:

```lua
require("luasnip.loaders.from_lua").load({
  paths = vim.fn.stdpath("config") .. "/snippets",
})
```

Доступные сниппеты:

- Java: `pack`, `class`, `main`, `spring`, `test`, `rest`, `service`, `repo`, `entity`, `record`, `interface`, `enum`, `sout`, `log`, `try`.
- Python: `def`, `pr`, `ppr`, `wlog`.

## Настройки Neovim

Основное — в `lua/config/opt.lua`:

- `number` и `relativenumber` включены;
- отступ 2 пробела, `expandtab`;
- `swapfile = false`;
- `scrolloff = 7`;
- системный буфер `unnamedplus`;
- `updatetime = 250`, `signcolumn = "yes"`, `timeoutlen = 400`;
- `splitbelow` и `splitright` включены.

Системный буфер в WSL настроен через `win32yank`:

```lua
vim.g.clipboard = {
  name = "win32yank",
  copy  = { ["+"] = "/home/xyz/bin/win32yank.exe -i --crlf", ... },
  paste = { ["+"] = "/home/xyz/bin/win32yank.exe -o --lf",  ... },
}
```

Если путь другой или вы не в WSL — измените этот блок или удалите его.

## Кастомизация

Где что менять:

| Что | Файл |
|---|---|
| Глобальные клавиши | `lua/config/keymaps.lua` |
| Git-клавиши | `lua/config/git.lua` |
| LSP | `lua/config/lsp_config.lua` |
| Форматтеры | `lua/config/formatters.lua` |
| Neo-tree | `lua/config/neo-tree.lua` |
| Treesitter | `lua/config/treesitter.lua` |
| Фолдинг | `lua/config/ufo.lua` |
| Плагины | `lua/plugins/*.lua` |
| Цветовая схема | `init.lua` |

Пример новой клавиши:

```lua
vim.keymap.set("n", "<leader>x", ":echo 'hello'<CR>", { desc = "Моя команда" })
```

`which-key` покажет её в меню после `,`.

## Git для самого конфига

```bash
cd ~/.config/nvim
git status
git diff
git add .
git commit -m "Update nvim config"
```

`.gitignore` исключает swap-файлы и системный мусор. `lazy-lock.json` нужно коммитить.

## Диагностика проблем

| Проблема | Решение |
|---|---|
| Не работает системный буфер | Проверьте путь к `win32yank.exe` в `lua/config/opt.lua`; на Linux удалите `vim.g.clipboard` |
| LSP не запускается | `:checkhealth vim.lsp`, `:Mason`, проверьте установлен ли сервер |
| `lua_ls` не найден | В `lsp_config.lua` жёстко задан путь к серверу; поправьте `cmd` или удалите его |
| Форматтер не работает | `:ConformInfo`; проверьте, что бинарник в `PATH` |
| Treesitter-ошибки | `:TSUpdate`, проверьте наличие компилятора и `tree-sitter` |
| Diffview не открывает untracked файл | Сначала добавьте файл в индекс (`git add`) |
| `,g` не открывает grep | Теперь grep на `,fg`, префикс `,g` занят git-командами |
| avante не собирается | Установите `cargo`; сообщение о сборке не влияет на остальной конфиг |
| SQL-запросы не работают | Замените заглушки подключения в `lsp_config.lua`, проверьте запущен ли сервер БД |
| Сниппеты не появляются | Настройте загрузчик LuaSnip (см. раздел «Неактивные модули») |
| Java/IPython/линтеры не работают | Эти модули не подключены в `init.lua`; см. раздел «Неактивные модули» |

## Полезные команды

```vim
:Lazy
:Mason
:checkhealth
:checkhealth vim.lsp
:TSUpdate
:ConformInfo
:DiffviewOpen
:DiffviewFileHistory %
:Git
:Neotree git_status
```
