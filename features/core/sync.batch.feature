# language: ru

Функционал: Пакетная синхронизация хранилищ конфигурации 1С и гит 
    Как Пользователь
    Я хочу выполнять автоматическую синхронизацию конфигурации из хранилища
    Чтобы автоматизировать свою работы с хранилищем с git

Контекст: Тестовый контекст синхронизации
    Когда Я создаю новый объект ГитРепозиторий
    И Я создаю новый объект ПакетнаяСинхронизация
    # Подготовка хранилища 1
    И Я создаю временный каталог и сохраняю его в переменной "КаталогХранилища1С_1"
    И я скопировал каталог тестового хранилища конфигурации в каталог из переменной "КаталогХранилища1С_1"
    И Я создаю временный каталог и сохраняю его в переменной "ПутьКаталогаИсходников_1"
    И Я инициализирую репозиторий в каталоге из переменной "ПутьКаталогаИсходников_1"
    И Я создаю тестовой файл AUTHORS в каталоге из переменной "ПутьКаталогаИсходников_1"
    И Я записываю "0" в файл VERSION в каталоге из переменной "ПутьКаталогаИсходников_1"

    # Подготовка хранилища 2
    И Я создаю временный каталог и сохраняю его в переменной "КаталогХранилища1С_2"
    И я скопировал каталог тестового хранилища конфигурации в каталог из переменной "КаталогХранилища1С_2"
    И Я создаю временный каталог и сохраняю его в переменной "ПутьКаталогаИсходников_2"
    И Я инициализирую репозиторий в каталоге из переменной "ПутьКаталогаИсходников_2"
    И Я создаю тестовой файл AUTHORS в каталоге из переменной "ПутьКаталогаИсходников_2" 
    И Я записываю "0" в файл VERSION в каталоге из переменной "ПутьКаталогаИсходников_2"

    И Я создаю временный каталог и сохраняю его в переменной "КаталогПроекта"
    И Я добавляю файл "example.yaml" в каталог проекта с содержанием 
    """
globals:
  storage-user: Администратор
  storage-pwd: ''
  git-path: git
  temp-dir: ""
  v8version: 8.3
  domain-email: localhost
  lic-try-count: 5
  plugins:
    enable:
      - test
      - test2
    disable:
      - test3
  plugins-config:
    git-url: git-url
    push: true
    pull: true
repositories:
  - name: ТестовыйРепозиторий
    # disable: false
    path: <КаталогХранилища1С_1>
    dir: <ПутьКаталогаИсходников_1>		
    plugins:
      more:
        - test3
    plugins-config:
      git-url: git-url
      push: true
      pull: true
  - name: ТестовыйРепозиторий2
    # disable: true
    path: <КаталогХранилища1С_2>
    dir: <ПутьКаталогаИсходников_2>		
    storage-user: Администратор
    storage-pwd: ''
    git-path: git
    temp-dir: ""
    v8version: 8.3
    domain-email: localhost
    lic-try-count: 5
  
    """

    И Я заменяю "<КаталогХранилища1С_1>" значением из переменной "КаталогХранилища1С_1" в файле "example.yaml"
    И Я заменяю "<ПутьКаталогаИсходников_1>" значением из переменной "ПутьКаталогаИсходников_1" в файле "example.yaml"
    И Я заменяю "<КаталогХранилища1С_2>" значением из переменной "КаталогХранилища1С_2" в файле "example.yaml"
    И Я заменяю "<ПутьКаталогаИсходников_2>" значением из переменной "ПутьКаталогаИсходников_2" в файле "example.yaml"
    И Я устанавливаю файл настройки "example.yaml" в ПакетнаяСинхронизация
    И Вывод лога содержит "Метод или операция не реализована"
    # И Я включаю отладку лога с именем "oscript.lib.gitsync.batch"
    # И Я включаю отладку лога с именем "oscript.lib.configor"
    # И Я включаю отладку лога с именем "oscript.lib.configor.yaml"
    # И Я включаю отладку лога с именем "oscript.lib.configor.constructor"

#Сценарий: Простая синхронизация хранилища с git-репозиторием
#    Допустим Я устанавливаю авторизацию "Администратор" с паролем "" в ПакетнаяСинхронизация
#    И Я устанавливаю версию платформы "8.3" в ПакетнаяСинхронизация
#    Когда Я выполняю выполняют пакетную синхронизацию
#    Тогда Вывод лога содержит "Завершена синхронизации с git"

# Сценарий: Cинхронизация хранилища с git-репозиторием c плагинами
#     Допустим Я устанавливаю авторизацию в хранилище пользователя "Администратор" с паролем ""
#     И Я устанавливаю версию платформы "8.3"
#     И Я создаю временный каталог и сохраняю его в переменной "КаталогПлагинов"
#     И Я создаю новый МенеджерПлагинов
#     И Я собираю тестовый плагин и сохраняю в контекст "ПутьКФайлуПлагина"
#     И Я устанавливаю файл плагина из переменной "ПутьКФайлуПлагина"
#     И Я загружаю плагины из каталога в переменной "КаталогПлагинов"
#     И Я подключаю плагины в МенеджерСинхронизации
#     Когда Я выполняю выполняют синхронизацию
#     Тогда Вывод лога содержит "Завершена синхронизации с git"
#     И Вывод лога содержит "Вызвано событие <ПриАктивизации> для плагина <test_plugin>"
    