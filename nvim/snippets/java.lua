local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

-- Функция для автоматического определения package на основе пути файла
local get_package = function()
	local file_path = vim.fn.expand("%:p")
	local java_patterns = {
		"src/main/java/",
		"src/test/java/",
		"src/java/",
		"java/",
	}

	for _, pattern in ipairs(java_patterns) do
		local start_idx = string.find(file_path, pattern)
		if start_idx then
			local package_path = string.sub(file_path, start_idx + string.len(pattern))
			local package = string.gsub(package_path, "/[^/]*$", "") -- Убираем имя файла
			package = string.gsub(package, "/", ".")
			if package ~= "" then
				return "package " .. package .. ";"
			end
		end
	end

	return "package com.example;"
end

-- Функция для автоматического определения имени класса из имени файла
local get_class_name = function()
	local filename = vim.fn.expand("%:t:r") -- Имя файла без пути и расширения
	-- Убираем суффиксы типа Test, Controller и т.д. для основного имени класса

	local base_name = filename
		:gsub("Test$", "")
		:gsub("Controller$", "")
		:gsub("Service$", "")
		:gsub("Repository$", "")
		:gsub("Impl$", "")

	-- Преобразуем snake_case и kebab-case в CamelCase
	if base_name:find("[_%-]") then
		base_name = base_name:gsub("([_%-])(%a)", function(_, letter)
			return letter:upper()
		end)
		base_name = base_name:sub(1, 1):upper() .. base_name:sub(2)
	else
		-- Просто делаем первую букву заглавной если нет разделителей
		base_name = base_name:sub(1, 1):upper() .. base_name:sub(2)
	end

	return base_name
end

-- Функция для получения имени класса с суффиксом
local get_class_name_with_suffix = function(_, parent, user_args)
	local suffix = user_args[1] or ""
	local class_name = get_class_name()
	-- Если имя класса уже заканчивается на суффикс, не добавляем повторно
	if suffix ~= "" and not class_name:lower():endswith(suffix:lower()) then
		return class_name .. suffix
	end
	return class_name
end

