angular.module("sideBySide").factory "readerFactory",
['$injector', ($injector) ->
	# Create poem reader based on file name
	#
	# @param [String] Source file name
	# @return [Object] Reader
	(filename) ->
		extension = filename.split(".").pop()
		switch extension
			when "json"
				return $injector.get "jsonReader"
			when "md", "markdown"
				return $injector.get "markdownReader"
			else
				throw "Unknown extension '" + extension + "'."
]
