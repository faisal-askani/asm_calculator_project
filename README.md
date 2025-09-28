# 🧮 Assembly Calculator

This is a simple **command-line calculator** written in **x86-64 Assembly (NASM)**.  
It supports basic arithmetic operations (`+`, `-`, `*`, `/`) and also a **quit option (`q`)**.  

The project is built for **Linux** using NASM and the included `util.asm` helper library (for input/output functions such as `printstr`, `printint`, `readint`, `readstr`, etc.).

---

## ✨ Features
- Read two integers from the user.
- Read an operator (`+`, `-`, `*`, `/`, or `q`).
- Perform the chosen arithmetic operation.
- Print the result.
- Print an error message and re-prompt if the user enters an invalid operator.
- Exit with `q`.

---

## 📂 Project Structure
- `calculator.asm` — Main calculator program  
- `util.asm` — Utility functions (I/O helpers)  

---

## 🔧 Requirements
- NASM assembler  
- Linux (tested on Ubuntu)  

---

## 🚀 Compile and Run

- Assemble calculator.asm into 64-bit object file c.o  
```bash
nasm -f elf64 calculator.asm -o c.o
```
- Link the object file into an executable named c_run
```bash
ld c.o -o c_run
```
- Run the calculator program
```bash         
./c_run
```
