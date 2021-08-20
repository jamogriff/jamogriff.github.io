import Constants from './constants.js';

let currentCell; // will become a Cell object
const ctx = Constants.CANVAS.getContext("2d");
const gridWidth = Constants.GRID_WIDTH; // in pixels
const gridOffset = gridWidth / 2;

export default class Maze {
	constructor(x, y, rows, columns) {
		this.width = x;
		this.height = y;
		this.rows = rows;
		this.columns = columns;
		this.grid = [];
		this.stack = [];
		this.complete = false;
	}

	initialize() {
		// Results in 2D array where grid.length = # rows and grid[0].length = # of columns
		// Confusing because instead of an x, y coordinate its essentially y, x pair
		for (let row = 0; row < this.rows; row++) {
			let populatedRow = [];
			for (let column = 0; column < this.columns; column++) {
				// instantiate with reference to maze object with coordinate pair
				let cell = new Cell(row, column, this);
				populatedRow.push(cell);
			}
			this.grid.push(populatedRow);
		}
		// Initialize starting cell and stack for maze generation
		currentCell = this.grid[0][0]; // node at top right
		currentCell.params.visited = true;
	}

	draw() {

		for (let row = 0; row < this.rows; row++) {
			for (let column = 0; column < this.columns; column++) {
				let grid = this.grid;
				grid[row][column].show(this.rows, this.columns);
			}
		}
		/*	
		Since the draw method get called at least 30fps,
		we need to streamline maze generation algorithm
		to run in a more conditional manner.
		
		After selecting the start cell (Cnaut), we check for 3 different states:
		1. A neighbor of Cnaut exists that has not been visited.
			1a. Add Cnaut and neighbor to stack, mark neighbor as visited
			and remove walls between Cnaut and neighbor.
		2. A neighbor of Cnaut does not exist.
			2a. Begin backtracking from stack.
		3. "Base case": stack is empty.

		*/
		let neighbor = currentCell.checkNeighbors();

		// TODO: Add indication animation to indicate backtracking
		if (neighbor) {
			currentCell.highlight(this.columns, this.rows, Constants.PRIMARY_COLOR);
			this.stack.push(currentCell);
			currentCell.removeWalls(neighbor);
			neighbor.params.visited = true;
			this.stack.push(neighbor);
			currentCell = neighbor;
		} else if (this.stack.length > 0) {
			currentCell = this.stack.pop();
			currentCell.highlight(this.columns, this.rows, Constants.PRIMARY_COLOR);
		}

		if (this.stack.length == 0) {
			this.complete = true;
			return;
		}

		window.requestAnimationFrame(() => {
			this.draw();
		});
	}
}

// Probably a big LoD violation in terms of instantiating a Cell
// with it's parent, but there's crossover on a lot of its properties
class Cell {
	constructor(row, column, parent) {
		// a Cell needs to know about the size of the canvas for rendering
		// as well as the grid, to check it's neighbors
		this.mazeWidth = parent.width;
		this.mazeHeight = parent.height;
		this.mazeGrid = parent.grid;
		this.params = {
			row: row,
			column: column,
			visited: false,
			walls: {
				topWall: true,
				bottomWall: true,
				rightWall: true,
				leftWall: true,
			},
		};
	}

	fill(x, y, rows, columns, fillType) {
		ctx.fillStyle = fillType;
		ctx.fillRect(
			x + gridWidth,
			y + gridWidth,
			this.mazeWidth / columns - gridWidth,
			this.mazeHeight / rows - gridWidth
		);
	}

	show(rows, columns) {
		let x = (this.params.column * this.mazeWidth) / columns;
		let y = (this.params.row * this.mazeHeight) / rows;
		ctx.lineWidth = gridWidth;
		WallRenderer.renderWalls(
			this.params.walls,
			x,
			y,
			this.mazeWidth,
			this.mazeHeight,
			rows,
			columns
		);

		if (this.params.visited)
			this.fill(x, y, rows, columns, Constants.BG_COLOR);
	}

	// Columns and rows from maze are passed in to set size of cell
	highlight(columns, rows, color) {
		// transparency added to add a trailing effect in future iteration
		let alpha = "";
		// Refactor to switch cases
		//if (transparency == 1) alpha = "FF";
		//if (transparency == 0.5) alpha = "80";
		//if (transparency == 0.3) alpha = "4D";
		let x = (this.params.column * this.mazeWidth) / columns;
		let y = (this.params.row * this.mazeHeight) / rows;

		this.fill(x, y, rows, columns, color);
	}

