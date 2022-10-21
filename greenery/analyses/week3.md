## Stakeholder Questions + Answers

### Conversion Rates

What is our overall conversion rate? **62.45**
```
SELECT 
    SUM(has_converted)/COUNT(has_converted)*100 AS overall_conversation_rate
FROM DEV_DB.DBT_HI.FACT_SESSIONS
```
What is our conversion rate by product? **Conversion rate is now in the dim_product table.**

Theoretically, Why might certain products be converting at higher/lower rates than others?
- **How product's value prop is expressed on the page. (Example: Plant thrives in shade and blooms annually.)**
- **Presence of social proof via reviews, photos and other social indicators.**
- **Alignment between the type of user brought to the page and the product's relevance to that user.**

### Macros

**Added macro to automatically generate event columns.** 

### Permissions

**Reporting role permissions added this week.**

### Packages

**I added a surrogate key to stg_order_items using the dbt_utils.surrogate_key macro. I then added a uniqueness test to that field.**

### Snapshots

The following orders have been updated since week 3:
- **8385cfcd-2b3f-443a-a676-9756f7eb5404**
- **e24985f3-2fb3-456e-a1aa-aaf88f490d70**
- **5741e351-3124-4de7-9dff-01a448e7dfd4**