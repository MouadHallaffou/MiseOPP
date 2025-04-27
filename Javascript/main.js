// let tab1 = [1, 3, 4, 7];
// let tab2 = [5, 8, 2, 1, 4];

// const myfunction = (table1, table2) => {
//   let newtable = [];
//   let i;

//   // Concaténation manuelle
//   for (i = 0; i < table1.length; i++) {
//     newtable[i] = table1[i];
//   }
//   for (let j = 0; j < table2.length; j++) {
//     newtable[i + j] = table2[j];
//   }

//   // Tri (Bubble Sort)
//   for (let i = 0; i < newtable.length - 1; i++) {
//     for (let j = 0; j < newtable.length - 1 - i; j++) {
//       if (newtable[j] > newtable[j + 1]) {
//         let temp = newtable[j];
//         newtable[j] = newtable[j + 1];
//         newtable[j + 1] = temp;
//       }
//     }
//   }

//   // Suppression des doublons sans méthode prédéfinie
//   let uniqueTable = [];
//   for (let i = 0; i < newtable.length; i++) {
//     let isDuplicate = false;
//     for (let j = 0; j < uniqueTable.length; j++) {
//       if (newtable[i] === uniqueTable[j]) {
//         isDuplicate = true;
//         break;
//       }
//     }
//     if (!isDuplicate) {
//       uniqueTable[uniqueTable.length] = newtable[i];
//     }
//   }

//   return uniqueTable;
// };

// console.log(myfunction(tab1, tab2)); // [1, 2, 3, 4, 5, 7, 8]

// let tab1 = [1, 3, 4, 7];
// let tab2 = [5, 8, 2, 1, 4];

// const myfunction = (table1, table2) => {
//   // concatener les deux tableaux
//   let mergedTable = table1.concat(table2);
//   // trier le tableau
//   mergedTable.sort((a, b) => a - b);
//   // supprimer les doublons
//   mergedTable = mergedTable.filter((value, index) => {
//     return mergedTable.indexOf(value) === index;
//   });
//   return mergedTable;
// };

// console.log(myfunction(tab1, tab2)); // [1, 2, 3, 4, 5, 7, 8]

let tab1 = [1, 3, 4, 7];
let tab2 = [5, 8, 2, 1, 4];

const challenge = (table1, table2) => {
  let newTable = [];
  let i;
  for (i = 0; i < table1.length; i++) {
    newTable[i] = table1[i];
  }
  for (let j = 0; j < table2.length; j++) {
    newTable[i + j] = table2[j];
  }

  for (i = 0; i < newTable.length; i++) {
    for (let j = i + 1; j < newTable.length; j++) {
      if (newTable[i] > newTable[j]) {
        let temp = newTable[i];
        newTable[i] = newTable[j];
        newTable[j] = temp;
      }
    }
  }

  //   let unique = [];
  //   for (i = 0; i < newTable.length; i++) {
  //     let exists = false;
  //     for (let j = 0; j < unique.length; j++) {
  //         if(newTable[i] === unique[j]){
  //             exists = true;
  //             break;
  //         }
  //     }
  //     if (!exists) {
  //         unique[unique.length] = newTable[i]
  //     }
  //   }

  //   return unique;

  newTable = [...new Set(newTable)];
  return newTable;
};

// console.log(challenge(tab1, tab2));

// map:
let numbers = [1, 2, 3, 4, 5];
const multiple = (table) => {
  let newTable = table.map((ele) => ele * 3);
  return newTable;
};
// console.log(multiple(numbers));

// filter
let ages = [12, 18, 25, 8, 30, 16];
let filtred = ages.filter(function (ele, index, array) {
  return ele >= 18;
});
// console.log(filtred);

const filtred1 = (table) => {
  let newarr = table.filter((ele) => ele >= 18);
  return newarr;
};
// console.log(filtred1(ages));

//reduce:
let votes = ["oui", "non", "oui", "oui", "non", "oui", "non"];
const cumule = (table) => {
  let result = table.reduce((acc, val) => {
    if (acc[val]) {
      acc[val]++;
    } else {
      acc[val] = 1;
    }
    return acc;
  }, {});
  return result;
};
// console.log(cumule(votes));