	// Logically removes walls, but doesn't render this change
	removeWalls(neighborCell) {
		// compares two neighboring cells on x-axis and y-axis respectively to determine relative location
		let x = this.params.column - neighborCell.params.column;
		let y = this.params.row - neighborCell.params.row;

		// Since two neighboring cells have overlapping walls, two walls must be turned off at the same time
		if (x === -1) {
			this.params.walls.rightWall = false;
			neighborCell.params.walls.leftWall = false;
		} else if (x === 1) {
			this.params.walls.leftWall = false;
			neighborCell.params.walls.rightWall = false;
		}

		// Same concept for y-axis
		if (y === -1) {
			this.params.walls.bottomWall = false;
			neighborCell.params.walls.topWall = false;
		} else if (y === 1) {
			this.params.walls.topWall = false;
			neighborCell.params.walls.bottomWall = false;
		}
	}

	checkNeighbors() {
		let grid = this.mazeGrid;
		let row = this.params.row;
		let column = this.params.column;
		let neighbors = [];

		// Setting the neighbors of a cell, accounting for cells on outside border
		let top = row !== 0 ? grid[row - 1][column] : undefined;
		let bottom =
			row !== grid.length - 1
				? grid[row + 1][column]
				: undefined;
		let right =
			column !== grid[0].length - 1
				? grid[row][column + 1]
				: undefined;
		let left = column !== 0 ? grid[row][column - 1] : undefined;

		// Push neighbors into array if they exist and have not been visited
		// TODO: Refactor to switch cases
		if (top && !top.params.visited) neighbors.push(top);
		if (bottom && !bottom.params.visited) neighbors.push(bottom);
		if (right && !right.params.visited) neighbors.push(right);
		if (left && !left.params.visited) neighbors.push(left);

		// Return neighbors array
		return this.randomNeighbor(neighbors);
	}

	randomNeighbor(neighborArray) {
		if (neighborArray.length !== 0) {
			let random = Math.floor(
				Math.random() * neighborArray.length
			);
			return neighborArray[random];
		} else {
			return undefined;
		}
	}
}

class WallRenderer {
	// Wall hiding functions that are used on cells marked 'false
	static hideTopWall(x, y, width, columns) {
		ctx.beginPath();
		ctx.strokeStyle = Constants.BG_COLOR;
		ctx.moveTo(x + gridWidth, y + gridOffset);
		ctx.lineTo(x + width / columns, y + gridOffset);
		ctx.stroke();
	}

	static hideBottomWall(x, y, width, height, rows, columns) {
		ctx.beginPath();
		ctx.strokeStyle = Constants.BG_COLOR;
		ctx.moveTo(x + gridWidth, gridOffset + y + height / rows);
		ctx.lineTo(
			x + width / columns,
			gridOffset + y + height / rows
		);
		ctx.stroke();
	}

	static hideRightWall(x, y, width, height, rows, columns) {
		ctx.beginPath();
		ctx.strokeStyle = Constants.BG_COLOR;
		ctx.moveTo(x + width / columns + gridOffset, y + gridWidth);
		ctx.lineTo(
			x + width / columns + gridOffset,
			y + height / rows
		);
		ctx.stroke();
	}

	static hideLeftWall(x, y, height, rows) {
		ctx.beginPath();
		ctx.strokeStyle = Constants.BG_COLOR;
		ctx.moveTo(x + gridOffset, y + gridWidth);
		ctx.lineTo(x + gridOffset, y + height / rows);
		ctx.stroke();
	}

	// Walls render as hidden depending on boolean status in Cell object
	static renderWalls(walls, x, y, w, h, r, c) {
		if (walls.topWall == false)
			WallRenderer.hideTopWall(x, y, w, c);
		if (walls.bottomWall == false)
			WallRenderer.hideBottomWall(x, y, w, h, r, c);
		if (walls.rightWall == false)
			WallRenderer.hideRightWall(x, y, w, h, r, c);
		if (walls.leftWall == false)
			WallRenderer.hideLeftWall(x, y, h, r);
	}
}
