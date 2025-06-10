import { greet, Greeter, add } from "../index";

describe("index.ts", () => {
    describe("greet", () => {
        it("should return a greeting string with name and age", () => {
            const person = { name: "Alice", age: 30 };
            const result = greet(person);
            expect(result).toBe("Hello, Alice! You are 30 years old.");
        });
    });

    describe("Greeter", () => {
        it("should correctly set the message in the constructor", () => {
            const greeterPublicTest = new Greeter("Public Test");
            expect(greeterPublicTest.sayHello("World")).toBe(
                "Public Test, World!",
            );
        });

        it("should return a correct greeting string using sayHello", () => {
            const greeter = new Greeter("Hi");
            const result = greeter.sayHello("TypeScript");
            expect(result).toBe("Hi, TypeScript!");
        });
    });

    describe("add", () => {
        it("should return the sum of two numbers", () => {
            const result = add(5, 7);
            expect(result).toBe(12);
        });

        it("should handle zero correctly", () => {
            const result = add(0, 10);
            expect(result).toBe(10);
        });

        it("should handle negative numbers", () => {
            const result = add(-5, 3);
            expect(result).toBe(-2);
        });
    });
});
