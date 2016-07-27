var myApp = angular.module('fishyfishy', ['ngRoute']);

      myApp.config(function($routeProvider, $httpProvider) {
        $routeProvider
        .when('/', {
          controller: 'summaryController',
          templateUrl: '/partials/summary.html'
        })
        .when('/add', {
          controller: 'addController',
          templateUrl: '/partials/add.html'
        })
        .when('/summary', {
          controller: 'summaryController',
          templateUrl: '/partials/summary.html'
        })
        .otherwise({
          redirectTo: '/'
        })
        $httpProvider.defaults.headers.common['X-CSRF-Token'] = $('meta[name=csrf-token]').attr('content');
      })

      // Add Fish Page //
      myApp.factory('addFactory', ['$http', function($http) {
        var factory = {};

        factory.submitFish = function(data) {
          console.log(data);
          return $http.post('/submitfishes', data);
        }

        return factory;
      }])

      myApp.controller('addController', ['$scope', '$location', 'addFactory', function($scope, $location, addFactory) {
        // function FishQueue() {
        //   this.size = 0;
        //   this.data = [];
        // }
        //
        // FishQueue.prototype.addFish = function(fishData) {
        //   this.data[this.size++] = fishData;
        // }
        //
        // var myFish = new FishQueue();

        $scope.fishQueue = [];

        function tempFishObject(fish) {
          var newFish = {};
          for (var key in fish) {
            if (fish.hasOwnProperty(key)) {
              newFish[key] = fish[key];
            }
          }
          return newFish;
        }

        function resetFields() {
          $("#select-fish option:first").attr('selected','hidden');
          $("#wild-hatch option:first").attr('selected','hidden');
          $("#river-code option:first").attr('selected','hidden');
        }

        $scope.addFish = function() {
          var tempObject = tempFishObject($scope.newFish);
          $scope.fishQueue.push(tempObject);
          // console.log($('#select-fish option:selected').html());
          resetFields();
        }

        $scope.submitFish = function() {
          addFactory.submitFish($scope.fishQueue);
          console.log("in submit fish - scope fishQueue")
          console.log($scope.fishQueue)
          $location.path('/');
        }
      }])

      // Summary Page //
      myApp.factory('summaryFactory', ['$http', function($http) {
        var factory = {};

        factory.getEntries = function(callback) {
          $http.get('/entries').success(function(data) {
            console.log(data)
            callback(data);
          })
        }

        factory.editEntry = function(id) {
          return $http.put('/edit/:id');
        }

        // Is this correct? //
        factory.getDateData = function(date, callback) {
          console.log(date);
          $http.get('/fish_date_count/'+ date).success(function(data) {
            console.log(data)
            callback(data);
          });
        }

        return factory;
      }])

      myApp.controller('summaryController', ['$scope', 'summaryFactory', function($scope, summaryFactory) {

        var getEntries = function() {
          summaryFactory.getEntries(function(data) {
            var catchInfo = data.user_catch_info,
                totalByDay = data.user_date_and_counts;

            $scope.entries = totalByDay;

            var fishArray = [0, 0, 0, 0, 0],
                wildOrHatch = [0, 0];

            catchInfo.forEach(function(obj) {
              fishArray[obj.fish_id - 1]++;
              if (obj.wild_or_hatchery === "Wild") {
                wildOrHatch[0]++;
              } else {
                wildOrHatch[1]++;
              }
            })

            var totalFish = fishArray.reduce(function(a, b) {
              return a + b;
            })

            $scope.fishArray = fishArray;
            $scope.totalFish = totalFish;
            $scope.wildOrHatch = wildOrHatch;
            console.log("fish Array is: " + fishArray)
            console.log("totalfish is: " + totalFish)
            console.log("wildOrHatch is: " + wildOrHatch)

            $('#summary-date').hide();

          });
        }

        getEntries();

        $scope.getEntries = function() {getEntries();
        }

        $scope.editEntry = function(id) {
          summaryFactory.editEntry(id);
        }

        $scope.dateData = function(date) {
          console.log(date);
          summaryFactory.getDateData(date, function(data) {
            var catchInfo = data.user_catch_info,
                totalByDay = data.user_date_and_counts;

            $scope.entries = totalByDay;

            var fishArray = [0, 0, 0, 0, 0],
                wildOrHatch = [0, 0];

            catchInfo.forEach(function(obj) {
              fishArray[obj.fish_id - 1]++;
              if (obj.wild_or_hatchery === "Wild") {
                wildOrHatch[0]++;
              } else {
                wildOrHatch[1]++;
              }
            })

            var totalFish = fishArray.reduce(function(a, b) {
              return a + b;
            })

            $('#summary-date').show();

            $scope.fishArray = fishArray;
            $scope.totalFish = totalFish;
            $scope.wildOrHatch = wildOrHatch;
            $scope.dateParam = date;

          });
        };
      }])


