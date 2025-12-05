//
// A demo Point to test the build setup
//

class Point {
	constructor(x = 0, y = 0) {
		this.x = x;
		this.y = y;
	}
	
	draw() {
		return `[${this.x}, ${this.y}]`
	}
}

//
//	This is the app's main JS file.
//	
//	It must export a single `default function` that gets imported and
//	executed by the two wrapper files in the parent `js` folder.
//


function initialize() {
	const pointTest = new Point(5, 10);
	console.log(pointTest.draw());
}

//
//	This is the "module" version of the app's main JS file.
//	It's purely a wrapper file — code your app in the app.js file
//	referenced below along with various modules beside it.
//


initialize();
