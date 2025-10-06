# ⚡ Ezy-Bit - Real-Time Online Auction Web Application

[![Platform](https://img.shields.io/badge/platform-Web-brightgreen)]()
[![Backend](https://img.shields.io/badge/backend-Java%20EE-blue)]()
[![Technology](https://img.shields.io/badge/framework-EJB%20%7C%20JMS-orange)]()
[![Server](https://img.shields.io/badge/server-GlassFish-blue)]()
[![Communication](https://img.shields.io/badge/communication-WebSocket-lightgrey)]()
[![License](https://img.shields.io/badge/license-MIT-blue)]()

---

## 🏷️ Overview

**Ezy-Bit** is a **real-time online auction web application** built with **Enterprise Java (EE)** technologies.  
The system enables users to **participate in live auctions**, place **bids in real-time**, and view **instant bid updates** across all connected clients.  
It’s designed to handle **high concurrency**, **low latency**, and **complex auction logic**, ensuring fairness and accuracy in every bid.

---

## ✨ Features

- ⚡ **Real-time bidding system** with live price updates  
- 🧠 **Bid validation and automatic increment logic**  
- ⏱️ **Auction countdown timers** and status updates (OPEN / CLOSED)  
- 🌍 **Real-time broadcast using JMS Topics + WebSocket**  
- 👤 **Session-based user tracking** (no external database)  
- 🔁 **Asynchronous communication** between distributed components  
- 🧩 **Modular EJB architecture** for scalability and reusability  

---

## 🧱 Tech Stack

| Layer | Technology |
|--------|-------------|
| **Frontend** | JSP, HTML, CSS, JavaScript |
| **Backend** | Java EE (Servlets + EJB) |
| **Business Logic** | Enterprise JavaBeans (Singleton, Message-Driven Beans) |
| **Real-time Communication** | WebSocket, JMS (Topic-based) |
| **Server** | GlassFish Server |
| **Architecture** | MVC + Event-driven |

---

## ⚙️ How It Works

1. **Auction Initialization**
   - Auction items are initialized and managed by a **Singleton EJB**.
   - Each auction maintains its state (`OPEN`, `CLOSED`, `PENDING`).

2. **User Participation**
   - Users join auctions via **web sessions** (no database storage).  
   - Session information identifies unique participants.

3. **Bidding**
   - When a user places a bid, it is validated by an **EJB** (bid amount > current highest bid).
   - The system automatically handles bid increments.

4. **Real-Time Updates**
   - **JMS Topic** broadcasts the latest bid to all subscribers.  
   - **WebSocket** sends instant updates to each connected client.

5. **Auction End**
   - A **Timer Service (EJB)** automatically closes auctions at the end time.
   - Winner details are pushed to all clients in real time.

---

## 🧠 Core Concepts Used

- 🧩 EJB (Enterprise JavaBeans) — encapsulates business logic and concurrency management

- 💬 JMS (Topic-based Messaging) — asynchronous, event-driven communication

- 🌐 WebSocket API — live client updates (no refresh needed)

- ⏱️ Timer Service — automatic auction closing logic

- 🧠 Session Management — lightweight, no persistent database

---

## ⚙️ Requirements

- JDK 11+
- Payara Server
- JMS configured (default Payara broker)

---

## 📦 Installation & Run

- Clone the repository

  ````bash
  git clone https://github.com/savindi2003/ezybit.git
  ````
  
- Run on Server
- Access via browser:
  ````bash
  http://localhost:8080/EzyBit/
  ````

---

## 👩‍💻 Author
**Savindi Duleesha**  
📧 savindiduleesha@gmail.com  
🌐 [Portfolio](https://savindi2003.github.io/my-portfolio/)

---

## 📜 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.



