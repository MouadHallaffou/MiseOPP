// // les voiielle d'une string::
// const stringe = "Hello World";
// const myfunction = (str) => {
//   const voiyelle = ["a", "e", "o", "i", "y", "u"];
//   let newstring = " ";
//   let count = 0;
//   for (let i = 0; i < str.length; i++) {
//     const char = str[i].toLowerCase();
//     for (let j = 0; j < voiyelle.length; j++) {
//       if (char === voiyelle[j]) {
//         newstring += char + " ";
//         count++;
//       }
//     }
//   }
//   return { Num: count, voil: newstring };
// };
// // console.log(myfunction(stringe));

// //lecture de deux face abba::
// const test = "ababa";
// const checking = (str) => {
//   for (let i = 0; i < str.length / 2; i++) {
//     if (str[i] !== str[str.length - 1 - i]) {
//       return false;
//     }
//   }
//   return true;
// };
// // console.log(checking(test));

// const isPalindrome = (str) => {
//   const reversed = str.split("").reverse().join("");
//   return str === reversed;
// };
// // console.log(isPalindrome(test));

// //inverse un chaine ::
// const inversing = (str) => {
//   const inversed = str.split("").reverse().join("");
//   return inversed;
// };
// // console.log(inversing(stringe));

// const inversedstring = (str) => {
//   let replace = " ";
//   for (let i = str.length - 1; i >= 0; i++) {
//     replace += str[i];
//   }
//   return replace;
// };
// // console.log(inversedstring(stringe));

// // Input : "abca"
// // Output : { a:2, b:1, c:1 }
// const input = "abca";
// const counting = (str) => {
//   const output = {};
//   for (let i = 0; i < str.length; i++) {
//     const char = str[i];
//     if (output[char]) {
//       output[char]++;
//     } else {
//       output[char] = 1;
//     }
//   }
//   return output;
// };
// // console.log(counting(input));

// // Input : "radar"
// // Output : true
// const tocote = (str) => {
//   for (let i = 0; i < str.length / 2; i++) {
//     if (str[i] !== str[str.length - 1 - i]) return false;
//   }
//   return true;
// };
// // console.log(tocote("radar"));

// // Input : "aabbcc"
// // Output : "abc"
// const supdouble = (str) => {
//   let string = "";
//   for (let i = 0; i < str.length; i++) {
//     if (!string.includes(str[i])) {
//       string += str[i];
//     }
//   }
//   return string;
// };
// // console.log(supdouble("abbcddbba"));

// // Input : "aabbbbcc"
// // Output : "b"
// const leplus = (str) => {
//   const freq = {};

//   for (let i = 0; i < str.length; i++) {
//     const char = str[i];
//     freq[char] = (freq[char] || 0) + 1;
//   }

//   let maxChar = "";
//   let maxCount = 0;

//   for (let char in freq) {
//     if (freq[char] > maxCount) {
//       maxCount = freq[char];
//       maxChar = char;
//     }
//   }

//   return { maxChar, maxCount };
// };
// console.log(leplus("aabcccccde"));

let table = [1, 2, 5, 8, 9, 14];
const plus = (tab) => {
    let max = 0;
    for (let i = 0; i < tab.length; i++) {
        if(tab[i] >max){
            max = tab[i];
        }
    }
    return max;
}
console.log(plus(table));





//affiche les donner dans un tableau::
const table2 = [1, 2, 5, 9, [3, 4, [2, 9, 8, [2, 1, 6], 5], 6], 8, 9, 14];

const myfunctions = (array) => {
  let new_table = [];
  for (let i = 0; i < array.length; i++) {
    if (Array.isArray(array[i])) {
      new_table.push(...myfunctions(array[i]));
    } else {
      new_table.push(array[i]);
    }
  }
  return new_table;
}

console.log(myfunctions(table2)); 
