angular.module("sideBySide.controllers", [])
.controller "AppController", [
	() -> null
]
.controller "ComparisonController", [
	'$document', '$location', '$rootScope', '$scope', 'route', 'poems', 'transformer'
	($document, $location, $rootScope, $scope, route, poems, transformer) ->
		min = 1
		max = 5

		scroll = () ->
			setTimeout () ->
				element = document.getElementById($location.hash())
				$document.scrollTo(element) if element
			, 1

		$rootScope.$on 'duScrollspy:becameActive', ($event, $element) ->
			$location.hash($element.prop('id')).replace()
			$rootScope.$apply()

		$scope.$watchCollection () ->
			poems.getActive()
		, () ->
			active = poems.getActive()

			$scope.columns = active.length
			transformed = transformer(active)
			$scope.verses = transformed.verses
			$scope.meta = transformed.meta

			headingKey = poems.heading or "Author"
			$scope.headings = (version[headingKey] for version in transformed.meta)

			$scope.all = poems.all
			scroll()

		$scope.switchActive = (poem) ->
			length = poems.getActive().length
			active = poem.meta.Active
			if ((length > min or not active) and (length < max or active))
				poem.meta.Active = not poem.meta.Active
				# TODO else notification

		$scope.flipPick = () ->
			$scope.pick = not $scope.pick

		$scope.pick = false

		poems.load route.appUrl + '/' + route.params.base
]
