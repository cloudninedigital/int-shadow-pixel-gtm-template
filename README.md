# CND - Data Layer Monitor

This document explains how to implement the **CND Data Layer Monitor**. Follow the steps carefully to ensure correct setup and functioning.

## 1. Download the Latest CND Data Layer Monitor File

First, download the latest version of the CND Data Layer Monitor workspace file. This file typically comes in a `.json` format and contains all the necessary Google Tag Manager (GTM) tags, triggers, and variables to monitor your data layer events effectively.

**Where to download:**

- You may receive the file directly via email or download it from a shared repository or link provided by the CND team.
- Always ensure you have the latest version to benefit from bug fixes, optimizations, and new features.

## 2. Import the Workspace in GTM

Once you have the file, you need to import it into your Google Tag Manager container:

1. Open your GTM account and navigate to the correct container.
2. Click on **Admin** in the sidebar.
3. Under the **Container** section, select **Import Container**.
4. Upload the `.json` file you downloaded.
5. Choose to either:
   - **Add to existing workspace** (recommended if you want to merge with your current setup), or
   - **Overwrite** (only if you are setting up a brand new workspace).
6. When merging, ensure you **Rename conflicting tags, triggers, and variables** to avoid accidental overwriting of your current implementation.

## 3. Fill in the Correct Section (Page_Type)

The monitor uses the `page_type` data layer value to categorize events appropriately. After importing the workspace:

- Locate the relevant variables or triggers that reference `page_type`.
- Make sure the `page_type` is correctly set for each page you want to monitor.
- Examples of `page_type` values could be:
  - `home`
  - `product`
  - `checkout`
  - `confirmation`

Properly setting this ensures that events are segmented and tracked accurately across your website.

## 4. Enter the Correct Abbreviation (Example: CND)

All Data Layer Monitor implementations use a client-specific abbreviation. Please insert the provided abbreviation into the tag configuration.

If you have not yet received your abbreviation, please contact your Cloud Nine Digital consultant to obtain it.

Using the correct abbreviation ensures consistency and clarity in tracking and reporting.

## 5. Optional: Block GTM Events by Adding a Blocker

Sometimes, you might want to monitor data layer pushes without actually firing any GTM events.
To do this, you can implement a blocker:

1. Create a new **Trigger** in GTM, for example called **Block GTM Events**.
2. Set the trigger type to custom event
3. Add the following syntax: _^gtm.*_ . Check the 'Uses regex' box
4. Add this tag as a blocker on the _CND - Data Layer Monitor_ tag

This will block the Data Layer Monitor to sent events when the event has gtm in the name.

---

By following these steps, you will have a fully functioning **CND Data Layer Monitor** implementation that helps maintain data quality, detect issues early, and provide better visibility into your website's data layer interactions.

If you encounter any issues during setup, please refer to the troubleshooting section (if available) or contact the CND support team.

