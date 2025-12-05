(function () {
	'use strict';

	//
	// A demo Point to test the build setup
	//

	class Point {
	  constructor() {
	    let x = arguments.length > 0 && arguments[0] !== undefined ? arguments[0] : 0;
	    let y = arguments.length > 1 && arguments[1] !== undefined ? arguments[1] : 0;
	    this.x = x;
	    this.y = y;
	  }
	  draw() {
	    return "[".concat(this.x, ", ").concat(this.y, "]");
	  }
	}

	//
	//	This is the app's main JS file.
	//	
	//	It must export a single `default function` that gets imported and
	//	executed by the two wrapper files in the parent `js` folder.
	//

	function initialize () {
	  const pointTest = new Point(5, 10);
	  console.log(pointTest.draw());
	}

	//
	//	This is the "nomodule" version of the app's main JS file.
	//	This file should be transpiled and bundled by CodeKit as a
	//	fallback file for browsers that don't support JS modules.
	//
	//	It's purely a wrapper file — code your app in the app.js file
	//	referenced below along with various modules beside it.
	//

	document.addEventListener('DOMContentLoaded', initialize);

})();
