import React, { useEffect, useRef, useState } from "react";
import { Bar } from "react-chartjs-2";
import Chart from "chart.js/auto";
import { CategoryScale } from "chart.js";
import html2canvas from "html2canvas";
import jsPDF from "jspdf";
import { Link } from "react-router-dom";
import "./Graph.css";

// Register Chart.js scale
Chart.register(CategoryScale);

// Function to determine severity score
const getSeverityScore = (issue) => {
    const severityMap = {
        "Reentrancy Attack": 95,
        "Integer Overflow": 90,
        "tx.origin Authentication Flaw": 85,
        "Denial of Service with Revert": 80,
        "Unprotected SELFDESTRUCT": 75,
        "Unchecked Call Return Value": 70,
        "Uninitialized Storage Pointer": 65,
        "Timestamp Dependency": 60,
        "Blockhash Dependency": 55,
        "Missing Event for Critical Function": 50,
        "Hardcoded Gas Amount": 45,
    };
    return severityMap[issue] || 30; // Default Low Severity
};

const Graph = ({ vulnerabilities, solidityCode }) => {
    const [chartData, setChartData] = useState(null);
    const graphRef = useRef();

    useEffect(() => {
        if (vulnerabilities.length > 0) {
            setChartData({
                labels: vulnerabilities.map((vuln) => `Line ${vuln.line}`),
                datasets: [
                    {
                        label: "Vulnerability Severity",
                        data: vulnerabilities.map((vuln) => getSeverityScore(vuln.issue)),
                        backgroundColor: vulnerabilities.map((vuln) =>
                            getSeverityScore(vuln.issue) >= 85
                                ? "rgba(255, 0, 0, 0.7)" // High severity (Red)
                                : getSeverityScore(vuln.issue) >= 60
                                ? "rgba(255, 165, 0, 0.7)" // Medium severity (Orange)
                                : "rgba(0, 128, 0, 0.7)" // Low severity (Green)
                        ),
                        borderColor: "rgba(0, 0, 0, 1)",
                        borderWidth: 2,
                    },
                ],
            });
        }
    }, [vulnerabilities]);

    // ✅ Generates PDF with Solidity Code, Severity Levels & Graph
    const generatePDF = async () => {
        const pdf = new jsPDF("p", "mm", "a4");
        pdf.setFontSize(16);
        pdf.text("🔒 Smart Contract Vulnerability Report", 10, 10);
        pdf.setFontSize(12);

        let yPos = 20;
        pdf.text("⚠️ Detected Vulnerabilities:", 10, yPos);
        yPos += 10;

        if (vulnerabilities.length === 0) {
            pdf.text("✅ No vulnerabilities found.", 10, yPos);
        } else {
            vulnerabilities.forEach((vuln, index) => {
                pdf.text(`${index + 1}. Line ${vuln.line}: ${vuln.issue} (Severity: ${getSeverityScore(vuln.issue)})`, 10, yPos);
                yPos += 10;
            });
        }

        // ✅ Add Solidity Code with Error Lines in Red
        yPos += 10;
        pdf.text("📜 Solidity Code (Uploaded):", 10, yPos);
        yPos += 10;

        if (solidityCode) {
            const lines = solidityCode.split("\n");
            lines.forEach((line, index) => {
                const isErrorLine = vulnerabilities.some(vuln => vuln.line === index + 1);
                if (isErrorLine) {
                    pdf.setTextColor(255, 0, 0); // 🔴 Red Color for Error Lines
                } else {
                    pdf.setTextColor(0, 0, 0); // ⚫ Default Black
                }
                pdf.text(`${index + 1}: ${line}`, 10, yPos);
                yPos += 7;
            });
            pdf.setTextColor(0, 0, 0); // Reset text color
        } else {
            pdf.text("⚠️ No Solidity code available.", 10, yPos);
        }

        // ✅ Add Graph Image
        if (graphRef.current) {
            try {
                const canvas = await html2canvas(graphRef.current, { scale: 1.5 });
                const imgData = canvas.toDataURL("image/png");

                pdf.addPage();
                pdf.text("📊 Vulnerability Graph:", 10, 10);
                pdf.addImage(imgData, "PNG", 10, 20, 180, 100);
            } catch (error) {
                console.error("Graph Capture Error:", error);
                pdf.text("Graph could not be captured.", 10, yPos + 10);
            }
        }

        pdf.save("Vulnerability_Report.pdf");
    };

    return (
        <div className="graph-container">
            <h2 className="graph-title">📊 Graphical Vulnerability Impact</h2>
            {chartData ? (
                <div ref={graphRef}>
                    <Bar data={chartData} />
                </div>
            ) : (
                <p className="no-data-message">✅ No vulnerabilities detected.</p>
            )}

            <button onClick={generatePDF} className="pdf-btn">📄 Download Report</button>
            <Link to="/">
                <button className="nav-btn">Back to Scanner</button>
            </Link>
        </div>
    );
};

export default Graph;
