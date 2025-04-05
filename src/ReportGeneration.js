'use client'; // Ensure this is a Client Component

import jsPDF from 'jspdf';
import html2canvas from 'html2canvas';
import React from 'react';

const ReportGeneration = () => {
    const generatePDF = () => {
        setTimeout(async () => { // Move async inside a separate function
            try {
                const element = document.getElementById('graph-container'); 
                if (!element) {
                    console.error('Graph container not found');
                    return;
                }

                const canvas = await html2canvas(element, {
                    scale: 1.5, 
                    useCORS: true, 
                    logging: true
                });

                let imgData = canvas.toDataURL('image/png');
                if (!imgData || imgData.length < 100) {
                    console.error('Captured image is invalid. Retrying...');
                    await new Promise((resolve) => setTimeout(resolve, 1000));
                    const retryCanvas = await html2canvas(element, { scale: 1.5, useCORS: true });
                    imgData = retryCanvas.toDataURL('image/png');
                }

                const pdf = new jsPDF();
                pdf.addImage(imgData, 'PNG', 10, 10, 180, 100);
                pdf.save('Vulnerability_Report.pdf');

            } catch (error) {
                console.error('Error generating PDF:', error);
            }
        }, 500); // Delay execution to ensure rendering completion
    };

    return (
        <div>
            <h2>Generate Report</h2>
            <button onClick={generatePDF}>Download PDF</button>
        </div>
    );
};

export default ReportGeneration;