return {
	-- Package с автоматическим определением
	s("pack", {
		f(get_package),
		t({ "", "" }),
	}),

	-- Полный класс с автоматическим package и именем класса
	s("class", {
		f(get_package),
		t({ "", "", "public class " }),
		f(get_class_name),
		t({ " {", "\t" }),
		i(1, "// fields"),
		t({ "", "", "\tpublic " }),
		f(get_class_name),
		t("() {"),
		t({ "", "\t\t" }),
		i(2, "// constructor code"),
		t({ "", "\t}", "" }),

		i(3, "// methods"),
		t({ "", "}" }),
	}),

	-- Main class с автоматическим именем
	s("main", {
		f(get_package),
		t({ "", "", "public class " }),
		f(get_class_name),
		t({ " {", "\t" }),
		t("public static void main(String[] args) {"),
		t({ "", "\t\t" }),
		i(1, 'System.out.println("Hello, world!");'),
		t({ "", "\t}", "}" }),
	}),

	-- Spring Boot приложение
	s("spring", {

		f(get_package),
		t({
			"",
			"",
			"import org.springframework.boot.SpringApplication;",
			"import org.springframework.boot.autoconfigure.SpringBootApplication;",
			"",
			"@SpringBootApplication",
			"public class ",
		}),
		f(get_class_name),
		t({ " {", "\t" }),
		t("public static void main(String[] args) {"),

		t({ "", "\t\tSpringApplication.run(" }),
		f(get_class_name),
		t(".class, args);"),
		t({ "", "\t}", "}" }),
	}),

	-- JUnit test класс
	s("test", {
		f(get_package),
		t({
			"",
			"",
			"import org.junit.jupiter.api.Test;",

			"import static org.junit.jupiter.api.Assertions.*;",
			"",
			"class ",
		}),
		f(get_class_name_with_suffix, {}, { user_args = { "Test" } }),
		t({ " {", "\t" }),
		t("@Test"),
		t({ "", "\tvoid " }),
		i(1, "shouldDoSomething"),
		t("() {"),
		t({ "", "\t\t" }),
		i(2, "// given"),
		t({ "", "", "\t\t" }),
		i(3, "// when"),
		t({ "", "", "\t\t" }),
		i(4, "// then"),
		t({ "", "\t}", "}" }),
	}),

	-- REST Controller
	s("rest", {
		f(get_package),

		t({
			"",
			"",
			"import org.springframework.web.bind.annotation.*;",
			"",
			"@RestController",
			'@RequestMapping("',
		}),
		i(1, "/api"),
		t({ '")', "public class " }),

		f(get_class_name_with_suffix, {}, { user_args = { "Controller" } }),
		t({ " {", "\t" }),
		i(2, "// endpoints"),
		t({ "", "}" }),
	}),

	-- Service класс
	s("service", {
		f(get_package),
		t({ "", "", "import org.springframework.stereotype.Service;", "", "@Service", "public class " }),
		f(get_class_name_with_suffix, {}, { user_args = { "Service" } }),
		t({ " {", "\t" }),
		i(1, "// business logic"),
		t({ "", "}" }),
	}),

	-- Repository интерфейс
	s("repo", {
		f(get_package),
		t({ "", "", "import org.springframework.data.jpa.repository.JpaRepository;", "", "public interface " }),
		f(get_class_name_with_suffix, {}, { user_args = { "Repository" } }),
		t(" extends JpaRepository<"),
		i(1, "Entity"),
		t(", "),
		i(2, "Long"),
		t({ "> {", "\t" }),
		i(3, "// custom queries"),
		t({ "", "}" }),
	}),

	-- Entity класс
	s("entity", {

		f(get_package),
		t({ "", "", "import jakarta.persistence.*;", "", "@Entity", 
'@Table(name = "' }),
		i(1, "table_name"),
		t({ '")', "public class " }),
		f(get_class_name),
		t({ " {", "\t" }),
		t({ "@Id", "\t@GeneratedValue(strategy = GenerationType.IDENTITY)", "\tprivate Long id;" }),
		t({ "", "", "\t" }),
		i(2, "// fields"),
		t({ "", "", "\t// constructors", "\tpublic " }),
		f(get_class_name),
		t("() {}"),
		t({ "", "", "\t// getters and setters" }),

		i(3, "// methods"),
		t({ "", "}" }),
	}),

	-- Record (Java 14+)
	s("record", {
		f(get_package),
		t({ "", "", "public record " }),
		f(get_class_name),
		t("("),
		i(1, "String field1, int field2"),
		t({ ") {", "\t" }),
		i(2, "// methods"),
		t({ "", "}" }),
	}),

	-- Interface
	s("interface", {
		f(get_package),
		t({ "", "", "public interface " }),
		f(get_class_name),
		t({ " {", "\t" }),
		i(1, "// methods"),
		t({ "", "}" }),
	}),

	-- Enum
	s("enum", {
		f(get_package),
		t({ "", "", "public enum " }),
		f(get_class_name),
		t({ " {", "\t" }),

		i(1, "VALUE1, VALUE2, VALUE3"),
		t({ "", "", "\t" }),
		i(2, "// fields and methods"),
		t({ "", "}" }),
	}),

	-- Print to console
	s("sout", {
		t("System.out.println("),
		i(1, '"Hello, world!"'),
		t(");"),
	}),

	-- Logger declaration
	s("log", {
		t("private static final Logger log = LoggerFactory.getLogger("),
		f(get_class_name),
		t(".class);"),
	}),

	-- Try-catch with resources

	s("try", {
		t({ "try (" }),
		i(1, "ResourceType resource = new Resource()"),
		t({ ") {", "\t" }),
		i(2, "// code"),
		t({ "", "} catch (" }),
		i(3, "Exception e"),
		t({ ") {", "\t" }),
		i(4, 'log.error("Error: {}", e.getMessage());'),
		t({ "", "}" }),
	}),
}
