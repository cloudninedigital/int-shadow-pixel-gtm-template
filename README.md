# CND - Shadowpixel GTM Tag Template

The **Shadowpixel** custom tag template allows you to send a lightweight GET pixel to a specified endpoint with enhanced metadata from the dataLayer and browser context. It also supports optional live validation via cookie-driven logic.

---

## 📦 Download the Latest Version

You can download the latest `.tpl` export of the **Shadowpixel Tag Template** from the following link:

👉 [Download Shadowpixel Tag Template (.tpl)](https://yourdomain.com/path-to-tpl-file)  
_(replace with actual hosted link to your `.tpl` file)_

---

## 🚀 How to Install in Google Tag Manager

### Step 1: Import the Template
1. In GTM, go to **Templates** > **Tag Templates**.
2. Click **New**.
3. Select **"Import Template"** from the upper-right menu.
4. Upload the downloaded `.tpl` file.

---

## 🧩 How to Use the Tag in a Container

### Step 1: Create a New Tag
1. Go to **Tags** > **New**.
2. Choose **"CND - Shadowpixel"** under Tag Type.
3. Fill in the fields as described below.

### Step 2: Configure Fields

| Field | Description |
|-------|-------------|
| **Enter the Endpoint URL** | The base endpoint that will receive the pixel hit. **Example:** `https://collect.cloudninedigital.nl` |
| **Fill in the section** | A string representing the logical section of the site (e.g. `homepage`, `checkout`, `test`). |
| **Enter the predefined abbreviation for the domain** | A short domain identifier like `demo`, `eftweb`, or `nyp`. |
| **Enter the userAgent Custom Javascript file** | Provide a GTM variable (usually a Custom JavaScript variable) that returns `navigator.userAgent`. See below. |

---
## 🏷️ Domain Abbreviation Reference

Use this table to see what the abbrevation is of your specific domain

## 🏷️ Domain Abbreviation Reference

Use this table to see what the abbreviation is for your specific domain.

| Abbreviation | Full Domain         | Description                        |
|--------------|----------------------|------------------------------------|
| cc           | cc.example.com       | CC production website              |
| demo         | cloudnine.playground.com    | Demo/test environment              |
| eftapp       | efteling.com   | Efteling app production site       |
| eftweb       | efteling.com   | Efteling main website              |
| fd           | fd.nl       | FD production website              |
| gstar        | gstar.com    | G-Star production website          |
| hbm          | www.hbm-machines.com    | HBM production website             |
| hnkdv        | www.quickdrinks.com  | Heineken DOT Virto (Nigeria) production site    |
| hnkea        | www.mm.eazle.com    | Heineken Eazle (Myanmar) production   |
| hnkhy        | www.heishop.com.br    | Heineken Hybris (Brazil) production site |
| nyp          | www.newyorkpizza.nl     | New York Pizza production website        |
| pvhb2b       | www.TOBECHECKED.com  | PVH B2B production portal          |
| rai          | rai.nl      | RAI Amsterdam production website   |
| timing       | timing.nl   | Timing production environment      |
| vivara       | vivara.nl   | Vivara production website          |
| ziggo        | vodafoneziggo.com    | Vodafone Ziggo production environment       |




## :computer: How to Set Up the User Agent Variable

This tag expects the **User Agent** string to be passed via a **Custom JavaScript Variable** in GTM.

### How to create it:
1. Go to **Variables** > **New**.
2. Choose **Variable Type**: **Custom JavaScript**.
3. Name it something like `CJS - userAgent`.
4. Paste the following code:

```javascript
function() {
  return navigator.userAgent || "Not Available";
}
```

## ✅ Recommended Trigger

We recommend using the following Custom Event trigger to fire the tag on all custom events **except** system-generated `gtm.*` events:

### Trigger Setup:
- **Trigger Type:** Custom Event  
- **Event Name:** `^(?!gtm).*$`  
- ✅ Check **Use regex matching**

This ensures the tag only fires on your own dataLayer events and not on default GTM lifecycle events like `gtm.js`, `gtm.dom`, or `gtm.load`.


