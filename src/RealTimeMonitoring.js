import React, { useState, useEffect } from "react";
import { Link } from "react-router-dom";
import Web3 from "web3";
import "./a.css";

const RealTimeMonitoring = () => {
    const [logs, setLogs] = useState([]);
    const ganacheURL = "http://127.0.0.1:7545"; // Ganache RPC URL

    useEffect(() => {
        const fetchLogs = async () => {
            try {
                const web3 = new Web3(new Web3.providers.HttpProvider(ganacheURL));
                const latestBlock = await web3.eth.getBlock("latest", true);

                if (latestBlock && latestBlock.transactions.length > 0) {
                    const newLogs = latestBlock.transactions.map((tx) => ({
                        hash: tx.hash,
                        from: tx.from,
                        to: tx.to,
                        value: web3.utils.fromWei(tx.value, "ether"),
                        gas: tx.gas,
                    }));
                    setLogs(newLogs);
                }
            } catch (error) {
                console.error("Error fetching logs:", error);
            }
        };

        fetchLogs();
        const interval = setInterval(fetchLogs, 5000); // Refresh logs every 5 seconds
        return () => clearInterval(interval);
    }, []);

    return (
        <div className="real-time-container">
            <h2 className="text-center">🔵 Real-Time Monitoring</h2>
            <div className="logs-container">
                {logs.length > 0 ? (
                    logs.map((log, index) => (
                        <div key={index} className="log-entry">
                            <p><strong>Tx Hash:</strong> {log.hash}</p>
                            <p><strong>From:</strong> {log.from}</p>
                            <p><strong>Value:</strong> {log.value} ETH</p>
                            <p><strong>Gas:</strong> {log.gas}</p>
                            <hr />
                        </div>
                    ))
                ) : (
                    <p>No transactions found.</p>
                )}
                
            </div>
            

            <Link to="/Graph">
                <button className="nav-btn"> Graph </button>
            </Link>
        </div>
    );
};

export default RealTimeMonitoring;
