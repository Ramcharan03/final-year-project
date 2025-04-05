import React, { useState } from "react";
import { BrowserRouter as Router, Routes, Route, Link } from "react-router-dom";
import "./App.css";
import RealTimeMonitoring from "./RealTimeMonitoring";
import Graph from "./Graph";
import Web3 from "web3";
import axios from "axios";

function App() {
    const [account, setAccount] = useState(null);
    const [file, setFile] = useState(null);
    const [vulnerabilities, setVulnerabilities] = useState([]);
    const [solidityCode, setSolidityCode] = useState("");
    const [scanned, setScanned] = useState(false);

    // ✅ Connect to MetaMask & Ganache
    const connectWallet = async () => {
        if (window.ethereum) {
            const web3 = new Web3(window.ethereum);
            try {
                await window.ethereum.request({ method: "eth_requestAccounts" });
                const accounts = await web3.eth.getAccounts();
                setAccount(accounts[0]);
            } catch (error) {
                console.error("Wallet connection failed", error);
            }
        } else {
            alert("Please install MetaMask!");
        }
    };

    // ✅ Handle File Upload
    const handleFileChange = async (event) => {
        const uploadedFile = event.target.files[0];
        setFile(uploadedFile);

        // Read the file content and store it
        const reader = new FileReader();
        reader.onload = (e) => {
            setSolidityCode(e.target.result);
        };
        reader.readAsText(uploadedFile);
    };

    // ✅ Scan File for Vulnerabilities
    const uploadFile = async () => {
        if (!file) return alert("Please upload a Solidity file!");

        const formData = new FormData();
        formData.append("solidityFile", file);

        try {
            const response = await axios.post("http://localhost:5000/upload", formData, {
                headers: { "Content-Type": "multipart/form-data" },
            });
            setVulnerabilities(response.data.vulnerabilities);
            setScanned(true); // ✅ Enables navigation to Real-Time Monitoring
        } catch (error) {
            console.error("Upload failed", error);
        }
    };

    return (
        <Router>
            <div className="App">
                <Routes>
                    {/* ✅ Upload & Scanning Page */}
                    <Route
                        path="/"
                        element={
                            <div className="scanner-container">
                                <h1>WEB3 SOLIDITY VULNERABILITY SCANNER</h1>

                                {!account ? (
                                    <button className="connect-wallet" onClick={connectWallet}>
                                        Connect Wallet
                                    </button>
                                ) : (
                                    <h4>Connected: {account}</h4>
                                )}

                                <input type="file" id="file-upload" onChange={handleFileChange} accept=".sol" />
                                <button className="scan-button" onClick={uploadFile}>
                                    Upload & Scan
                                </button>

                                <div className="vulnerability-report">
                                    <h2>Vulnerability Report:</h2>
                                    <ul>
                                        {vulnerabilities.length > 0 ? (
                                            vulnerabilities.map((vuln, index) => (
                                                <li key={index}>
                                                    ⚠️ <strong>Line {vuln.line}:</strong> {vuln.issue}
                                                </li>
                                            ))
                                        ) : (
                                            <li>No vulnerabilities detected</li>
                                        )}
                                    </ul>
                                </div>

                                {/* ✅ Shows "Go to Real-Time Monitoring" only after scanning */}
                                {scanned && (
                                    <Link to="/monitoring">
                                        <button className="nav-btn">📡 Real-Time Monitoring</button>
                                    </Link>
                                )}
                            </div>
                        }
                    />

                    {/* ✅ Real-Time Monitoring Page */}
                    <Route path="/monitoring" element={<RealTimeMonitoring />} />

                    {/* ✅ Graph Page (Now Includes Solidity Code & Error Highlighting) */}
                    <Route path="/graph" element={<Graph vulnerabilities={vulnerabilities} solidityCode={solidityCode} />} />
                </Routes>
            </div>
        </Router>
    );
}

export default App;
