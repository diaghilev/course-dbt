## Stakeholder Questions + Answers

### PART 1

What is our overall conversion rate? **62.45**
```
SELECT 
    SUM(has_converted)/COUNT(has_converted)*100 AS overall_conversation_rate
FROM DEV_DB.DBT_HI.FACT_SESSIONS
```
What is our conversion rate by product? **Coming soon**

Theoretically, Why might certain products be converting at higher/lower rates than others?
- **How the product's value prop is expressed on the page.**
- **Presence of social proof via reviews, photos and other indicators.**
- **Alignment between the type of user brought to the page and the product's relevance to that user.**