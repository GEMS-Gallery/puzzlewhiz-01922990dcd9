import { backend } from 'declarations/backend';

const puzzleGrid = document.getElementById('puzzle-grid');
const newGameButton = document.getElementById('new-game');
const messageDiv = document.getElementById('message');

const SIZE = 3;

async function renderPuzzle() {
    const puzzle = await backend.getPuzzle();
    puzzleGrid.innerHTML = '';
    puzzle.forEach((num, index) => {
        const tile = document.createElement('div');
        tile.className = 'tile';
        tile.textContent = num === 0 ? '' : num;
        tile.addEventListener('click', () => makeMove(index));
        puzzleGrid.appendChild(tile);
    });
}

async function makeMove(index) {
    const moved = await backend.makeMove(index);
    if (moved) {
        await renderPuzzle();
        const solved = await backend.isSolved();
        if (solved) {
            messageDiv.textContent = 'Congratulations! You solved the puzzle!';
        }
    }
}

async function newGame() {
    await backend.newPuzzle();
    await renderPuzzle();
    messageDiv.textContent = '';
}

newGameButton.addEventListener('click', newGame);

// Initialize the game
newGame();
