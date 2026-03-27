# CND - Data Layer Monitor

This document explains how to implement the CND Data Layer Monitor. Follow the steps carefully to ensure correct setup and functioning.

---

## 1. Choose Your Implementation Type

You now have two options depending on your situation:

### Option 1: New Implementation (Full Setup)
Use this option if you are setting up the Data Layer Monitor from scratch.

- Download the file: **CND - Data Layer Monitor Full Implementation**
- This file contains all required tags, triggers, and variables

---

### Option 2: Update Existing Implementation (Template Only)
Use this option if you already have the Data Layer Monitor implemented and only want to update to the latest version.

- Download the file: **CND - Data Layer Monitor Template Only**
- This will update only the necessary components without affecting your full setup

---

## 2. Import the Workspace in Google Tag Manager

Once you have downloaded the correct file:

1. Open your GTM account and navigate to the correct container  
2. Click on **Admin**  
3. Under the **Container** section, select **Import Container**  
4. Upload the `.json` file  

### Recommended Settings

When importing, use the following settings:

- **Workspace**: Select **New**
- **Import option**: Select **Merge**
- **Conflict resolution**: Select **Overwrite conflicting tags, triggers and variables**

---

## 3. Configure the Correct `page_type`

The monitor uses the `page_type` data layer value to categorize events.

After importing:

- Locate variables or triggers that reference `page_type`  
- Ensure it is correctly set for each page  

### Example values:
- `home`  
- `product`  
- `checkout`  
- `confirmation`  

### If `page_type` is not available

If your data layer does **not** include a `page_type` parameter:

- You can leave this field **blank**  
- The Data Layer Monitor will still function correctly  
- Events will simply not be segmented by page type  

> 💡 Tip: Adding a `page_type` parameter is recommended for better insights and segmentation, but it is not required for the monitor to work.

---

## 4. Add the Client Abbreviation

Each implementation uses a client-specific abbreviation.

- Insert the provided abbreviation (e.g. **CND**, **eftweb** or **NYP**) into the tag configuration  
- If you don’t have it yet, request it from your Cloud Nine Digital contact  

This ensures consistency in tracking and reporting.

---

By following these steps, you will have a fully functioning **CND Data Layer Monitor** implementation that helps maintain data quality, detect issues early, and provide better visibility into your website's data layer interactions.

If you encounter any issues during setup, please refer to the troubleshooting section (if available) or contact the CND support team.

