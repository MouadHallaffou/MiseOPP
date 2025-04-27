const numbers = [1, 2, 3, 4, 5];
// const sum = [in oneline]
// Output : 15

const sum = (array) => {
  let sum = 0;
  for (let i = 0; i < array.length; i++) {
    sum += array[i];
  }
  return sum;
};
// console.log(sum(numbers));

const sum1 = numbers.reduce((acc, sum) => acc + sum, 0);
// console.log(sum1);

const duplicates = [1, 2, 2, 3, 4, 4, 5];
// const unique = [in oneline]
// Output: [1, 2, 3, 4, 5]
const dup = (array) => {
  let new_arr = [];
  for (let i = 0; i < array.length; i++) {
    for (let j = 0; j < array.length; j++) {
      if (array[i] === array[j]) {
        if (!new_arr.includes(array[i])) {
          new_arr.push(array[i]);
        }
      }
    }
  }
  return new_arr;
};
const dups = new Set(duplicates);
const dupss = duplicates.reduce((acc, cur) => {
  if (!acc.includes(cur)) {
    acc.push(cur);
  }
  return acc;
}, []);

// console.log(dupss);
// console.log([...dups]);
// console.log(dup(duplicates));

const numberse = [1, 3, 2, 5, 4];
// const max = [in oneline];
// Output: 5
const max = (array) => {
  let max = 0;
  for (let index = 0; index < array.length; index++) {
    if (array[index] > max) {
      max = array[index];
    }
  }
  return max;
};
const maxe = numberse.reduce((acc, cur) => {
  return acc < cur ? cur : acc;
});
// console.log(maxe);
// console.log(max(numbers));

const fruits = ["banana", "apple", "orange", "grape"];
// ine oneline
// Output: ['apple', 'banana', 'grape', 'orange']
const sorted = fruits.sort();
const sortedinverse = fruits.sort((a, b) => b.localeCompare(a));
// console.log(sorted);
const sortede = (array) => {
  for (let i = 0; i < array.length - 1; i++) {
    for (let j = 0; j < array.length - 1 - i; j++) {
      if (array[j] < array[j + 1]) {
        let temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;
      }
    }
  }
  return array;
};
// console.log(sortede(fruits));

const numberses = [10, 20, 30, 40, 50];
//const index = (numbers, target) => [in oneline];
// Output: 2
const index = (array, numbre) => array.indexOf(numbre);
const indexFunction = (array, numbre) => {
  for (let i = 0; i < array.length; i++) {
    if (array[i] === numbre) {
      return i;
    }
  }
  return -1;
};
// console.log(index(numberses, 2));
// console.log(indexFunction(numberses,30));

// const calculateAverage = arr => [in oneline]
const numberr = [10, 20, 30, 40, 50];
// Output: 30
const calculateAverage = (array) => {
  let averge = 0;
  for (let i = 0; i < array.length / 2; i++) {
    averge = array[i];
  }
  return averge;
};
// console.log(calculateAverage(numberr));

// const mergeAndRemoveDuplicates = (arr1, arr2) => [in oneline]
const arr1 = [1, 2, 3];
const arr2 = [3, 4, 5];
// Output: [1, 2, 3, 4, 5]
const mergeAndRemoveDuplicates = (arr1, arr2) => {
  let array = [...arr1, ...arr2];
  let output = [];
  for (let i = 0; i < array.length - 1; i++) {
    for (let j = 0; j < array.length - 1 - i; j++) {
      if (array[j] > array[j + 1]) {
        let temp = array[j];
        array[j] = array[j + 1];
        array[j + 1] = temp;
      }
    }
  }
  for (let i = 0; i < array.length; i++) {
    if (array[i] !== array[i + 1]) {
      output.push(array[i]);
    }
  }
  return output;
};
// console.log(mergeAndRemoveDuplicates(arr1, arr2));

const mergeAndRemoveDuplicatese = (array1, array2) => {
  return [... new Set([...array1,...array2])].sort((a,b) => a-b)

};
// console.log(mergeAndRemoveDuplicatese(arr1, arr2));

// const areAllEven = arr => [in oneline]
const numbersse = [2, 4, 6, 8,9, 10];
// Output: true
const areAllEven = ( array) =>{
    for (let i = 0; i < array.length; i++) {
        if(array[i]%2 !== 0){
            return false
        }     
    }
    return true  
}
// console.log(areAllEven(numbersse));

// const countOccurrences = arr => [in oneline]
const fruitses = ['apple', 'banana', 'apple', 'orange', 'banana'];
// Output: { apple: 2, banana: 2, orange: 1 }
const countOccurrences = (array) => {
    const counts = {}; // objet pour stocker le résultat
    for (let i = 0; i < array.length; i++) {
      counts[array[i]] = (counts[array[i]] || 0) + 1;
    }
    return counts;
  };
const reducee = array => array.reduce((acc, cur) => (acc[cur] = (acc[cur] || 0) +1, acc) ,{});
// console.log(reducee(fruitses));
//console.log(countOccurrences(fruitses));
  

// const flattenArray = () => [in oneline]
const nestedArray = [[1, 2], [3, 4], [5, 6]];
// Output: [1, 2, 3, 4, 5, 6]
const flattenArray = (array) => {
    let output = []
    for (let i = 0; i < array.length; i++) {
        if(Array.isArray(array[i])){
            output.push(...array[i])
        }        
    }
    return output
}
console.log(flattenArray(nestedArray));