// find()
let students = [
  { name: "Mouad", grade: 14 },
  { name: "Yassine", grade: 9 },
  { name: "Imane", grade: 17 },
  { name: "Sara", grade: 8 },
];
const finding = (table) => {
  let result = table.find((ele) => ele.grade < 10);
  return result;
};
// console.log(finding(students));

// includes()
let users = ["Mouad", "Yassine", "Imane", "Sara"];
let included = (table, name) => {
  let lowertable = table.map((ele) => ele.toLowerCase());
  return lowertable.includes(name.toLowerCase());
};
// console.log(included(users, 'mOuad'));

// findIndex()
let usersindex = [
  { name: "Mouad", age: 22 },
  { name: "Yassine", age: 17 },
  { name: "Sara", age: 30 },
];

let index = usersindex.findIndex((ele) => ele.age < 18);
// console.log(index);

const movies = [
  { title: "Inception", year: 2010, genre: "Science-fiction", collection: 800 },
  { title: "Titanic", year: 1997, genre: "Romance", collection: 2187 },
  { title: "Avengers", year: 2012, genre: "Action", collection: 1500 },
  {
    title: "Interstellar",
    year: 2014,
    genre: "Science-fiction",
    collection: 675,
  },
  { title: "The Notebook", year: 2004, genre: "Romance", collection: 150 },
  { title: "Mad Max: Fury Road", year: 2015, genre: "Action", collection: 378 },
];

const affiche = (table) => {
  let result = table.reduce((acc, movie) => {
    const { title, year, collection, genre } = movie;
    if (!acc[genre]) {
      acc[genre] = [];
    }
    acc[genre].push({ title, year, collection });
    return acc;
  }, {});
  return result;
};
// console.log(affiche(movies));

const userss = [
  { name: "Alice", subscription: 100 },
  { name: "Bob", subscription: 20 },
  { name: "Charlie", subscription: 12 },
];

const maxsub = userss.reduce((maxsubs, user) => {
  return maxsubs.subscription > user.subscription ? maxsubs : user;
});

// console.log(maxsub);

const stades = [
  {
    nom: "Stade Med V",
    prix: 50,
    sport: "Football",
    availability: true,
    subscriptions: 120,
  },
  {
    nom: "Santiago",
    prix: 70,
    sport: "Basketball",
    availability: true,
    subscriptions: 90,
  },
  {
    nom: "Old tradford",
    prix: 30,
    sport: "Football",
    availability: false,
    subscriptions: 200,
  },
  {
    nom: "Moulay Hassan",
    prix: 40,
    sport: "Tennis",
    availability: true,
    subscriptions: 60,
  },
  {
    nom: "Alkhayma",
    prix: 35,
    sport: "Natation",
    availability: true,
    subscriptions: 80,
  },
];

const getData = (
  table,
  sport,
  prix,
  conditionPrice = "<",
  availability = true
) => {
  let result = {};
  for (let i = 0; i < table.length; i++) {
    const stade = table[i];
    if (
      conditionPrice === "<" &&
      stade.prix < prix &&
      stade.sport === sport &&
      stade.availability === availability
    ) {
      if (!result[sport]) {
        result[sport] = [];
      }
      const { nom, prix, subscriptions } = stade;
      result[sport].push({ nom, prix, subscriptions });
    }
  }
  return result;
};
// console.log(getData(stades, "Tennis", 82));

const getDatas = (table,sporte,price,conditionPrice = "<",availability = true) => {
  let result = {};
  let stade = [];
  for (let i = 0; i < table.length; i++) {
    const { prix, sport, ...keys } = table[i];
    if (sporte === sport && keys.availability === availability) {
      if (conditionPrice === ">" && price > prix) {
        stade.push({...keys, prix});
        result[sport] = stade;
      }else if(conditionPrice === "<" && price < prix){
        stade.push({...keys, prix});
        result[sport] = stade;
      }
    }
  }
  return result;
};
console.log(getDatas(stades, "Football", 100 ,">"));


const data = [
  { nom: 'Stade A', prix: 50 },
  { nom: 'Stade B', prix: 60 },
  { nom: 'Stade C', prix: 50 },
];

 // 1: const grouped = Object.groupBy(data, std => std.prix);
 
 // 2:
const grouped = data.reduce((acc, std) => {
  (acc[std.prix] ||= []).push(std);
  return acc;
}, {});

console.log(grouped);

