// Define an interface for structured data
interface Person {
  name: string;
  age: number;
}

// Function with type annotations
export function greet(person: Person): string {
  return `Hello, ${person.name}! You are ${person.age} years old.`;
}

// Class definition (demonstrates object-oriented features)
export class Greeter {
  private message: string;

  constructor(message: string) {
    this.message = message;
  }

  public sayHello(target: string): string {
    return `${this.message}, ${target}!`;
  }
}

// Usage of the function and class
const user: Person = { name: "Alice", age: 30 };
console.log(greet(user));

const myGreeter = new Greeter("Greetings");
console.log(myGreeter.sayHello("TypeScript World"));

// Demonstrate a simple mathematical operation
export function add(a: number, b: number): number {
  return a + b;
}
console.log(`10 + 7 = ${add(10, 7)}`);
