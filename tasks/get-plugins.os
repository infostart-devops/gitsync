#Использовать gitrunner
#Использовать tempfiles
#Использовать fs

Перем Лог;

Процедура ПолучитьИсходники(Знач URLРепозитория, Знач Ветка, Знач Каталог)

	ГитРепозиторий = Новый ГитРепозиторий;

	ГитРепозиторий.УстановитьРабочийКаталог(Каталог);

	ГитРепозиторий.КлонироватьРепозиторий(URLРепозитория, Каталог);
	ГитРепозиторий.ПерейтиВВетку(Ветка);

КонецПроцедуры

Процедура СобратьПакет(Знач Каталог)
	
	Лог.Информация("Каталог сборки <%1>", Каталог);

	Лог.Информация("Сборка пакета библиотеки плагинов");
	// Лог.Информация(" - путь к файлу манифеста сборки пакета <%1>", ПутьКМанифестуСборки);
	КомандаOpm = Новый Команда;
	КомандаOpm.УстановитьРабочийКаталог(Каталог);
	КомандаOpm.УстановитьКоманду("opm");
	КомандаOpm.ДобавитьПараметр("build");	
	КомандаOpm.ДобавитьПараметр(Каталог);	
	КомандаOpm.ДобавитьЛогВыводаКоманды("task.install-opm");

	КодВозврата = КомандаOpm.Исполнить();

	Если КодВозврата <> 0  Тогда
		ВызватьИсключение КомандаOpm.ПолучитьВывод();
	КонецЕсли;

	МассивФайлов = НайтиФайлы(Каталог, "*.ospx");

	Если МассивФайлов.Количество() = 0 Тогда
		ВызватьИсключение Новый ИнформацияОбОшибке("Ошибка создания пакета плагинов", "Не найден собранный файл плагина");;
	КонецЕсли;

	ФайлПлагина = МассивФайлов[0].ПолноеИмя;

	КаталогПроекта = ОбъединитьПути(ТекущийСценарий().Каталог, "..", "embedded_plugins");
	
	ФС.ОбеспечитьКаталог(КаталогПроекта);

	УдалитьФайлы(КаталогПроекта, "gitsync-plugins*.ospx");
	
	ФайлПриемник = ОбъединитьПути(КаталогПроекта, МассивФайлов[0].Имя);

	КопироватьФайл(ФайлПлагина, ФайлПриемник);

КонецПроцедуры

Процедура ПолезнаяРабота(ИмяВетки)

	URLРепозитория = "https://github.com/khorevaa/gitsync-plugins.git";
	КаталогСборки = ВременныеФайлы.СоздатьКаталог();

	Лог.Информация("Установка плагинов из
	| репозиторий <%1>
	| ветки <%2>", URLРепозитория, ИмяВетки);
	
	ПолучитьИсходники(URLРепозитория, ИмяВетки, КаталогСборки);
	СобратьПакет(КаталогСборки);

	// При удалении временного каталога файлов исходников выводится ошибка
	// о невозможности удаления подкаталога Git и из-за этого не проходит тест
	Попытка
		УдалитьФайлы(КаталогСборки);
	Исключение
		ТекстОшибки = "Попытка удаления временного каталога "+КаталогСборки+" закончилась неудачей";
	КонецПопытки;
	//ВременныеФайлы.УдалитьФайл(КаталогСборки);

КонецПроцедуры

Лог = Логирование.ПолучитьЛог("task.install-opm");

Если АргументыКоманднойСтроки.Количество() = 0 Тогда
	ИмяВетки = "master";
Иначе
	ИмяВетки = АргументыКоманднойСтроки[0];
КонецЕсли;

ПолезнаяРабота(ИмяВетки);


